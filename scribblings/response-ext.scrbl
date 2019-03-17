#lang scribble/manual
@require[@for-label[response-ext
					web-server/servlet
                    racket/base]]

@title{response-ext}
@author{junker}

@defmodule[response-ext]

Extended HTTP response functions for Racket Web Server

@defproc[(response/not-found [content string? "Page not found"]) response?]{
	returns response with 404 code
}

@defproc[(response/file [file path-string?]) response?]{
	returns response with file content
}

@defproc[(response/json [json jsexpr?]) response?]{
	returns response with JSON
}
