#lang racket

(require rackunit
         web-server/servlet
         json
         "main.rkt")

(test-case "response/file"

    (define resp (response/file "main.rkt" TEXT/HTML-MIME-TYPE))

    (define content-port (open-output-string))
    ((response-output resp) content-port)

    (check-equal?
        (get-output-string content-port)
        (file->string "main.rkt")))

(test-case "response/not-found"

    (define resp (response/not-found "NOT FOUND"))
    
    (define content-port (open-output-string))
    ((response-output resp) content-port)

    (check-equal?
        (get-output-string content-port)
        "NOT FOUND"))

(test-case "response/json"

    (define str "{\"arr\":[1,2,3,4]}")

    (define resp (response/json (string->jsexpr str)))
    
    (define content-port (open-output-string))
    ((response-output resp) content-port)

    (check-equal?
        (get-output-string content-port)
        str))
