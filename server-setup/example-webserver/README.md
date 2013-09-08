# example-webserver

This is one of the simplest possible clojure webservers; it listens on port 8888 and always responds with a plain text hello world page.
Run it with `lein run`, or uberjar it up with `lein uberjar` and then run it with `java -jar example-webserver-0.1.0-standalone.jar`.
Or you can open a repl, `(use 'example-webserver.core)`, and call `(-main)`.
