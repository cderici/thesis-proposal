#lang slideshow

(require (for-syntax syntax/parse)
         (rename-in slideshow (slide orig-slide))
         slideshow/code
         slideshow/base
         pict
         pict/face
         racket/draw)

(set-spotlight-style! #:size 20 #:color (make-object color% 255 0 0 0.6))

(define slide-count 4) ; 4 outline minus the title

; (make-object color% 153 187 204)

;; A pict to use behind the main content
(define fade-bg
  (let ([w (+ (* 2 margin) client-w)]
        [h (+ (* 2 margin) client-h)]
        [trans (make-object brush% "white" 'transparent)]
        [inside (make-object brush% (make-object color% 255 220 196) 'solid)])
    (inset (dc (lambda (dc x y)
                 (let ([b (send dc get-brush)]
                       [p (send dc get-pen)]
                       [draw-one
                        (lambda (i)
                          (send dc draw-rectangle
                                (+ x i) (+ y i)
                                (- w (* 2 i)) (- h (* 2 i))))])
                   (send dc set-brush trans)
                   (color-series
                    dc margin 1
                    (make-object color% "black")
                    (make-object color% (make-object color% 120 153 169))
                    draw-one
                    #t #t)
                   (send dc set-brush inside)
                   (draw-one margin)
                   (send dc set-pen p)
                   (send dc set-brush b)))
               w h 0 0)
           (- margin))))

(define all-three-assembler
  (lambda (s v-sep c)
    (lt-superimpose
     (lbl-superimpose
      fade-bg
      (hc-append gap-size
                 (scale (bitmap (build-path "img" "plt-logo.png")) 0.3)
                 (scale (bitmap (build-path "img" "isabelle.png")) 0.3)
                 (scale (bitmap (build-path "img" "pycket.png")) 0.3)))
     (let ([c (colorize c "darkred")])
       (if s
           (vc-append v-sep
                      ;; left-aligns the title:
                      (ghost (scale (titlet s) 2))
                      (titlet s)
                      c)
           c))
     )))

(current-slide-assembler all-three-assembler)

(define-syntax slide
  (syntax-parser
    [(_ arg ...)
     #'(begin
         (set! slide-count (add1 slide-count))
         (orig-slide arg ...))]))

(current-page-number-adjust
 (λ (str n)
   (format "~a / ~a" n slide-count)))

(define outline
  (let ([sub-para
         (lambda l
           (para #:width (* 3/4 (current-para-width)) l))])
    (make-outline
     'one "Part I: Modeling Linklets Using PLT Redex"
     #f

     'two "Part II: Adding Pairs to the Denotational Model"
     (lambda (tag)
       (sub-para "... of the CBV λ-calculus"))

     'three "Part III: Measuring Pycket's Performance"
     (lambda (tag)
       (sub-para "... with the new linklets"))

     'end "Conclusion"
     #f)))

(set-page-numbers-visible! #f)

(slide
 (titlet "Thesis Proposal: [LONG TITLE]")
 (scale (t "Caner Derici") 0.8)
 (scale (t ".. Dec 2019") 0.5)
 (blank)
 (comment "Girizgah")
 (scale (it "Commitee:") 0.5)
 (scale (it "Dr. Sam Tobin-Hochstadt") 0.5)
 (scale (it "Dr. Jeremy Siek") 0.5)
 (scale (it "Dr. Daniel Leivant") 0.5)
 (scale (it "Dr. Ryan Newton") 0.5))


(current-font-size 25)

(current-slide-assembler
 (lambda (s v-sep c)
   (lt-superimpose
    fade-bg
    (let ([c (colorize c "darkred")])
      (if s
          (vc-append v-sep
                     ;; left-aligns the title:
                     (ghost (scale (titlet s) 2))
                     (titlet s)
                     c)
          c))
      )))
