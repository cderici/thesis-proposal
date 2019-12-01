#lang racket/base

(require pict racket/draw)

(define TOTAL-w 40)

(define t-color (make-color 255 255 255 1))
(define cap-color (make-color 0 0 0 1))

(define SCALE 6)
(define base-h 10)

(define TEXT-SIZE (* (- SCALE 4) base-h))
(define CAP-SIZE (* TEXT-SIZE 0.6))

(define (f-rect num stackful? [h (* (- SCALE 2) base-h)])
  (filled-rectangle (* SCALE num) (- h 3) #:color (if stackful? "red" "blue") #:draw-border? #f))

(define (time-rect num num-txt stackful?)
  (cc-superimpose (f-rect num stackful?)
                  (text (format "~ams" (number->string num-txt)) (list t-color) TEXT-SIZE)))

(define (bench-res cap-txt st-time cek-time [w TOTAL-w])
  (let* ([kucuk (round (* w (min st-time cek-time) (/ 1 (max st-time cek-time))))])
    (let-values ([(s-t c-t) (if (< st-time cek-time) (values kucuk w) (values w kucuk))])
      (vc-append
       (text cap-txt (list 'bold) CAP-SIZE)
       (vl-append
        (time-rect s-t st-time #t)
        (time-rect c-t cek-time #f))))))

(define bm
  (hc-append 50
             (bench-res "all 1s" 20 19 20)
             (bench-res "all 2s" 20 16 20)
             (bench-res "random" 169 340)))

(define legend
  (vc-append
   (text "asd" (list 'bold t-color) CAP-SIZE)
   (cc-superimpose (f-rect 6 #t 40)
                   (text "ST" (list 'bold t-color) (* 0.6 TEXT-SIZE)))
   (cc-superimpose (f-rect 6 #f 40)
                   (text "CEK" (list 'bold t-color) (* 0.6 TEXT-SIZE)))))

(define all (hc-append 20 legend bm))

(pict->bitmap all)