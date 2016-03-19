#!/usr/bin/env python
#
# Copyright (c) 2005 Niels Provos <provos@citi.umich.edu>
# All rights reserved.
#
# Generates marshaling code based on libevent.

import sys
import re

#
_NAME = "event_rpcgen.py"
_VERSION = "0.1"
_STRUCT_RE = '[a-z][a-z_0-9]*'

# Globals
line_count = 0

white = re.compile(r'^\s+')
cppcomment = re.compile(r'\/\/.*$')
headerdirect = []
cppdirect = []

# Holds everything that makes a struct
class Struct:
    def __init__(self, name):
        self._name = name
        self._entries = []
        self._tags = {}
        print >>sys.stderr, '  Created struct: {0!s}'.format(name)

    def AddEntry(self, entry):
        if self._tags.has_key(entry.Tag()):
            print >>sys.stderr, ( 'Entry "%s" duplicates tag number '
                                  '%d from "%s" around line %d' ) % (
                entry.Name(), entry.Tag(),
                self._tags[entry.Tag()], line_count)
            sys.exit(1)
        self._entries.append(entry)
        self._tags[entry.Tag()] = entry.Name()
        print >>sys.stderr, '    Added entry: {0!s}'.format(entry.Name())

    def Name(self):
        return self._name

    def EntryTagName(self, entry):
        """Creates the name inside an enumeration for distinguishing data
        types."""
        name = "{0!s}_{1!s}".format(self._name, entry.Name())
        return name.upper()

    def PrintIdented(self, file, ident, code):
        """Takes an array, add indentation to each entry and prints it."""
        for entry in code:
            print >>file, '{0!s}{1!s}'.format(ident, entry)

    def PrintTags(self, file):
        """Prints the tag definitions for a structure."""
        print >>file, '/* Tag definition for {0!s} */'.format(self._name)
        print >>file, 'enum {0!s}_ {{'.format(self._name.lower())
        for entry in self._entries:
            print >>file, '  {0!s}={1:d},'.format(self.EntryTagName(entry),
                                        entry.Tag())
        print >>file, '  {0!s}_MAX_TAGS'.format((self._name.upper()))
        print >>file, '};\n'

    def PrintForwardDeclaration(self, file):
        print >>file, 'struct {0!s};'.format(self._name)

    def PrintDeclaration(self, file):
        print >>file, '/* Structure declaration for {0!s} */'.format(self._name)
        print >>file, 'struct {0!s}_access_ {{'.format(self._name)
        for entry in self._entries:
            dcl = entry.AssignDeclaration('(*{0!s}_assign)'.format(entry.Name()))
            dcl.extend(
                entry.GetDeclaration('(*{0!s}_get)'.format(entry.Name())))
            if entry.Array():
                dcl.extend(
                    entry.AddDeclaration('(*{0!s}_add)'.format(entry.Name())))
            self.PrintIdented(file, '  ', dcl)
        print >>file, '};\n'

        print >>file, 'struct {0!s} {{'.format(self._name)
        print >>file, '  struct {0!s}_access_ *base;\n'.format(self._name)
        for entry in self._entries:
            dcl = entry.Declaration()
            self.PrintIdented(file, '  ', dcl)
        print >>file, ''
        for entry in self._entries:
            print >>file, '  ev_uint8_t {0!s}_set;'.format(entry.Name())
        print >>file, '};\n'

        print >>file, \
