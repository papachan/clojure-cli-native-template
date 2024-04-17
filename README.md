## Basic project

Execute your native image flow by using:

```
clojure -T:build uberjar
```

Then:

```
$GRAALVM_HOME/bin/native-image -jar target/some-jar-file-0.1.0.jar \
                               --verbose \
                               --initialize-at-build-time --diagnostics-mode \
                               --no-fallback \
                               --static \
                               --install-exit-handlers \
                               -H:ReflectionConfigurationFiles=reflection.json \
                               -H:Name=example

echo "Size of generated native-image `ls -sh example`"
```
