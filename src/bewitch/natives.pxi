(ns bewitch.natives
  (:require [pixie.ffi-infer :refer :all]
            [pixie.ffi :as ffi]
            [pixie.time :refer [time]]))
(binding [*library* (ffi-library "libncurses.dylib")]
  (do (def KEY_ENTER 343)
      (def KEY_LEFT 260)
      (def KEY_RIGHT 261)
      (def KEY_UP 259)
      (def KEY_DOWN 258)
      (def COLOR_BLACK 0)
      (def COLOR_RED 1)
      (def COLOR_GREEN 2)
      (def COLOR_YELLOW 3)
      (def COLOR_BLUE 4)
      (def COLOR_MAGENTA 5)
      (def COLOR_CYAN 6)
      (def COLOR_WHITE 7)
      (def stdscr
        (ffi-voidp *library* "stdscr"))
      (def initscr
        (ffi-fn *library* "initscr" [] CVoidP))
      (def usleep
        (ffi-fn *library* "usleep" [CUInt32] CInt32))
      (def addch
        (ffi-fn *library* "addch" [CUInt32] CInt32))
      (def waddch
        (ffi-fn *library* "waddch" [CVoidP CUInt32] CInt32))
      (def nonl
        (ffi-fn *library* "nonl" [] CInt32))
      (def keypad
        (ffi-fn *library* "keypad" [CVoidP CUInt8] CInt32))
      (def clear
        (ffi-fn *library* "clear" [] CInt32))
      (def nocbreak
        (ffi-fn *library* "cbreak" [] CInt32))
      (def cbreak
        (ffi-fn *library* "cbreak" [] CInt32))
      (def nocbreak
        (ffi-fn *library* "nocbreak" [] CInt32))
      (def curs_set
        (ffi-fn *library* "curs_set" [CInt32] CInt32))
      (def newwin
        (ffi-fn *library* "newwin" [CInt32 CInt32 CInt32 CInt32] CVoidP))
      (def box
        (ffi-fn *library* "box" [CVoidP CUInt32 CUInt32] CInt32))
      (def attroff
        (ffi-fn *library* "attroff" [CInt32] CInt32))
      (def attron
        (ffi-fn *library* "attron" [CInt32] CInt32))
      (def wattron
        (ffi-fn *library* "wattron" [CVoidP CInt32] CInt32))
      (def wattroff
        (ffi-fn *library* "wattroff" [CVoidP CInt32] CInt32))
      (def werase
        (ffi-fn *library* "werase" [CVoidP] CInt32))
      (def erase
        (ffi-fn *library* "erase" [] CInt32))
      (def refresh
        (ffi-fn *library* "refresh" [] CInt32))
      (def wrefresh
        (ffi-fn *library* "wrefresh" [CVoidP] CInt32))
      (def noecho
        (ffi-fn *library* "noecho" [] CInt32))
      (def echo
        (ffi-fn *library* "echo" [] CInt32))
      (def getch
        (ffi-fn *library* "getch" [] CInt32))
      (def getnstr
        (ffi-fn *library* "getnstr" [CCharP] CInt32))
      (def wgetnstr
        (ffi-fn *library* "wgetnstr" [CVoidP CCharP] CInt32))
      (def delwin
        (ffi-fn *library* "delwin" [CVoidP] CInt32))
      (def init_pair
        (ffi-fn *library* "init_pair" [CInt16 CInt16 CInt16] CInt32))
      (def start_color
        (ffi-fn *library* "start_color" [] CInt32))
      (def move
        (ffi-fn *library* "move" [CInt32 CInt32] CInt32))
      (def wmove
        (ffi-fn *library* "wmove" [CVoidP CInt32 CInt32] CInt32))
      (def addstr
        (ffi-fn *library* "addstr" [CCharP] CInt32))
      (def waddstr
        (ffi-fn *library* "waddstr" [CVoidP CCharP] CInt32))
      (def endwin
        (ffi-fn *library* "endwin" [] CInt32))))

;; cached, use this to generate config
#_(prn (macroexpand-1 '(with-config {:library "ncurses"
                                     :cxx-flags ["-I/usr/local/Cellar/ncurses/6.0_2/include/ -DGCC_PRINTF"]
                                     :includes ["ncurses.h"]}
                         (defconst KEY_ENTER)
                         (defconst KEY_LEFT)
                         (defconst KEY_RIGHT)
                         (defconst KEY_UP)
                         (defconst KEY_DOWN)
                         (defconst COLOR_BLACK)
                         (defconst COLOR_RED)
                         (defconst COLOR_GREEN)
                         (defconst COLOR_YELLOW)
                         (defconst COLOR_BLUE)	
                         (defconst COLOR_MAGENTA)	
                         (defconst COLOR_CYAN)	
                         (defconst COLOR_WHITE)
                         (defglobal stdscr)
                         (defcfn initscr)
                         (defcfn usleep)
                         (defcfn addch)
                         (defcfn waddch)
                         (defcfn nonl)
                         (defcfn keypad)
                         (defcfn clear)
                         (defcfn cbreak)
                         (defcfn nocbreak)
                         (defcfn curs_set)
                         (defcfn newwin)
                         (defcfn box)
                         (defcfn attron)
                         (defcfn wattron)
                         (defcfn werase)
                         (defcfn erase)
                         (defcfn refresh)
                         (defcfn wrefresh)
                         (defcfn noecho)
                         (defcfn echo)
                         (defcfn getch)
                         (defcfn delwin)
                         (defcfn init_pair)
                         (defcfn start_color)
                         (defcfn move)
                         (defcfn wmove)
                         (defcfn addstr)
                         (defcfn waddstr)
                         (defcfn endwin))))
