(ns minimal
  (:require [pixie.ffi-infer :refer :all]
            [pixie.ffi :as ffi]
            [pixie.time :refer [time]]
            [pixie.walk :as walk]
            [bewitch.core :as bewitch]))


(let [scr (bewitch/init)]
  (bewitch/refresh scr) 
  (bewitch/render scr 2 2 "Hello world!")
  (bewitch/getch)
  (bewitch/destroy scr))
