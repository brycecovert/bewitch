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

