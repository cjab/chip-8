Chip-8
======

Emulator
----------------------

A Chip-8 emulator written in CoffeeScript using ArrayBuffers, Blobs, and other
features unlikely to work in your browser.  

Try it out at: [http://chip-8.jabnix.net](http://chip-8.jabnix.net)


Assembler/Disassembler
----------------------

A Chip-8 assembler/disassembler implemented using ArrayBuffers. This has only
been tested on Chrome 18 but it may work on newer versions of Firefox as well.
I'm pretty sure you're out of luck with IE.


### Use

Make sure this is run from a web server. Otherwise Chrome will complain with
a cross origin request error when trying to load local coffeescript files.

This run from within the project directory should do the trick:
`python -m SimpleHTTPServer`

You can then visit: `http://localhost:8000/index.html`


### Running Tests

Tests can be run by visiting: `http://localhost:8000/test.html`