"""struct {name!s} *{name!s}_new(void);
void {name!s}_free(struct {name!s} *);
void {name!s}_clear(struct {name!s} *);
void {name!s}_marshal(struct evbuffer *, const struct {name!s} *);
int {name!s}_unmarshal(struct {name!s} *, struct evbuffer *);
int {name!s}_complete(struct {name!s} *);
void evtag_marshal_{name!s}(struct evbuffer *, ev_uint32_t, 
    const struct {name!s} *);
int evtag_unmarshal_{name!s}(struct evbuffer *, ev_uint32_t,
    struct {name!s} *);""".format(**{ 'name' : self._name })


        # Write a setting function of every variable
        for entry in self._entries:
            self.PrintIdented(file, '', entry.AssignDeclaration(
                entry.AssignFuncName()))
            self.PrintIdented(file, '', entry.GetDeclaration(
                entry.GetFuncName()))
            if entry.Array():
                self.PrintIdented(file, '', entry.AddDeclaration(
                    entry.AddFuncName()))

        print >>file, '/* --- {0!s} done --- */\n'.format(self._name)

    def PrintCode(self, file):
        print >>file, ('/*\n'
                       ' * Implementation of %s\n'
                       ' */\n') % self._name

        print >>file, \
              'static struct {name!s}_access_ __{name!s}_base = {{'.format(** \
              { 'name' : self._name })
        for entry in self._entries:
            self.PrintIdented(file, '  ', entry.CodeBase())
        print >>file, '};\n'

        # Creation
        print >>file, (
            'struct %(name)s *\n'
            '%(name)s_new(void)\n'
            '{\n'
            '  struct %(name)s *tmp;\n'
            '  if ((tmp = malloc(sizeof(struct %(name)s))) == NULL) {\n'
            '    event_warn("%%s: malloc", __func__);\n'
            '    return (NULL);\n'
            '  }\n'
            '  tmp->base = &__%(name)s_base;\n') % { 'name' : self._name }

        for entry in self._entries:
            self.PrintIdented(file, '  ', entry.CodeNew('tmp'))
            print >>file, '  tmp->{0!s}_set = 0;\n'.format(entry.Name())

        print >>file, (
            '  return (tmp);\n'
            '}\n')

        # Adding
        for entry in self._entries:
            if entry.Array():
                self.PrintIdented(file, '', entry.CodeAdd())
            print >>file, ''
            
        # Assigning
        for entry in self._entries:
            self.PrintIdented(file, '', entry.CodeAssign())
            print >>file, ''

        # Getting
        for entry in self._entries:
            self.PrintIdented(file, '', entry.CodeGet())
            print >>file, ''
            
        # Clearing
        print >>file, ( 'void\n'
                        '%(name)s_clear(struct %(name)s *tmp)\n'
                        '{'
                        ) % { 'name' : self._name }
        for entry in self._entries:
            self.PrintIdented(file, '  ', entry.CodeClear('tmp'))

        print >>file, '}\n'

        # Freeing
        print >>file, ( 'void\n'
                        '%(name)s_free(struct %(name)s *tmp)\n'
                        '{'
                        ) % { 'name' : self._name }
        
        for entry in self._entries:
            self.PrintIdented(file, '  ', entry.CodeFree('tmp'))

        print >>file, ('  free(tmp);\n'
                       '}\n')

        # Marshaling
        print >>file, ('void\n'
                       '%(name)s_marshal(struct evbuffer *evbuf, '
                       'const struct %(name)s *tmp)'
                       '{') % { 'name' : self._name }
        for entry in self._entries:
            indent = '  '
            # Optional entries do not have to be set
            if entry.Optional():
                indent += '  '
                print >>file, '  if (tmp->{0!s}_set) {{'.format(entry.Name())
            self.PrintIdented(
                file, indent,
                entry.CodeMarshal('evbuf', self.EntryTagName(entry), 'tmp'))
            if entry.Optional():
                print >>file, '  }'

        print >>file, '}\n'
                       
        # Unmarshaling
        print >>file, ('int\n'
                       '%(name)s_unmarshal(struct %(name)s *tmp, '
                       ' struct evbuffer *evbuf)\n'
                       '{\n'
                       '  ev_uint32_t tag;\n'
                       '  while (EVBUFFER_LENGTH(evbuf) > 0) {\n'
                       '    if (evtag_peek(evbuf, &tag) == -1)\n'
                       '      return (-1);\n'
                       '    switch (tag) {\n'
                       ) % { 'name' : self._name }
        for entry in self._entries:
            print >>file, '      case {0!s}:\n'.format(self.EntryTagName(entry))
            if not entry.Array():
                print >>file, (
                    '        if (tmp->%s_set)\n'
                    '          return (-1);'
                    ) % (entry.Name())

            self.PrintIdented(
                file, '        ',
                entry.CodeUnmarshal('evbuf',
                                    self.EntryTagName(entry), 'tmp'))

            print >>file, ( '        tmp->{0!s}_set = 1;\n'.format(entry.Name()) +
                            '        break;\n' )
        print >>file, ( '      default:\n'
                        '        return -1;\n'
                        '    }\n'
                        '  }\n' )
        # Check if it was decoded completely
        print >>file, ( '  if (%(name)s_complete(tmp) == -1)\n'
                        '    return (-1);'
                        ) % { 'name' : self._name }

        # Successfully decoded
        print >>file, ( '  return (0);\n'
                        '}\n')

        # Checking if a structure has all the required data
        print >>file, (
            'int\n'
            '%(name)s_complete(struct %(name)s *msg)\n'
            '{' ) % { 'name' : self._name }
        for entry in self._entries:
            self.PrintIdented(
                file, '  ',
                entry.CodeComplete('msg'))
        print >>file, (
            '  return (0);\n'
            '}\n' )

        # Complete message unmarshaling
        print >>file, (
            'int\n'
            'evtag_unmarshal_%(name)s(struct evbuffer *evbuf, '
            'ev_uint32_t need_tag, struct %(name)s *msg)\n'
            '{\n'
            '  ev_uint32_t tag;\n'
            '  int res = -1;\n'
            '\n'
            '  struct evbuffer *tmp = evbuffer_new();\n'
            '\n'
            '  if (evtag_unmarshal(evbuf, &tag, tmp) == -1'
            ' || tag != need_tag)\n'
            '    goto error;\n'
            '\n'
            '  if (%(name)s_unmarshal(msg, tmp) == -1)\n'
            '    goto error;\n'
            '\n'
            '  res = 0;\n'
            '\n'
            ' error:\n'
            '  evbuffer_free(tmp);\n'
            '  return (res);\n'
            '}\n' ) % { 'name' : self._name }

        # Complete message marshaling
        print >>file, (
            'void\n'
            'evtag_marshal_%(name)s(struct evbuffer *evbuf, ev_uint32_t tag, '
            'const struct %(name)s *msg)\n'
            '{\n'
            '  struct evbuffer *_buf = evbuffer_new();\n'
            '  assert(_buf != NULL);\n'
            '  evbuffer_drain(_buf, -1);\n'
            '  %(name)s_marshal(_buf, msg);\n'
            '  evtag_marshal(evbuf, tag, EVBUFFER_DATA(_buf), '
            'EVBUFFER_LENGTH(_buf));\n'
            '  evbuffer_free(_buf);\n'
            '}\n' ) % { 'name' : self._name }

