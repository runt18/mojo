# Mozart View Tiling Example

This directory contains a simple application which embeds any number of
views from other applications all tiled in a row.

The applications must implement the ViewProvider interface and register
their Views with the ViewManager for this to work.

## USAGE

  out/Debug/mojo_shell "mojo:launcher mojo:tile_view?<app1>[,<app2>[,...]]"

Specify the urls of the views to embed as a comma-delimited query parameter.

  eg. out/Debug/mojo_shell "mojo:launcher mojo:tile_view?mojo:spinning_cube_view,mojo:noodles_view"
