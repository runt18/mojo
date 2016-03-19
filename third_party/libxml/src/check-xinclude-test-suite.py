#!/usr/bin/python
import sys
import time
import os
import string
sys.path.insert(0, "python")
import libxml2

#
# the testsuite description
#
DIR="xinclude-test-suite"
CONF="testdescr.xml"
LOG="check-xinclude-test-suite.log"

log = open(LOG, "w")

os.chdir(DIR)

test_nr = 0
test_succeed = 0
test_failed = 0
test_error = 0
#
# Error and warning handlers
#
error_nr = 0
error_msg = ''

def errorHandler(ctx, str):
    global error_nr
    global error_msg

    if string.find(str, "error:") >= 0:
	error_nr = error_nr + 1
    if len(error_msg) < 300:
        if len(error_msg) == 0 or error_msg[-1] == '\n':
	    error_msg = error_msg + "   >>" + str
	else:
	    error_msg = error_msg + str

libxml2.registerErrorHandler(errorHandler, None)

def testXInclude(filename, id):
    global error_nr
    global error_msg
    global log

    error_nr = 0
    error_msg = ''

    print "testXInclude({0!s}, {1!s})".format(filename, id)
    return 1

def runTest(test, basedir):
    global test_nr
    global test_failed
    global test_error
    global test_succeed
    global error_msg
    global log

    fatal_error = 0
    uri = test.prop('href')
    id = test.prop('id')
    type = test.prop('type')
    if uri == None:
        print "Test without ID:", uri
	return -1
    if id == None:
        print "Test without URI:", id
	return -1
    if type == None:
        print "Test without URI:", id
	return -1
    if basedir != None:
	URI = basedir + "/" + uri
    else:
        URI = uri
    if os.access(URI, os.R_OK) == 0:
        print "Test {0!s} missing: base {1!s} uri {2!s}".format(URI, basedir, uri)
	return -1

    expected = None
    outputfile = None
    diff = None
    if type != 'error':
	output = test.xpathEval('string(output)')
	if output == 'No output file.':
	    output = None
	if output == '':
	    output = None
	if output != None:
	    if basedir != None:
		output = basedir + "/" + output
	    if os.access(output, os.R_OK) == 0:
		print "Result for {0!s} missing: {1!s}".format(id, output)
		output = None
	    else:
		try:
		    f = open(output)
		    expected = f.read()
		    outputfile = output
		except:
		    print "Result for {0!s} unreadable: {1!s}".format(id, output)

    try:
        # print "testing %s" % (URI)
	doc = libxml2.parseFile(URI)
    except:
        doc = None
    if doc != None:
        res = doc.xincludeProcess()
	if res >= 0 and expected != None:
	    result = doc.serialize()
	    if result != expected:
	        print "Result for {0!s} differs".format((id))
		open("xinclude.res", "w").write(result)
		diff = os.popen("diff {0!s} xinclude.res".format(outputfile)).read()

	doc.freeDoc()
    else:
        print "Failed to parse {0!s}".format((URI))
	res = -1

    

    test_nr = test_nr + 1
    if type == 'success':
	if res > 0:
	    test_succeed = test_succeed + 1
	elif res == 0:
	    test_failed = test_failed + 1
	    print "Test {0!s}: no substitution done ???".format((id))
	elif res < 0:
	    test_error = test_error + 1
	    print "Test {0!s}: failed valid XInclude processing".format((id))
    elif type == 'error':
	if res > 0:
	    test_error = test_error + 1
	    print "Test {0!s}: failed to detect invalid XInclude processing".format((id))
	elif res == 0:
	    test_failed = test_failed + 1
	    print "Test {0!s}: Invalid but no substitution done".format((id))
	elif res < 0:
	    test_succeed = test_succeed + 1
    elif type == 'optional':
	if res > 0:
	    test_succeed = test_succeed + 1
	else:
	    print "Test {0!s}: failed optional test".format((id))

    # Log the ontext
    if res != 1:
	log.write("Test ID {0!s}\n".format((id)))
	log.write("   File: {0!s}\n".format((URI)))
	content = string.strip(test.content)
	while content[-1] == '\n':
	    content = content[0:-1]
	log.write("   {0!s}:{1!s}\n\n".format(type, content))
	if error_msg != '':
	    log.write("   ----\n{0!s}   ----\n".format((error_msg)))
	    error_msg = ''
	log.write("\n")
    if diff != None:
        log.write("diff from test {0!s}:\n".format((id)))
	log.write("   -----------\n{0!s}\n   -----------\n".format((diff)));

    return 0
	    

def runTestCases(case):
    creator = case.prop('creator')
    if creator != None:
	print "=>", creator
    base = case.getBase(None)
    basedir = case.prop('basedir')
    if basedir != None:
	base = libxml2.buildURI(basedir, base)
    test = case.children
    while test != None:
        if test.name == 'testcase':
	    runTest(test, base)
	if test.name == 'testcases':
	    runTestCases(test)
        test = test.next
        
conf = libxml2.parseFile(CONF)
if conf == None:
    print "Unable to load {0!s}".format(CONF)
    sys.exit(1)

testsuite = conf.getRootElement()
if testsuite.name != 'testsuite':
    print "Expecting TESTSUITE root element: aborting"
    sys.exit(1)

profile = testsuite.prop('PROFILE')
if profile != None:
    print profile

start = time.time()

case = testsuite.children
while case != None:
    if case.name == 'testcases':
	old_test_nr = test_nr
	old_test_succeed = test_succeed
	old_test_failed = test_failed
	old_test_error = test_error
        runTestCases(case)
	print "   Ran {0:d} tests: {1:d} suceeded, {2:d} failed and {3:d} generated an error".format(
	       test_nr - old_test_nr, test_succeed - old_test_succeed,
	       test_failed - old_test_failed, test_error - old_test_error)
    case = case.next

conf.freeDoc()
log.close()

print "Ran {0:d} tests: {1:d} suceeded, {2:d} failed and {3:d} generated an error in {4:.2f} s.".format(
      test_nr, test_succeed, test_failed, test_error, time.time() - start)
