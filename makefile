EMCC=emcc
CPPSOURCES:=$(wildcard src/*.cpp)
LDFLAGS=-O2 --llvm-opts 2
OUTPUT=app/glcore.js

TSC=tsc
TSSOURCES:=$(wildcard src/*.ts)
TSFLAGS= --outDir app/

all: $(CPPSOURCES) $(OUTPUT)

$(OUTPUT): $(CPPSOURCES) 
	$(EMCC) $(CPPSOURCES) --bind -s FULL_ES2=1 --preload-file shaders/  -std=c++11 $(LDFLAGS) -o $(OUTPUT)

WASM: $(CPPSOURCES) 
	$(EMCC) $(CPPSOURCES) --bind -s FULL_ES2=1 -s WASM=1 -std=c++11 -O1 --llvm-opts 2 -o $(OUTPUT)

TSBUILD: $(TSSOURCES)
	$(TSC) $(TSSOURCES) $(TSFLAGS) 

clean:
ifeq ($(OS),Windows_NT)
	del app\glcore.*
else
	rm -f app/glcore.*
endif
