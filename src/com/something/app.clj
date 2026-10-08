(ns com.something.app
  (:gen-class))

(set! *warn-on-reflection* true)

(defn func-call
  [data]
  (println (str (:name data) "!")))

(defn -main [& args]
  (func-call {:name (or (first args) "Clojure")}))
