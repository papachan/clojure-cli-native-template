#!/usr/bin/bash

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
JAR_PATH="target/com.something-0.1.0-SNAPSHOT.jar"

if [ $# -eq 1 ]; then
    BINARY_NAME=$1
else
    BINARY_NAME="example"
fi

${GRAALVM_HOME}/bin/native-image -jar ${JAR_PATH} \
                                 --no-fallback \
                                 --install-exit-handlers \
                                 -J-Dclojure.spec.skip-macros=true \
                                 -J-Dclojure.compiler.direct-linking=true \
                                 -H:ReflectionConfigurationFiles=reflection.json \
                                 -H:Name="${BINARY_NAME}" \
                                 --features=clj_easy.graal_build_time.InitClojureClasses

if [ -f "$BINARY_NAME" ]; then
echo ""
echo "Done! The native image have been compiled:"
echo "Size of generated native-image `ls -sh ${BINARY_NAME}`"
fi