class Entry:
    def __init__(self, type, name, tag):
        self._type = type
        self._name = name
        self._tag = int(tag)
        self._ctype = type
        self._optional = 0
        self._can_be_array = 0
        self._array = 0
        self._line_count = -1
        self._struct = None
        self._refname = None

    def GetTranslation(self):
        return { "parent_name" : self._struct.Name(),
                 "name" : self._name,
                 "ctype" : self._ctype,
                 "refname" : self._refname
                 }
    
    def SetStruct(self, struct):
        self._struct = struct

    def LineCount(self):
        assert self._line_count != -1
        return self._line_count

    def SetLineCount(self, number):
        self._line_count = number

    def Array(self):
        return self._array

    def Optional(self):
        return self._optional

    def Tag(self):
        return self._tag

    def Name(self):
        return self._name

    def Type(self):
        return self._type

    def MakeArray(self, yes=1):
        self._array = yes
        
    def MakeOptional(self):
        self._optional = 1

    def GetFuncName(self):
        return '{0!s}_{1!s}_get'.format(self._struct.Name(), self._name)
    
    def GetDeclaration(self, funcname):
        code = [ 'int {0!s}(struct {1!s} *, {2!s} *);'.format(
            funcname, self._struct.Name(), self._ctype ) ]
        return code

    def CodeGet(self):
        code = (
            'int',
            '%(parent_name)s_%(name)s_get(struct %(parent_name)s *msg, '
            '%(ctype)s *value)',
            '{',
            '  if (msg->%(name)s_set != 1)',
            '    return (-1);',
            '  *value = msg->%(name)s_data;',
            '  return (0);',
            '}' )
        code = '\n'.join(code)
        code = code % self.GetTranslation()
        return code.split('\n')
        
    def AssignFuncName(self):
        return '{0!s}_{1!s}_assign'.format(self._struct.Name(), self._name)
    
    def AddFuncName(self):
        return '{0!s}_{1!s}_add'.format(self._struct.Name(), self._name)
    
    def AssignDeclaration(self, funcname):
        code = [ 'int {0!s}(struct {1!s} *, const {2!s});'.format(
            funcname, self._struct.Name(), self._ctype ) ]
        return code

    def CodeAssign(self):
        code = [ 'int',
                 '%(parent_name)s_%(name)s_assign(struct %(parent_name)s *msg,'
                 ' const %(ctype)s value)',
                 '{',
                 '  msg->%(name)s_set = 1;',
                 '  msg->%(name)s_data = value;',
                 '  return (0);',
                 '}' ]
        code = '\n'.join(code)
        code = code % self.GetTranslation()
        return code.split('\n')

    def CodeClear(self, structname):
        code = [ '{0!s}->{1!s}_set = 0;'.format(structname, self.Name()) ]

        return code
        
    def CodeComplete(self, structname):
        if self.Optional():
            return []
        
        code = [ 'if (!{0!s}->{1!s}_set)'.format(structname, self.Name()),
                 '  return (-1);' ]

        return code

    def CodeFree(self, name):
        return []

    def CodeBase(self):
        code = [
            '%(parent_name)s_%(name)s_assign,',
            '%(parent_name)s_%(name)s_get,'
            ]
        if self.Array():
            code.append('%(parent_name)s_%(name)s_add,')

        code = '\n'.join(code)
        code = code % self.GetTranslation()
        return code.split('\n')

    def Verify(self):
        if self.Array() and not self._can_be_array:
            print >>sys.stderr, (
                'Entry "%s" cannot be created as an array '
                'around line %d' ) % (self._name, self.LineCount())
            sys.exit(1)
        if not self._struct:
            print >>sys.stderr, (
                'Entry "%s" does not know which struct it belongs to '
                'around line %d' ) % (self._name, self.LineCount())
            sys.exit(1)
        if self._optional and self._array:
            print >>sys.stderr,  ( 'Entry "%s" has illegal combination of '
                                   'optional and array around line %d' ) % (
                self._name, self.LineCount() )
            sys.exit(1)

class EntryBytes(Entry):
    def __init__(self, type, name, tag, length):
        # Init base class
        Entry.__init__(self, type, name, tag)

        self._length = length
        self._ctype = 'ev_uint8_t'

    def GetDeclaration(self, funcname):
        code = [ 'int {0!s}(struct {1!s} *, {2!s} **);'.format(
            funcname, self._struct.Name(), self._ctype ) ]
        return code
        
    def AssignDeclaration(self, funcname):
        code = [ 'int {0!s}(struct {1!s} *, const {2!s} *);'.format(
            funcname, self._struct.Name(), self._ctype ) ]
        return code
        
    def Declaration(self):
        dcl  = ['ev_uint8_t {0!s}_data[{1!s}];'.format(self._name, self._length)]
        
        return dcl

    def CodeGet(self):
        name = self._name
        code = [ 'int',
                 '{0!s}_{1!s}_get(struct {2!s} *msg, {3!s} **value)'.format(
            self._struct.Name(), name,
            self._struct.Name(), self._ctype),
                 '{',
                 '  if (msg->{0!s}_set != 1)'.format(name),
                 '    return (-1);',
                 '  *value = msg->{0!s}_data;'.format(name),
                 '  return (0);',
                 '}' ]
        return code
        
    def CodeAssign(self):
        name = self._name
        code = [ 'int',
                 '{0!s}_{1!s}_assign(struct {2!s} *msg, const {3!s} *value)'.format(
            self._struct.Name(), name,
            self._struct.Name(), self._ctype),
                 '{',
                 '  msg->{0!s}_set = 1;'.format(name),
                 '  memcpy(msg->{0!s}_data, value, {1!s});'.format(
            name, self._length),
                 '  return (0);',
                 '}' ]
        return code
        
    def CodeUnmarshal(self, buf, tag_name, var_name):
        code = [  'if (evtag_unmarshal_fixed({0!s}, {1!s}, '.format(buf, tag_name) +
                  '{0!s}->{1!s}_data, '.format(var_name, self._name) +
                  'sizeof({0!s}->{1!s}_data)) == -1) {{'.format(
            var_name, self._name),
                  '  event_warnx("%s: failed to unmarshal {0!s}", __func__);'.format((
            self._name )),
                  '  return (-1);',
                  '}'
                  ]
        return code

    def CodeMarshal(self, buf, tag_name, var_name):
        code = ['evtag_marshal({0!s}, {1!s}, {2!s}->{3!s}_data, sizeof({4!s}->{5!s}_data));'.format(
            buf, tag_name, var_name, self._name, var_name, self._name )]
        return code

    def CodeClear(self, structname):
        code = [ '{0!s}->{1!s}_set = 0;'.format(structname, self.Name()),
                 'memset({0!s}->{1!s}_data, 0, sizeof({2!s}->{3!s}_data));'.format(
            structname, self._name, structname, self._name)]

        return code
        
    def CodeNew(self, name):
        code  = ['memset({0!s}->{1!s}_data, 0, sizeof({2!s}->{3!s}_data));'.format(
            name, self._name, name, self._name)]
        return code

    def Verify(self):
        if not self._length:
            print >>sys.stderr, 'Entry "{0!s}" needs a length around line {1:d}'.format(
                self._name, self.LineCount() )
            sys.exit(1)

        Entry.Verify(self)

