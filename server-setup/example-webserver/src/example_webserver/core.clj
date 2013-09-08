(ns example-webserver.core
  (:gen-class)
  (:require [ring.adapter.jetty :refer [run-jetty]]))

(defn handler
  [req]
  {:status 200
   :headers {"Content-Type" "text/plain"}
   :body "Hello from the example clojure webserver!"})

(defn -main
  [& _]
  (run-jetty handler {:port 8888}))
