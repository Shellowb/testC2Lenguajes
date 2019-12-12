#|--------------------------------- TESTS ----------------------------- |#

;(print-only-errors #t)

#|----------- TEST P1C -----------|#
;TEST P1C Finite Automaton
(define a1 (ND-FSA (init  : q0)
                   (final : q2)
                   (transitions :
                                [q0 : (c → q1)]
                                [q1 : (a → q1)
                                    (d → q1)
                                    (r → q2)]
                                [q2 : ])))

[test (a1 '(c a a d r))  '(q0 q1 q1 q1 q1 q2)]
[test (a1 '(c a d a r))  '(q0 q1 q1 q1 q1 q2)]
[test (a1 '(c a r a d r)) #f]
[test (a1 '(c d d a)) #f]

;TEST P1C Control Examples
(define m (ND-FSA
          (init  : q0)
          (final : acc1 acc2)
          (transitions :
                       [q0 : (a → q1)
                             (b → acc2)]
                       [q1 : (a → q1)
                             (b → q1 acc1)]
                       [acc1 : ]
                       [acc2 : (a → acc2)
                               (b → acc2)]
                       )))

[test (m'(a b a b)) '(q0 q1 q1 q1 acc1)]
[test (m'(a b a b a)) #f]
[test (m'(b a b))'(q0 acc2 acc2 acc2)]


#|----------- TEST P2 -----------|#
;TEST P2 even
[test (run'(rec2 (even (fun (n) (if0 n 1 (odd (- n 1)))))  ;1 represents #t
                 (odd (fun (n) (if0 n 0 (even (- n 1)))))  ;0 represents #f
                (even 7)))
      (numV 0)]

;TEST P2 odd
[test (run'(rec2 (even (fun (n) (if0 n 1 (odd (- n 1)))))  ;3represents #t
                 (odd (fun (n) (if0 n 1 (even (- n 1)))))  ;2represents #f
                (odd 7)))
      (numV 1)]