class EntryInt(Entry):
    def __init__(self, type, name, tag):
        # Init base class
        Entry.__init__(self, type, name, tag)

        self._ctype = 'ev_uint32_t'

    def CodeUnmarshal(self, buf, tag_name, var_name):
        code = ['if (evtag_unmarshal_int({0!s}, {1!s}, &{2!s}->{3!s}_data) == -1) {{'.format(
            buf, tag_name, var_name, self._name),
                  '  event_warnx("%s: failed to unmarshal {0!s}", __func__);'.format((
            self._name )),
                '  return (-1);',
                '}' ] 
        return code

    def CodeMarshal(self, buf, tag_name, var_name):
        code = ['evtag_marshal_int({0!s}, {1!s}, {2!s}->{3!s}_data);'.format(
            buf, tag_name, var_name, self._name)]
        return code

    def Declaration(self):
        dcl  = ['ev_uint32_t {0!s}_data;'.format(self._name)]

        return dcl

    def CodeNew(self, name):
        code = ['{0!s}->{1!s}_data = 0;'.format(name, self._name)]
        return code

class EntryString(Entry):
    def __init__(self, type, name, tag):
        # Init base class
        Entry.__init__(self, type, name, tag)

        self._ctype = 'char *'

    def CodeAssign(self):
        name = self._name
        code = """int
{parent_name!s}_{name!s}_assign(struct {parent_name!s} *msg,
    const {ctype!s} value)
{{
  if (msg->{name!s}_data != NULL)
    free(msg->{name!s}_data);
  if ((msg->{name!s}_data = strdup(value)) == NULL)
    return (-1);
  msg->{name!s}_set = 1;
  return (0);
}}""".format(**self.GetTranslation())

        return code.split('\n')
        
    def CodeUnmarshal(self, buf, tag_name, var_name):
        code = ['if (evtag_unmarshal_string({0!s}, {1!s}, &{2!s}->{3!s}_data) == -1) {{'.format(
            buf, tag_name, var_name, self._name),
                '  event_warnx("%s: failed to unmarshal {0!s}", __func__);'.format((
            self._name )),
                '  return (-1);',
                '}'
                ]
        return code

    def CodeMarshal(self, buf, tag_name, var_name):
        code = ['evtag_marshal_string({0!s}, {1!s}, {2!s}->{3!s}_data);'.format(
            buf, tag_name, var_name, self._name)]
        return code

    def CodeClear(self, structname):
        code = [ 'if ({0!s}->{1!s}_set == 1) {{'.format(structname, self.Name()),
                 '  free ({0!s}->{1!s}_data);'.format(structname, self.Name()),
                 '  {0!s}->{1!s}_data = NULL;'.format(structname, self.Name()),
                 '  {0!s}->{1!s}_set = 0;'.format(structname, self.Name()),
                 '}'
                 ]

        return code
        
    def CodeNew(self, name):
        code  = ['{0!s}->{1!s}_data = NULL;'.format(name, self._name)]
        return code

    def CodeFree(self, name):
        code  = ['if ({0!s}->{1!s}_data != NULL)'.format(name, self._name),
                 '    free ({0!s}->{1!s}_data); '.format(name, self._name)]

        return code

    def Declaration(self):
        dcl  = ['char *{0!s}_data;'.format(self._name)]

        return dcl

class EntryStruct(Entry):
    def __init__(self, type, name, tag, refname):
        # Init base class
        Entry.__init__(self, type, name, tag)

        self._can_be_array = 1
        self._refname = refname
        self._ctype = 'struct {0!s}*'.format(refname)

    def CodeGet(self):
        name = self._name
        code = [ 'int',
                 '{0!s}_{1!s}_get(struct {2!s} *msg, {3!s} *value)'.format(
            self._struct.Name(), name,
            self._struct.Name(), self._ctype),
                 '{',
                 '  if (msg->{0!s}_set != 1) {{'.format(name),
                 '    msg->{0!s}_data = {1!s}_new();'.format(name, self._refname),
                 '    if (msg->{0!s}_data == NULL)'.format(name),
                 '      return (-1);',
                 '    msg->{0!s}_set = 1;'.format(name),
                 '  }',
                 '  *value = msg->{0!s}_data;'.format(name),
                 '  return (0);',
                 '}' ]
        return code
        
    def CodeAssign(self):
        name = self._name
        code = """int
{parent_name!s}_{name!s}_assign(struct {parent_name!s} *msg,
    const {ctype!s} value)
{{
   struct evbuffer *tmp = NULL;
   if (msg->{name!s}_set) {{
     {refname!s}_clear(msg->{name!s}_data);
     msg->{name!s}_set = 0;
   }} else {{
     msg->{name!s}_data = {refname!s}_new();
     if (msg->{name!s}_data == NULL) {{
       event_warn("%s: {refname!s}_new()", __func__);
       goto error;
     }}
   }}
   if ((tmp = evbuffer_new()) == NULL) {{
     event_warn("%s: evbuffer_new()", __func__);
     goto error;
   }}
   {refname!s}_marshal(tmp, value);
   if ({refname!s}_unmarshal(msg->{name!s}_data, tmp) == -1) {{
     event_warnx("%s: {refname!s}_unmarshal", __func__);
     goto error;
   }}
   msg->{name!s}_set = 1;
   evbuffer_free(tmp);
   return (0);
 error:
   if (tmp != NULL)
     evbuffer_free(tmp);
   if (msg->{name!s}_data != NULL) {{
     {refname!s}_free(msg->{name!s}_data);
     msg->{name!s}_data = NULL;
   }}
   return (-1);
}}""".format(**self.GetTranslation())
        return code.split('\n')
        
    def CodeComplete(self, structname):
        if self.Optional():
            code = [ 'if ({0!s}->{1!s}_set && {2!s}_complete({3!s}->{4!s}_data) == -1)'.format(
                structname, self.Name(),
                self._refname, structname, self.Name()),
                     '  return (-1);' ]
        else:
            code = [ 'if ({0!s}_complete({1!s}->{2!s}_data) == -1)'.format(
                self._refname, structname, self.Name()),
                     '  return (-1);' ]

        return code
    
    def CodeUnmarshal(self, buf, tag_name, var_name):
        code = ['{0!s}->{1!s}_data = {2!s}_new();'.format(
            var_name, self._name, self._refname),
                'if ({0!s}->{1!s}_data == NULL)'.format(var_name, self._name),
                '  return (-1);',
                'if (evtag_unmarshal_{0!s}({1!s}, {2!s}, {3!s}->{4!s}_data) == -1) {{'.format(
            self._refname, buf, tag_name, var_name, self._name),
                  '  event_warnx("%s: failed to unmarshal {0!s}", __func__);'.format((
            self._name )),
                '  return (-1);',
                '}'
                ]
        return code

    def CodeMarshal(self, buf, tag_name, var_name):
        code = ['evtag_marshal_{0!s}({1!s}, {2!s}, {3!s}->{4!s}_data);'.format(
            self._refname, buf, tag_name, var_name, self._name)]
        return code

    def CodeClear(self, structname):
        code = [ 'if ({0!s}->{1!s}_set == 1) {{'.format(structname, self.Name()),
                 '  {0!s}_free({1!s}->{2!s}_data);'.format(
            self._refname, structname, self.Name()),
                 '  {0!s}->{1!s}_data = NULL;'.format(structname, self.Name()),
                 '  {0!s}->{1!s}_set = 0;'.format(structname, self.Name()),
                 '}'
                 ]

        return code
        
    def CodeNew(self, name):
        code  = ['{0!s}->{1!s}_data = NULL;'.format(name, self._name)]
        return code

    def CodeFree(self, name):
        code  = ['if ({0!s}->{1!s}_data != NULL)'.format(name, self._name),
                 '    {0!s}_free({1!s}->{2!s}_data); '.format(
            self._refname, name, self._name)]

        return code

    def Declaration(self):
        dcl  = ['{0!s} {1!s}_data;'.format(self._ctype, self._name)]

        return dcl

