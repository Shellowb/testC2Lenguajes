#lang play

(require "baseC2.rkt")

(defmac (foo decision (transitions :
                                     [state :
                                            (action → target ...)
                                            ...]
                                     ...))
    #:keywords transitions : →
      (letrec ([state decision]...) (print state)...))

(defmac (foo2 decision (transitions :
                                     [state :
                                            (action → target ...)
                                            ...]
                                     ...))
    #:keywords transitions : →
      (letrec ([state decision]...) (or state ...)))

(defmac (foo3 decision (transitions :
                                     [state :
                                            (action → target ...)
                                            ...]
                                     ...))
    #:keywords transitions : →
      (letrec ([state (letrec ([action (+ target ...)]...) (max action ...))]
               ...)
        (or state ...)) 
  )

(foo #t (transitions :
                       [s1 : (1 → 2 3 4)]
                       [s2 : (1 → 2)
                           (3 → 2)]
                       ))
      
[test (foo2 #f (transitions :
                       [s1 : (1 → 2 3 4)]
                       [s2 : (1 → 2)
                           (3 → 2)]
                       ))
      #f]

[test (foo2 #t (transitions :
                       [s1 : (1 → 2 3 4)]
                       [s2 : (1 → 2)
                           (3 → 2)]
                       ))
      #t]

(foo3 #t (transitions :
                       [s1 : (a1 → 2 3 4)]
                       [s2 : (a2 → 2)
                           (a3 → 2 5)]
                       ))