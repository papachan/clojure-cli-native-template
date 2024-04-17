(ns build
  (:refer-clojure :exclude [test])
  (:require [clojure.tools.build.api :as b]))

(def lib 'com.something)
(def version "0.1.0-SNAPSHOT")
(def main 'com.something.app)
(def class-dir "target/classes")

(defn clean "swipe out the target dir" [opts]
  (b/delete {:path "target"})
  opts)

(defn- uber-opts [opts]
  (assoc opts
         :lib lib
         :main main
         :uber-file (format "target/%s-%s.jar" lib version)
         ;; used to pull dep jars
         :basis (b/create-basis {})
         :class-dir class-dir
         :src-dirs ["src/backend"]
         :ns-compile [main]))

(defn uberjar "Publish a new Uberjar" [opts]
  (clean opts)
  (let [opts (uber-opts opts)]
    (println "\nCopying source...")
    (b/copy-dir {:src-dirs ["resources" "src"] :target-dir class-dir})
    (println (str "\nCompiling " main "..."))
    (b/compile-clj opts)
    (println "\nBuilding JAR..." (:uber-file opts))
    (b/uber opts))
  opts)
