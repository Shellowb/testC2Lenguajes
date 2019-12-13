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
 ;TEST AUTOMATA DE UN ESTADO sin transiciones
(define m1 (ND-FSA
            (init : q0)
            (final : q0)
            (transitions : [q0 : ])))
[test (m1 '()) '(q0)]
[test (m1 '(a)) #f]

;TEST AUTOMATA DE UN ESTADO con transiciones
(define m2 (ND-FSA
            (init : q0)
            (final : q0)
            (transitions : [q0 : (a → q0)])))
[test (m2 '()) '(q0)]
[test (m2 '(a a a)) '(q0 q0 q0 q0)]
[test (m2 '(a a b)) #f]

;TEST AUTOMATA CON CANTIDAD PAR DE 0's y 1's
(define m3 (ND-FSA
            (init : q0)
            (final : q0)
            (transitions : [q0 : (1 → q1)
                               (0 → q3)]
                         [q1 : (1 → q0)
                             (0 → q2)]
                         [q2 : (1 → q3)
                             (0 → q1)]
                         [q3 : (1 → q2)
                             (0 → q0)])))
[test (m3 '(1 1 0 0)) '(q0 q1 q0 q3 q0)]
[test (m3 '(1 0 1 1 0 0 1 0)) '(q0 q1 q2 q3 q2 q1 q2 q3 q0)]
[test (m3 '(1 1 0 1 0 1 0 0 1)) #f]


;TEST5: AUTOMATA con ciclos
; NO INCLUIR EN LA TAREA
(define m4 (ND-FSA
            ( init : q0) ;estado inicial
            ( final : q0 q3 q5) ;estados de aceptación
            ( transitions : [q0 : (c → q1)]
                            [q1 : (b → q2)
                                  (c → q3)]
                            [q2 : (a → q1 q5)]
                            [q3 : (b → q4)]
                            [q4 : (a → q2)
                                  (b → q5)]
                            [q5 : ])))

[test (m4 '(c b a)) '(q0 q1 q2 q5)]
[test (m4 '(c c)) '(q0 q1 q3)]
[test (m4 '(c c b b)) '(q0 q1 q3 q4 q5)]
[test (m4 '(c b a c)) '(q0 q1 q2 q1 q3)]


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

;TEST Funcion modulo 3 (funcion recursiva para 3 funciones)
[test (run '(rec2 (mod3_0 (fun (n) (if0 n 0(mod3_21 (- n 1)))))
                  (mod3_21 (fun (n) (rec2 (mod3_1 (fun (m) (if0 m 1 (mod3_2 (- m 1)))))
                                          (mod3_2 (fun (m) (if0 m 2 (mod3_0 (- m 1)))))
                                          (mod3_1 n))))
                  (mod3_0 3)))
      (numV 0)]

[test (run '(rec2 (mod3_0 (fun (n) (if0 n 0(mod3_21 (- n 1)))))
                  (mod3_21 (fun (n) (rec2 (mod3_1 (fun (m) (if0 m 1 (mod3_2 (- m 1)))))
                                          (mod3_2 (fun (m) (if0 m 2 (mod3_0 (- m 1)))))
                                          (mod3_1 n))))
                  (mod3_0 8)))
      (numV 2)]

[test (run '(rec2 (mod3_0 (fun (n) (if0 n 0(mod3_21 (- n 1)))))
                  (mod3_21 (fun (n) (rec2 (mod3_1 (fun (m) (if0 m 1 (mod3_2 (- m 1)))))
                                          (mod3_2 (fun (m) (if0 m 2 (mod3_0 (- m 1)))))
                                          (mod3_1 n))))
                  (mod3_0 7)))
      (numV 1)]