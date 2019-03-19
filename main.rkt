#lang racket

(require web-server/servlet)
(require json)

(provide response/make
         response/not-found
         response/json
         response/file
         response/redirect)

; Make response
(define (response/make content 
    #:code [code 200]
    #:message [message #"OK"]
    #:seconds [seconds (current-seconds)]
    #:mime-type [mime-type TEXT/HTML-MIME-TYPE]
    #:headers [headers '()])

    (response/full code
        message
        seconds
        mime-type
        headers
        (list (string->bytes/utf-8 content))))

; 404 Response
(define/contract (response/not-found [content "Page not found"] 
                 #:headers [headers '()])
    (() (string?)  . ->* . response?) ; contract
    (response/make content 
                   #:code 404 
                   #:message #"Not Found"
                   #:headers headers ))

; File resonse
(define/contract (response/file file [mime TEXT/HTML-MIME-TYPE])
    ((path-string?) (bytes?) . ->* . response?) ; contract
    (response/output (λ (op) (let ([ip (open-input-file file)]) (copy-port ip op) (close-input-port ip))) 
        #:mime-type mime))

; Json response
(define/contract (response/json content 
                                #:headers [headers (list (make-header #"Cache-Control" #"no-cache"))])
    (jsexpr? . -> . response?) ; contract
    (response/full 
        200 #"OK" (current-seconds) #"application/json; charset=utf-8" headers
        (list (jsexpr->bytes content))))


; Redirect response
(define/contract (response/redirect url 
                  [permanent #f]
                  #:headers [headers '()])
    ((non-empty-string?) (boolean?) . ->* . response?) ; contract
    (redirect-to url (if permanent permanently temporarily) #:headers headers))
