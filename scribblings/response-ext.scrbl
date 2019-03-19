#lang scribble/manual
@require[@for-label[response-ext
                    web-server/servlet
                    racket/base]]

@title{response-ext}
@author{junker}

@defmodule[response-ext]

Extended HTTP response functions for Racket Web Server

@defproc[(response/make [content string?]
                        [#:code code number? 200]
                        [#:message message bytes? #"Okay"]
                        [#:seconds seconds number? (current-seconds)]
                        [#:mime-type mime-type (or/c bytes? #f) TEXT/HTML-MIME-TYPE]
                        [#:headers headers (listof header?) '()]) response?]{
    returns response with string content
}


@defproc[(response/not-found [content string? "Page not found"]
                             [#:headers headers (listof header?) '()]) response?]{
    returns response with 404 code
}

@defproc[(response/file [file path-string?] 
                        [mime bytes? TEXT/HTML-MIME-TYPE]) response?]{
    returns response with file content
}

@defproc[(response/json [json jsexpr?]) response?]{
    returns response with JSON
}

@defproc[(response/redirect [url non-empty-string?]
                            [permanent boolean? #f]
                            [#:headers headers (listof header?) '()]) response?]{
    returns response with redirect 
}