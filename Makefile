BINARY ?= hello-native
JAR    := target/app.jar
SRCS   := $(shell find src resources -type f) deps.edn build.clj

.PHONY: all uberjar native clean

all: native

uberjar: $(JAR)

$(JAR): $(SRCS)
	clojure -T:build uberjar

native: $(JAR)
	./compile.sh $(BINARY)

clean:
	clojure -T:build clean
	rm -f $(BINARY) $(BINARY).exe
