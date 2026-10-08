## Clojure CLI native-image template

### Prerequisites

- [Clojure CLI](https://clojure.org/guides/install_clojure)
- A GraalVM JDK with `native-image`; set `GRAALVM_HOME` (or put `native-image` on `PATH`)
  example: export GRAALVM_HOME=~/graalvm/graalvm-jdk-25.0.4+7.1
- A C toolchain: `build-essential` and `zlib1g-dev` on Linux/Ubuntu
  or Visual Studio 2022 C++ build tools on native Windows.
  command:

```
apt install build-essential zlib1g-dev
```

or

```
pacman -Syy gcc
```



### Build

```
clojure -T:build uberjar
./compile.sh hello-native
```

### Run

```
./hello-native World     # prints "World!"
```


### note

Build flags and reflection/resource config live in
`resources/META-INF/native-image/com.something/app/` and are packaged
in the jar, so `native-image` picks them up automatically. Add
`reflect-config.json` entries there when needed.
