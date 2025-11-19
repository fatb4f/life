#include "greeter.hpp"
#include <catch2/catch_all.hpp>

TEST_CASE("greet returns expected message") {
    REQUIRE(greet("World") == "Hello, World!");
    REQUIRE(greet("C++") == "Hello, C++!");
}
