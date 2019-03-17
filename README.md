# response-ext
 
Extended HTTP response functions for Racket Web Server

## Usage
```racket
(require web-server/servlet)
(require response-ext)

(define resp (response/make "my page content"
				#:code 200
				#:message #"OK"
				#:seconds (current-seconds)
				#:mime-type TEXT/HTML-MIME-TYPE
				#:headers (list (make-header #"Cache-Control" #"no-cache"))))
				
(define resp (response/file "main.rkt"))

(define resp (response/not-found "NOT FOUND"))

(define resp (response/json (string->jsexpr "{\"arr\":[1,2,3,4]}")))
```