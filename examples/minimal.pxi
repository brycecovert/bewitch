(ns minimal
  (:require [bewitch.core :as bewitch]))

(let [scr (bewitch/init)]
  (bewitch/render scr 2 2 "Hello world!")
  (bewitch/getch)
  (bewitch/destroy scr))
