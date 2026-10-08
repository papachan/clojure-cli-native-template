#!/usr/bin/env bash
# Build a GraalVM native image from the uberjar (run `clojure -T:build uberjar` first).
# Usage: ./compile.sh [binary-name]
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

JAR_PATH="target/app.jar"
BINARY_NAME="${1:-example}"

if [ -n "${GRAALVM_HOME:-}" ]; then
    NATIVE_IMAGE="${GRAALVM_HOME}/bin/native-image"
    # on Windows the launcher is native-image.cmd
    [ -e "$NATIVE_IMAGE" ] || NATIVE_IMAGE="${NATIVE_IMAGE}.cmd"
elif command -v native-image >/dev/null 2>&1; then
    NATIVE_IMAGE="native-image"
else
    echo "native-image not found: set GRAALVM_HOME or add it to PATH" >&2
    exit 1
fi

if [ ! -f "$JAR_PATH" ]; then
    echo "$JAR_PATH not found: run 'clojure -T:build uberjar' first" >&2
    exit 1
fi

# build flags live in resources/META-INF/native-image/com.something/app/native-image.properties
"$NATIVE_IMAGE" -jar "$JAR_PATH" -o "$BINARY_NAME"

# native-image appends .exe on Windows
for f in "$BINARY_NAME" "$BINARY_NAME.exe"; do
    if [ -f "$f" ]; then
        echo ""
        echo "Done! Native image compiled: $(ls -sh "$f")"
    fi
done
