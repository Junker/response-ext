#lang racket

(require web-server/servlet)
(require json)

(provide response/make
         response/not-found
         response/json
         response/file)

; Make response
(define (response/make content 
    #:code [code 200]
    #:message [message #"OK"]
    #:seconds [seconds (current-seconds)]
    #:mime-type [mime-type TEXT/HTML-MIME-TYPE]
    #:headers [headers (list (make-header #"Cache-Control" #"no-cache"))])

    (response/full code
        message
        seconds
        mime-type
        headers
        (list (string->bytes/utf-8 content))))

; 404 Response
(define/contract (response/not-found [content "Page not found"])
    (() (string?)  . ->* . response?) ; contract
    (response/make #:code 404 content))

; File resonse
(define/contract (response/file file)
    (path-string? . -> . response?) ; contract
    (response/output (λ (op) (let ([ip (open-input-file file)]) (copy-port ip op) (close-input-port ip))) 
        #:mime-type TEXT/HTML-MIME-TYPE))

; Json response
(define/contract (response/json content)
    (jsexpr? . -> . response?) ; contract
    (response/full 
        200 #"OK" (current-seconds) #"application/json; charset=utf-8" '()
        (list (jsexpr->bytes content))))


