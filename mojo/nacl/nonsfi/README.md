About
=====

This directory contains the necessary components to run Non-SFI NaCl
nexes (native executables) from within Mojo.

Using
=====

The Non-SFI NaCl and accompanying tests should be built by default for Linux.
The boolean indicating if they are built is "mojo_use_nacl_nonsfi", defined
inside the BUILD files.

Build Mojo (all following commands assume you are in the root of the mojo
repository):

```
$  ./mojo/tools/mojob.py gn
$  ./mojo/tools/mojob.py build
```

Doing this build step will automatically create a pexe of unit tests, at
`./out/Debug/newlib_pnacl/monacl_test.pexe`.  To translate a pexe into a
non-SFI nexe:

```
$ ./native_client/toolchain/linux_x86/pnacl_newlib/bin/pnacl-translate \
./out/Debug/newlib_pnacl/FOOBAR.pexe -o FOOBAR.nexe -arch x86-32-nonsfi
```

Now, you should have the fully translated nexe (called
"FOOBAR.nexe").  You can run the nexe through the monacl shell
(a minimal, "nexe-only" shell, which loads the nexe ELF file -- see
 monacl_shell_nonsfi.cc):

```
$ ./out/Debug/clang_x86/monacl_shell_nonsfi FOOBAR.nexe
```

This monacl_shell_nonsfi is the easiest way to run nexes in Mojo -- however, it
is not the only way. Usually, applications are launched through the
"mojo_shell", but some additional information is required to know how to handle
this content (i.e., how does the mojo_shell know it is dealing with a nonsfi
nexe?).

The BUILD.gn files in Mojo automatically make this pexe, translate it to a
nexe, and prepend a line ("#!mojo mojo:nacl_content_handler_nonsfi") to the
front of the file, at which point it is also runnable through the mojo_shell.
These files, which start with this "#!" line, are ".mojo" files. The nexes can
be run like this:

```
$  ./out/Debug/mojo_shell --enable-multiprocess out/Debug/FOOBAR.mojo
```

TODO
====

* Enable content handling of Non-SFI pexes, which should be translated and run
as nexes.
  * Use subzero (a NaCl project to improve translation speed) for pexe
  translation.
  * Enable caching of translated pexes.