class EntryVarBytes(Entry):
    def __init__(self, type, name, tag):
        # Init base class
        Entry.__init__(self, type, name, tag)

        self._ctype = 'ev_uint8_t *'

    def GetDeclaration(self, funcname):
        code = [ 'int {0!s}(struct {1!s} *, {2!s} *, ev_uint32_t *);'.format(
            funcname, self._struct.Name(), self._ctype ) ]
        return code
        
    def AssignDeclaration(self, funcname):
        code = [ 'int {0!s}(struct {1!s} *, const {2!s}, ev_uint32_t);'.format(
            funcname, self._struct.Name(), self._ctype ) ]
        return code
        
    def CodeAssign(self):
        name = self._name
        code = [ 'int',
                 '%s_%s_assign(struct %s *msg, '
                 'const %s value, ev_uint32_t len)' % (
            self._struct.Name(), name,
            self._struct.Name(), self._ctype),
                 '{',
                 '  if (msg->{0!s}_data != NULL)'.format(name),
                 '    free (msg->{0!s}_data);'.format(name),
                 '  msg->{0!s}_data = malloc(len);'.format(name),
                 '  if (msg->{0!s}_data == NULL)'.format(name),
                 '    return (-1);',
                 '  msg->{0!s}_set = 1;'.format(name),
                 '  msg->{0!s}_length = len;'.format(name),
                 '  memcpy(msg->{0!s}_data, value, len);'.format(name),
                 '  return (0);',
                 '}' ]
        return code
        
    def CodeGet(self):
        name = self._name
        code = [ 'int',
                 '{0!s}_{1!s}_get(struct {2!s} *msg, {3!s} *value, ev_uint32_t *plen)'.format(
            self._struct.Name(), name,
            self._struct.Name(), self._ctype),
                 '{',
                 '  if (msg->{0!s}_set != 1)'.format(name),
                 '    return (-1);',
                 '  *value = msg->{0!s}_data;'.format(name),
                 '  *plen = msg->{0!s}_length;'.format(name),
                 '  return (0);',
                 '}' ]
        return code

    def CodeUnmarshal(self, buf, tag_name, var_name):
        code = ['if (evtag_payload_length({0!s}, &{1!s}->{2!s}_length) == -1)'.format(
            buf, var_name, self._name),
                '  return (-1);',
                # We do not want DoS opportunities
                'if ({0!s}->{1!s}_length > EVBUFFER_LENGTH({2!s}))'.format(
            var_name, self._name, buf),
                '  return (-1);',
                'if (({0!s}->{1!s}_data = malloc({2!s}->{3!s}_length)) == NULL)'.format(
            var_name, self._name, var_name, self._name),
                '  return (-1);',
                'if (evtag_unmarshal_fixed(%s, %s, %s->%s_data, '
                '%s->%s_length) == -1) {' % (
            buf, tag_name, var_name, self._name, var_name, self._name),
                '  event_warnx("%s: failed to unmarshal {0!s}", __func__);'.format((
            self._name )),
                '  return (-1);',
                '}'
                ]
        return code

    def CodeMarshal(self, buf, tag_name, var_name):
        code = ['evtag_marshal({0!s}, {1!s}, {2!s}->{3!s}_data, {4!s}->{5!s}_length);'.format(
            buf, tag_name, var_name, self._name, var_name, self._name)]
        return code

    def CodeClear(self, structname):
        code = [ 'if ({0!s}->{1!s}_set == 1) {{'.format(structname, self.Name()),
                 '  free ({0!s}->{1!s}_data);'.format(structname, self.Name()),
                 '  {0!s}->{1!s}_data = NULL;'.format(structname, self.Name()),
                 '  {0!s}->{1!s}_length = 0;'.format(structname, self.Name()),
                 '  {0!s}->{1!s}_set = 0;'.format(structname, self.Name()),
                 '}'
                 ]

        return code
        
    def CodeNew(self, name):
        code  = ['{0!s}->{1!s}_data = NULL;'.format(name, self._name),
                 '{0!s}->{1!s}_length = 0;'.format(name, self._name) ]
        return code

    def CodeFree(self, name):
        code  = ['if ({0!s}->{1!s}_data != NULL)'.format(name, self._name),
                 '    free ({0!s}->{1!s}_data); '.format(name, self._name)]

        return code

    def Declaration(self):
        dcl  = ['ev_uint8_t *{0!s}_data;'.format(self._name),
                'ev_uint32_t {0!s}_length;'.format(self._name)]

        return dcl

