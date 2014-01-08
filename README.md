Embedded Lua in GNU Make
------------------------

I decided to play a bit with "load" functionality and embedded Lua into Make.
This repository is a good example how to use "load" and actually embed
absolutely anything into GNU Make and execute funky stuff in-process.

Background: GNU Make 4.0 provides GNU Guile (a Lisp dialect) out of the box. I
wanted to show that with just a little C it is equally possible to embed Lua
into Make and give as much power as a built-in programming language has.

This example *in a single process* does the following:

1. Download `markdown.lua` from internet using cross-platform "socket.http" Lua
   library.
2. Convert this README.md to README.html.

Requires GNU Make 4.0, Lua 5.1+ (tested on Lua 5.1) and [luasocket] library.

[luasocket]: w3.impa.br/~diego/software/luasocket/
