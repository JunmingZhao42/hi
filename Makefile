BUILD_DIR ?= build
CAKE ?= cake

GCC_X64 := x86_64-linux-gnu-gcc
GCC_ARM64 := aarch64-linux-gnu-gcc

all: build c_x64 c_arm64 pancake_x64 pancake_x64_ffi pancake_arm64 pancake_arm64_ffi

c_x64: build fibo.c
	$(GCC_X64) -O0 -g -o $(BUILD_DIR)/c_fibo_x64 fibo.c

c_arm64: build fibo.c
	$(GCC_ARM64) -O0 -g -o $(BUILD_DIR)/c_fibo_arm64 fibo.c

pancake_x64: build fibo.🥞
	cat fibo.🥞 | cpp -P > $(BUILD_DIR)/fibo1_x64.🥞 && $(CAKE) --pancake --main_return=true <$(BUILD_DIR)/fibo1_x64.🥞 > $(BUILD_DIR)/pancake_fibo_x64.S --target=x64
	$(GCC_X64) -g -O0 -o $(BUILD_DIR)/pancake_fibo_x64 $(BUILD_DIR)/pancake_fibo_x64.S pnk_ffi.c

pancake_x64_ffi: build fibo.🥞
	cat fibo.🥞 | cpp -DFFI -P > $(BUILD_DIR)/fibo1_x64_ffi.🥞 && $(CAKE) --pancake --main_return=true <$(BUILD_DIR)/fibo1_x64_ffi.🥞 > $(BUILD_DIR)/pancake_fibo_x64_ffi.S --target=x64
	$(GCC_X64) -g -O0 -o $(BUILD_DIR)/pancake_fibo_x64_ffi $(BUILD_DIR)/pancake_fibo_x64_ffi.S pnk_ffi.c

pancake_arm64: build fibo.🥞
	cat fibo.🥞 | cpp -P > $(BUILD_DIR)/fibo1_arm64.🥞 && $(CAKE) --pancake --main_return=true <$(BUILD_DIR)/fibo1_arm64.🥞 > $(BUILD_DIR)/pancake_fibo_arm64.S --target=arm8
	$(GCC_ARM64) -g -O0 -o $(BUILD_DIR)/pancake_fibo_arm64 $(BUILD_DIR)/pancake_fibo_arm64.S pnk_ffi.c

pancake_arm64_ffi: build fibo.🥞
	cat fibo.🥞 | cpp  -DFFI -P > $(BUILD_DIR)/fibo1_arm64_ffi.🥞 && $(CAKE) --pancake --main_return=true <$(BUILD_DIR)/fibo1_arm64_ffi.🥞 > $(BUILD_DIR)/pancake_fibo_arm64_ffi.S --target=arm8
	$(GCC_ARM64) -g -O0 -o $(BUILD_DIR)/pancake_fibo_arm64_ffi $(BUILD_DIR)/pancake_fibo_arm64_ffi.S pnk_ffi.c

bench_arm64:
	./bench.sh $(BUILD_DIR) pancake_fibo_arm64
	./bench.sh $(BUILD_DIR) pancake_fibo_arm64_ffi
	./bench.sh $(BUILD_DIR) c_fibo_arm64

bench_x64:
	./bench.sh $(BUILD_DIR) pancake_fibo_x64
	./bench.sh $(BUILD_DIR) pancake_fibo_x64_ffi
	./bench.sh $(BUILD_DIR) c_fibo_x64

build:
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all build