class EntryArray(Entry):
    def __init__(self, entry):
        # Init base class
        Entry.__init__(self, entry._type, entry._name, entry._tag)

        self._entry = entry
        self._refname = entry._refname
        self._ctype = 'struct {0!s} *'.format(self._refname)

    def GetDeclaration(self, funcname):
        """Allows direct access to elements of the array."""
        translate = self.GetTranslation()
        translate["funcname"] = funcname
        code = [
            'int {funcname!s}(struct {parent_name!s} *, int, {ctype!s} *);'.format(**
            translate) ]
        return code
        
    def AssignDeclaration(self, funcname):
        code = [ 'int {0!s}(struct {1!s} *, int, const {2!s});'.format(
            funcname, self._struct.Name(), self._ctype ) ]
        return code
        
    def AddDeclaration(self, funcname):
        code = [ '{0!s} {1!s}(struct {2!s} *);'.format(
            self._ctype, funcname, self._struct.Name() ) ]
        return code
        
    def CodeGet(self):
        code = """int
{parent_name!s}_{name!s}_get(struct {parent_name!s} *msg, int offset,
    {ctype!s} *value)
{{
  if (!msg->{name!s}_set || offset < 0 || offset >= msg->{name!s}_length)
    return (-1);
  *value = msg->{name!s}_data[offset];
  return (0);
}}""".format(**self.GetTranslation())

        return code.split('\n')
        
    def CodeAssign(self):
        code = """int
{parent_name!s}_{name!s}_assign(struct {parent_name!s} *msg, int off,
    const {ctype!s} value)
{{
  struct evbuffer *tmp = NULL;
  if (!msg->{name!s}_set || off < 0 || off >= msg->{name!s}_length)
    return (-1);
  {refname!s}_clear(msg->{name!s}_data[off]);
  if ((tmp = evbuffer_new()) == NULL) {{
    event_warn("%s: evbuffer_new()", __func__);
    goto error;
  }}
  {refname!s}_marshal(tmp, value);
  if ({refname!s}_unmarshal(msg->{name!s}_data[off], tmp) == -1) {{
    event_warnx("%s: {refname!s}_unmarshal", __func__);
    goto error;
  }}
  evbuffer_free(tmp);
  return (0);
error:
  if (tmp != NULL)
    evbuffer_free(tmp);
  {refname!s}_clear(msg->{name!s}_data[off]);
  return (-1);
}}""".format(**self.GetTranslation())

        return code.split('\n')
        
    def CodeAdd(self):
        code = \
"""{ctype!s}
{parent_name!s}_{name!s}_add(struct {parent_name!s} *msg)
{{
  if (++msg->{name!s}_length >= msg->{name!s}_num_allocated) {{
    int tobe_allocated = msg->{name!s}_num_allocated;
    {ctype!s}* new_data = NULL;
    tobe_allocated = !tobe_allocated ? 1 : tobe_allocated << 1;
    new_data = ({ctype!s}*) realloc(msg->{name!s}_data,
        tobe_allocated * sizeof({ctype!s}));
    if (new_data == NULL)
      goto error;
    msg->{name!s}_data = new_data;
    msg->{name!s}_num_allocated = tobe_allocated;
  }}
  msg->{name!s}_data[msg->{name!s}_length - 1] = {refname!s}_new();
  if (msg->{name!s}_data[msg->{name!s}_length - 1] == NULL)
    goto error;
  msg->{name!s}_set = 1;
  return (msg->{name!s}_data[msg->{name!s}_length - 1]);
error:
  --msg->{name!s}_length;
  return (NULL);
}}
        """.format(**self.GetTranslation())

        return code.split('\n')

    def CodeComplete(self, structname):
        code = []
        translate = self.GetTranslation()

        if self.Optional():
            code.append( 'if ({structname!s}->{name!s}_set)'.format(**translate))

        translate["structname"] = structname
        tmp = """{{
  int i;
  for (i = 0; i < {structname!s}->{name!s}_length; ++i) {{
    if ({refname!s}_complete({structname!s}->{name!s}_data[i]) == -1)
      return (-1);
  }}
}}""".format(**translate)
        code.extend(tmp.split('\n'))

        return code
    
    def CodeUnmarshal(self, buf, tag_name, var_name):
        translate = self.GetTranslation()
        translate["var_name"] = var_name
        translate["buf"] = buf
        translate["tag_name"] = tag_name
        code = """if ({parent_name!s}_{name!s}_add({var_name!s}) == NULL)
  return (-1);
if (evtag_unmarshal_{refname!s}({buf!s}, {tag_name!s},
  {var_name!s}->{name!s}_data[{var_name!s}->{name!s}_length - 1]) == -1) {{
  --{var_name!s}->{name!s}_length;
  event_warnx("%s: failed to unmarshal {name!s}", __func__);
  return (-1);
}}""".format(**translate)

        return code.split('\n')

    def CodeMarshal(self, buf, tag_name, var_name):
        code = ['{',
                '  int i;',
                '  for (i = 0; i < {0!s}->{1!s}_length; ++i) {{'.format(
            var_name, self._name),
                '    evtag_marshal_{0!s}({1!s}, {2!s}, {3!s}->{4!s}_data[i]);'.format(
            self._refname, buf, tag_name, var_name, self._name),
                '  }',
                '}'
                ]
        return code

    def CodeClear(self, structname):
        code = [ 'if ({0!s}->{1!s}_set == 1) {{'.format(structname, self.Name()),
                 '  int i;',
                 '  for (i = 0; i < {0!s}->{1!s}_length; ++i) {{'.format(
            structname, self.Name()),
                 '    {0!s}_free({1!s}->{2!s}_data[i]);'.format(
            self._refname, structname, self.Name()),
                 '  }',
                 '  free({0!s}->{1!s}_data);'.format(structname, self.Name()),
                 '  {0!s}->{1!s}_data = NULL;'.format(structname, self.Name()),
                 '  {0!s}->{1!s}_set = 0;'.format(structname, self.Name()),
                 '  {0!s}->{1!s}_length = 0;'.format(structname, self.Name()),
                 '  {0!s}->{1!s}_num_allocated = 0;'.format(structname, self.Name()),
                 '}'
                 ]

        return code
        
    def CodeNew(self, name):
        code  = ['{0!s}->{1!s}_data = NULL;'.format(name, self._name),
                 '{0!s}->{1!s}_length = 0;'.format(name, self._name),
                 '{0!s}->{1!s}_num_allocated = 0;'.format(name, self._name)]
        return code

    def CodeFree(self, name):
        code  = ['if ({0!s}->{1!s}_data != NULL) {{'.format(name, self._name),
                 '  int i;',
                 '  for (i = 0; i < {0!s}->{1!s}_length; ++i) {{'.format(
            name, self._name),
                 '    {0!s}_free({1!s}->{2!s}_data[i]); '.format(
            self._refname, name, self._name),
                 '    {0!s}->{1!s}_data[i] = NULL;'.format(name, self._name),
                 '  }',
                 '  free({0!s}->{1!s}_data);'.format(name, self._name),
                 '  {0!s}->{1!s}_data = NULL;'.format(name, self._name),
                 '  {0!s}->{1!s}_length = 0;'.format(name, self._name),
                 '  {0!s}->{1!s}_num_allocated = 0;'.format(name, self._name),
                 '}'
                 ]

        return code

    def Declaration(self):
        dcl  = ['struct {0!s} **{1!s}_data;'.format(self._refname, self._name),
                'int {0!s}_length;'.format(self._name),
                'int {0!s}_num_allocated;'.format(self._name) ]

        return dcl

