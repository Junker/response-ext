#lang info

(define collection "response-ext")
(define version "0.0.2")
(define deps '("base" "web-server-lib" "rackunit-lib"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/response-ext.scrbl" ())))
(define pkg-authors '(junker))
(define pkg-desc "Extended HTTP response functions for Racket Web Server")
