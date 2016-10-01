(ns bewitch.core
  (:require [pixie.ffi-infer :refer :all]
            [pixie.ffi :as ffi]
            [pixie.string :as str]
            [pixie.time :refer [time]]
            [bewitch.natives :as n]))


(def color->ncurses {:black n/COLOR_BLACK 
                     :red n/COLOR_RED 
                     :green n/COLOR_GREEN 
                     :yellow n/COLOR_YELLOW 
                     :blue n/COLOR_BLUE 
                     :magenta n/COLOR_MAGENTA 
                     :cyan n/COLOR_CYAN 
                     :white n/COLOR_WHITE })

(def color-pairs
  (for [fg (keys color->ncurses)
        bg (keys color->ncurses)]
    [fg bg]))

(def colors
  (into {}
        (for [[i pair] (map vector (range) color-pairs)]
          [pair (* 256 (inc i))]) ))

(defprotocol IWritable
  (clear [this])
  (render [this y x thing])
  (read-string [this])
  (move [this y x])
  (refresh [this]))

(defprotocol IDestroyable
  (destroy [this]))

(deftype Screen [scr]
  IWritable
  (clear [this]
    (n/erase))
  (read-string [this]
    #_(let [x ""]
        (n/getstr x)
        x))
  (render [this y x thing]
    (n/move y x)
    (cond (char? thing)
          (n/addch (int thing))

          (string? thing)
          (n/addstr thing)

          (map? thing)
          (do
            (when-let [color (:color thing)]
              (n/attron (colors color)))
            (render this y x (or (:string thing)
                                 (:char thing)))
            (when-let [color (:color thing)]
              (n/attroff (colors color))))

          :else
          nil)
    this)
  (refresh [this]
    (n/refresh))

  IDestroyable
  (destroy [this]
    (n/nocbreak)
    (n/clear)
    (n/keypad scr 0)
    (n/echo)
    (n/endwin)))

(defprotocol IWindow
  (render-box [this]))

(deftype Window [win]
  IWindow
  (render-box [this]
    (n/box win 0 0)
    this)
  
  IWritable
  (clear [this]
    (n/werase win))

  (read-string [this & [color]]
    (refresh this)
    (when color
      (n/wattron win (colors color)))
    (let [x (ffi/buffer 255)
          _ (n/wgetnstr win x)
          result (str/join (for [i (range 255)] (char (nth x i))))]
      (ffi/dispose! x)
      (when color
        (n/wattroff win (colors color)))  
      result)
    )
  (move [this y x]
    (n/wmove win y x)
    (refresh this)
    this)
  (render [this y x thing]
    (n/wmove win y x)
    (cond (char? thing)
          (n/waddch win (int thing))

          (string? thing)
          (n/waddstr win thing)

          (map? thing)
          (do
            (when-let [color (:color thing)]
              (n/wattron win (colors color)))
            (render this y x (or (:string thing)
                                 (:char thing)))
            (when-let [color (:color thing)]
              (n/wattroff win (colors color))))

          :else
          nil)
    this)
  (refresh [this]
    (n/wrefresh win))

  IDestroyable
  (destroy [this]
    
    (n/delwin win)))

(defn init []
  (let [scr (n/initscr)]
    (n/keypad scr 1)
    (n/clear)
    (n/start_color)
    (n/curs_set 0)
    (n/cbreak)
    (n/nonl)
    (doseq [[i [fg bg]] (map vector (range) color-pairs)]
      (n/init_pair (inc i) (color->ncurses fg) (color->ncurses bg)))
    (->Screen scr)))

(defn new-window [height width y x]
  (let [win (n/newwin height width y x)]
    (->Window win)))

(defmacro with-window [binding & forms]
  (let [first-binding (into [] (take 2 binding))]
    (if (seq first-binding)
      `(let ~first-binding
         (try
           (let [result (with-window ~(drop 2 binding) ~@forms)]
             (refresh ~(first first-binding))
             (destroy ~(first first-binding))
             result) 
           
           (catch ex
               (println ex)
               (destroy ~(first first-binding)))))
      `(do ~@forms))))


(defn getch []
  (let [ch (n/getch)]
    (condp = ch
      n/KEY_UP :key/up
      n/KEY_DOWN :key/down
      n/KEY_LEFT :key/left
      n/KEY_RIGHT :key/right
      (char ch))))
