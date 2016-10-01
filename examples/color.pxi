(ns color
  (:require [pixie.ffi-infer :refer :all]
            [pixie.ffi :as ffi]
            [pixie.time :refer [time]]
            [pixie.walk :as walk]
            [bewitch.core :as bewitch]))


(let [scr (bewitch/init)]
  (bewitch/refresh scr) 
  (bewitch/render scr 2 2 {:color [:blue :red] :string "Hello world!"})
  (bewitch/render scr 3 2 {:color [:green :yellow] :char \q})
  (bewitch/getch)
  (bewitch/destroy scr))
