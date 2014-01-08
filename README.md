Embedded Lua in GNU Makefile
----------------------------

GNU Make 4.0 provides GNU Guile (a Lisp dialect) out of the box. I wanted to
show that with just a little C it is equally possible to embed Lua into Make
with similar features like Guile has.

This example *in a single make process* does the following:

1. Download `markdown.lua` from internet using cross-platform "socket.http" Lua
   library.
2. Convert this README.md to README.html.

Why is this useful? Practically not useful. Use Guile. But embedding
everywhere Lua is fun.

Requires GNU Make 4.0 and Lua 5.1+ (tested on Lua 5.1)
