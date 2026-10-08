(ns build
  (:refer-clojure :exclude [test])
  (:require [clojure.tools.build.api :as b]))

(def lib 'com.something/app)
(def version "0.1.0-SNAPSHOT")
;; fixed name so compile.sh does not need to know lib/version
(def uber-file "target/app.jar")
(def main 'com.something.app)
(def class-dir "target/classes")

(defn clean "swipe out the target dir" [opts]
  (b/delete {:path "target"})
  opts)

(defn- uber-opts [opts]
  (assoc opts
         :lib lib
         :main main
         :uber-file uber-file
         ;; used to pull dep jars
         :basis (b/create-basis {})
         :class-dir class-dir
         :src-dirs ["src" "resources"]
         :ns-compile [main]
         ;; direct linking must be enabled at AOT time to take effect
         :bindings {#'clojure.core/*compiler-options* {:direct-linking true}}))

(defn uberjar "Publish a new Uberjar" [opts]
  (clean opts)
  (let [opts (uber-opts opts)]
    (println "\nCopying source...")
    (b/copy-dir {:src-dirs ["src" "resources"] :target-dir class-dir})
    (println (str "\nCompiling " main "..."))
    (b/compile-clj opts)
    (println "\nBuilding JAR..." (:uber-file opts))
    (b/uber opts))
  opts)
