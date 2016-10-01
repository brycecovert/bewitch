(ns windows
  (:require [pixie.ffi-infer :refer :all]
            [pixie.ffi :as ffi]
            [pixie.time :refer [time]]
            [pixie.walk :as walk]
            [bewitch.core :as bewitch]))


(let [scr (bewitch/init)]
  (bewitch/refresh scr) 
  (bewitch/with-window [window-1 (-> (bewitch/new-window 20 20 4 4)
                                     (bewitch/render-box))
                        window-2 (-> (bewitch/new-window 10 40 0 25)
                                     (bewitch/render-box))]
    (bewitch/render window-1 2 2 {:color [:blue :red] :string "Hello world!"})
    (bewitch/render window-1 3 2 {:color [:blue :red] :string "Press key to enter your name"})
    
    (bewitch/render window-2 3 2 {:color [:green :yellow] :string "Another message"}))
  (bewitch/getch)
  (bewitch/with-window [window-1 (-> (bewitch/new-window 20 30 4 4)
                                     (bewitch/render-box))]
    (bewitch/render window-1 2 2 {:color [:blue :red] :string "What's your name"})
    (bewitch/read-string window-1))
  
  (bewitch/destroy scr))