def NormalizeLine(line):
    global white
    global cppcomment
    
    line = cppcomment.sub('', line)
    line = line.strip()
    line = white.sub(' ', line)

    return line

def ProcessOneEntry(newstruct, entry):
    optional = 0
    array = 0
    entry_type = ''
    name = ''
    tag = ''
    tag_set = None
    separator = ''
    fixed_length = ''

    tokens = entry.split(' ')
    while tokens:
        token = tokens[0]
        tokens = tokens[1:]

        if not entry_type:
            if not optional and token == 'optional':
                optional = 1
                continue

            if not array and token == 'array':
                array = 1
                continue

        if not entry_type:
            entry_type = token
            continue

        if not name:
            res = re.match(r'^([^\[\]]+)(\[.*\])?$', token)
            if not res:
                print >>sys.stderr, 'Cannot parse name: \"{0!s}\" around {1:d}'.format(
                    entry, line_count)
                sys.exit(1)
            name = res.group(1)
            fixed_length = res.group(2)
            if fixed_length:
                fixed_length = fixed_length[1:-1]
            continue

        if not separator:
            separator = token
            if separator != '=':
                print >>sys.stderr, 'Expected "=" after name \"{0!s}\" got {1!s}'.format(
                    name, token)
                sys.exit(1)
            continue

        if not tag_set:
            tag_set = 1
            if not re.match(r'^(0x)?[0-9]+$', token):
                print >>sys.stderr, 'Expected tag number: \"{0!s}\"'.format(entry)
                sys.exit(1)
            tag = int(token, 0)
            continue

        print >>sys.stderr, 'Cannot parse \"{0!s}\"'.format(entry)
        sys.exit(1)

    if not tag_set:
        print >>sys.stderr, 'Need tag number: \"{0!s}\"'.format(entry)
        sys.exit(1)

    # Create the right entry
    if entry_type == 'bytes':
        if fixed_length:
            newentry = EntryBytes(entry_type, name, tag, fixed_length)
        else:
            newentry = EntryVarBytes(entry_type, name, tag)
    elif entry_type == 'int' and not fixed_length:
        newentry = EntryInt(entry_type, name, tag)
    elif entry_type == 'string' and not fixed_length:
        newentry = EntryString(entry_type, name, tag)
    else:
        res = re.match(r'^struct\[({0!s})\]$'.format(_STRUCT_RE),
                       entry_type, re.IGNORECASE)
        if res:
            # References another struct defined in our file
            newentry = EntryStruct(entry_type, name, tag, res.group(1))
        else:
            print >>sys.stderr, 'Bad type: "{0!s}" in "{1!s}"'.format(entry_type, entry)
            sys.exit(1)

    structs = []
        
    if optional:
        newentry.MakeOptional()
    if array:
        newentry.MakeArray()

    newentry.SetStruct(newstruct)
    newentry.SetLineCount(line_count)
    newentry.Verify()

    if array:
        # We need to encapsulate this entry into a struct
        newname = newentry.Name()+ '_array'

        # Now borgify the new entry.
        newentry = EntryArray(newentry)
        newentry.SetStruct(newstruct)
        newentry.SetLineCount(line_count)
        newentry.MakeArray()

    newstruct.AddEntry(newentry)

    return structs

def ProcessStruct(data):
    tokens = data.split(' ')

    # First three tokens are: 'struct' 'name' '{'
    newstruct = Struct(tokens[1])

    inside = ' '.join(tokens[3:-1])

    tokens = inside.split(';')

    structs = []

    for entry in tokens:
        entry = NormalizeLine(entry)
        if not entry:
            continue

        # It's possible that new structs get defined in here
        structs.extend(ProcessOneEntry(newstruct, entry))

    structs.append(newstruct)
    return structs

