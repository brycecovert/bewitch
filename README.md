# bewitch
curses for pixie

bewitch provides an ffi wraper for ncurses in [pixie](https://github.com/pixie-lang/pixie).

## Getting started

Create a project using [dust](https://github.com/pixie-lang/dust). 
In your ```project.edn``` , add:
```clojure
:dependencies [[brycecovert/bewitch "0.1.1"]]
```

Pull down your dependencies using
```
dust get-deps
```

## Bewitcher's Spellbook

In ```/examples/```, you'll find several example usages of bewitch.

## Rendering to the screen (Hello World)
```clojure
(ns minimal
  (:require [bewitch.core :as bewitch]))

(let [scr (bewitch/init)]
  (bewitch/render scr 2 2 "Hello world!")
  (bewitch/getch)
  (bewitch/destroy scr))
```

This simple application will print "Hello World!", wait for input, then quit.

## Rendering

There are three ways to render to a screen or window with bewitch:
```clojure
(bewitch/render window 2 2 "string")
(bewitch/render window 2 2 \q)
(bewitch/render window 2 2 {:color [:blue :black] :string "a different string"})
```

## Windows

You can use the ```with-window``` macro to create and destroy windows.
```clojure
(bewitch/with-window [new-window (bewitch/new-window 10 10 0 0)]
  ...)
```

## Input
Reading a character:
```clojure
(bewitch/getch)
```

Reading a string:
```clojure
(bewitch/read-string window)
```

## Bewitched yet?

If you'd like to see more, here's a fake [roguelike](https://github.com/brycecovert/bewitch-roguelike) made with bewitch.

## Todo

Tons. Panels, pads, options, creating a protocol for rendering (to allow custom rendering), etc.


## License
```
The MIT License (MIT)

Copyright (c) 2016 bryce covert

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
