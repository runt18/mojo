About
=====

This is a prototype for plumbing Mojo into the NaCl sandbox.  It is currently
insecure (see below), and does not support Mojo functions that return pointers
(for example, `MojoMapBuffer`).

Currently, SFI NaCl support is not being actively developed, in favor of
non-SFI NaCl support.

Using
=====

The SFI NaCl and accompanying tests should be built by default for Linux.
The boolean indicating if they are built is "mojo_use_nacl", defined inside
the BUILD files.

This should create a "monacl_shell" executable, capable of running standalone
SFI nexes.

Additionally, it will create a content handler for SFI nexes -- any Nexe
with the line "#!mojo mojo:nacl_content_handler" prepended to it will be
redirected to the SFI content handler when run with the "mojo_shell".


Notes
=====

`nacl_bindings_generator/interface.py` contains a programmatic description of
the stable Mojo interface.  This will need to be updated as the interface
changes.  Run `nacl_bindings_generator/generate_nacl_bindings.py` to generate
the bindings that plumb this interface into the NaCl sandbox.

Security TODO
=============

* Validate and copy option structures.
* Protect untrusted buffers passed into Mojo:
  * `NaClVmIoWillStart/HasEnded`.
  * volatile accesses to untrusted memory (untrusted code could race).
* Overflow checking in array bounds validation.