def GetNextStruct(file):
    global line_count
    global cppdirect

    got_struct = 0

    processed_lines = []

    have_c_comment = 0
    data = ''
    while 1:
        line = file.readline()
        if not line:
            break
        
        line_count += 1
        line = line[:-1]

        if not have_c_comment and re.search(r'/\*', line):
            if re.search(r'/\*.*\*/', line):
                line = re.sub(r'/\*.*\*/', '', line)
            else:
                line = re.sub(r'/\*.*$', '', line)
                have_c_comment = 1

        if have_c_comment:
            if not re.search(r'\*/', line):
                continue
            have_c_comment = 0
            line = re.sub(r'^.*\*/', '', line)

        line = NormalizeLine(line)

        if not line:
            continue

        if not got_struct:
            if re.match(r'#include ["<].*[>"]', line):
                cppdirect.append(line)
                continue
            
            if re.match(r'^#(if( |def)|endif)', line):
                cppdirect.append(line)
                continue

            if re.match(r'^#define', line):
                headerdirect.append(line)
                continue

            if not re.match(r'^struct {0!s} {{$'.format(_STRUCT_RE),
                            line, re.IGNORECASE):
                print >>sys.stderr, 'Missing struct on line {0:d}: {1!s}'.format(
                    line_count, line)
                sys.exit(1)
            else:
                got_struct = 1
                data += line
            continue

        # We are inside the struct
        tokens = line.split('}')
        if len(tokens) == 1:
            data += ' ' + line
            continue

        if len(tokens[1]):
            print >>sys.stderr, 'Trailing garbage after struct on line {0:d}'.format((
                line_count ))
            sys.exit(1)

        # We found the end of the struct
        data += ' {0!s}}}'.format(tokens[0])
        break

    # Remove any comments, that might be in there
    data = re.sub(r'/\*.*\*/', '', data)
    
    return data
        

def Parse(file):
    """
    Parses the input file and returns C code and corresponding header file.
    """

    entities = []

    while 1:
        # Just gets the whole struct nicely formatted
        data = GetNextStruct(file)

        if not data:
            break

        entities.extend(ProcessStruct(data))

    return entities

def GuardName(name):
    name = '_'.join(name.split('.'))
    name = '_'.join(name.split('/'))
    guard = '_'+name.upper()+'_'

    return guard

def HeaderPreamble(name):
    guard = GuardName(name)
    pre = (
        '/*\n'
        ' * Automatically generated from %s\n'
        ' */\n\n'
        '#ifndef %s\n'
        '#define %s\n\n' ) % (
        name, guard, guard)

    # insert stdint.h - let's hope everyone has it
    pre += (
        '#include <event-config.h>\n'
        '#ifdef _EVENT_HAVE_STDINT_H\n'
        '#include <stdint.h>\n'
        '#endif\n' )

    for statement in headerdirect:
        pre += '{0!s}\n'.format(statement)
    if headerdirect:
        pre += '\n'

    pre += (
        '#define EVTAG_HAS(msg, member) ((msg)->member##_set == 1)\n'
        '#ifdef __GNUC__\n'
        '#define EVTAG_ASSIGN(msg, member, args...) '
        '(*(msg)->base->member##_assign)(msg, ## args)\n'
        '#define EVTAG_GET(msg, member, args...) '
        '(*(msg)->base->member##_get)(msg, ## args)\n'
        '#else\n'
        '#define EVTAG_ASSIGN(msg, member, ...) '
        '(*(msg)->base->member##_assign)(msg, ## __VA_ARGS__)\n'
        '#define EVTAG_GET(msg, member, ...) '
        '(*(msg)->base->member##_get)(msg, ## __VA_ARGS__)\n'
        '#endif\n'
        '#define EVTAG_ADD(msg, member) (*(msg)->base->member##_add)(msg)\n'
        '#define EVTAG_LEN(msg, member) ((msg)->member##_length)\n'
        )

    return pre
     

def HeaderPostamble(name):
    guard = GuardName(name)
    return '#endif  /* {0!s} */'.format(guard)

def BodyPreamble(name):
    global _NAME
    global _VERSION
    
    header_file = '.'.join(name.split('.')[:-1]) + '.gen.h'

    pre = ( '/*\n'
            ' * Automatically generated from %s\n'
            ' * by %s/%s.  DO NOT EDIT THIS FILE.\n'
            ' */\n\n' ) % (name, _NAME, _VERSION)
    pre += ( '#include <sys/types.h>\n'
             '#ifdef _EVENT_HAVE_SYS_TIME_H\n'
             '#include <sys/time.h>\n'
             '#endif\n'
             '#include <stdlib.h>\n'
             '#include <string.h>\n'
             '#include <assert.h>\n'
             '#define EVENT_NO_STRUCT\n'
             '#include <event.h>\n\n'
             '#ifdef _EVENT___func__\n'
             '#define __func__ _EVENT___func__\n'
             '#endif\n' )

    for statement in cppdirect:
        pre += '{0!s}\n'.format(statement)
    
    pre += '\n#include "{0!s}"\n\n'.format(header_file)

    pre += 'void event_err(int eval, const char *fmt, ...);\n'
    pre += 'void event_warn(const char *fmt, ...);\n'
    pre += 'void event_errx(int eval, const char *fmt, ...);\n'
    pre += 'void event_warnx(const char *fmt, ...);\n\n'

    return pre

def main(argv):
    if len(argv) < 2 or not argv[1]:
        print >>sys.stderr, 'Need RPC description file as first argument.'
        sys.exit(1)

    filename = argv[1]

    ext = filename.split('.')[-1]
    if ext != 'rpc':
        print >>sys.stderr, 'Unrecognized file extension: {0!s}'.format(ext)
        sys.exit(1)

    print >>sys.stderr, 'Reading \"{0!s}\"'.format(filename)

    fp = open(filename, 'r')
    entities = Parse(fp)
    fp.close()

    header_file = '.'.join(filename.split('.')[:-1]) + '.gen.h'
    impl_file = '.'.join(filename.split('.')[:-1]) + '.gen.c'

    print >>sys.stderr, '... creating "{0!s}"'.format(header_file)
    header_fp = open(header_file, 'w')
    print >>header_fp, HeaderPreamble(filename)

    # Create forward declarations: allows other structs to reference
    # each other
    for entry in entities:
        entry.PrintForwardDeclaration(header_fp)
    print >>header_fp, ''

    for entry in entities:
        entry.PrintTags(header_fp)
        entry.PrintDeclaration(header_fp)
    print >>header_fp, HeaderPostamble(filename)
    header_fp.close()

    print >>sys.stderr, '... creating "{0!s}"'.format(impl_file)
    impl_fp = open(impl_file, 'w')
    print >>impl_fp, BodyPreamble(filename)
    for entry in entities:
        entry.PrintCode(impl_fp)
    impl_fp.close()

if __name__ == '__main__':
    main(sys.argv)
