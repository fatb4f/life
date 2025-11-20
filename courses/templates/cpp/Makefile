BUILD_DIR ?= build
BUILD_TYPE ?= Release
GEN_COMPILE_COMMANDS ?= ON

.PHONY: all debug configure run test clang gcc tidy format clean distclean

all:
	@$(MAKE) configure
	@cmake --build $(BUILD_DIR) -j

debug:
	@$(MAKE) BUILD_TYPE=Debug all

configure:
	@cmake -S . -B $(BUILD_DIR) \
		-DCMAKE_BUILD_TYPE=$(BUILD_TYPE) \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=$(GEN_COMPILE_COMMANDS)
	@if [ -f "$(BUILD_DIR)/compile_commands.json" ]; then ln -sf $(BUILD_DIR)/compile_commands.json compile_commands.json; fi

run: all
	@$(BUILD_DIR)/bin/hello

test: all
	@ctest --test-dir $(BUILD_DIR) --output-on-failure

gcc:
	@$(MAKE) CXX=g++ BUILD_DIR=build-gcc all

clang:
	@$(MAKE) CXX=clang++ BUILD_DIR=build-clang all

tidy:
	@clang-tidy $(shell find src include -name '*.cpp' -o -name '*.hpp') -- -std=c++20

format:
	@clang-format -i $(shell find src include tests -name '*.cpp' -o -name '*.hpp' -o -name '*.cc')

clean:
	@rm -rf $(BUILD_DIR)

distclean: clean
	@rm -f compile_commands.json
