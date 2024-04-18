## Basic project

Execute your native image flow by using:

```
clojure -T:build uberjar
```

Then:

```
$GRAALVM_HOME/bin/native-image -jar target/some-jar-file-0.1.0.jar \
                               --verbose \
                               --no-fallback \
                               --static \
                               --install-exit-handlers \
                               -J-Dclojure.spec.skip-macros=true \
                               -J-Dclojure.compiler.direct-linking=true \
                               -H:ReflectionConfigurationFiles=reflection.json \
                               -H:Name=example \
                               --features=clj_easy.graal_build_time.InitClojureClasses

echo "Size of generated native-image `ls -sh example`"
```
