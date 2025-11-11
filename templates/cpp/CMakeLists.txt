cmake_minimum_required(VERSION 3.16)
project(cpp_starter LANGUAGES CXX)

# Options
set(CPP_STARTER_CXX_STANDARD 20 CACHE STRING "C++ standard to use")
set(CMAKE_CXX_STANDARD ${CPP_STARTER_CXX_STANDARD})
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Output dirs
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Dependencies via CPM.cmake
set(CPM_DOWNLOAD_VERSION 0.38.7)
if(NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/cmake/CPM.cmake")
  message(STATUS "Downloading CPM.cmake")
  file(DOWNLOAD
    https://github.com/cpm-cmake/CPM.cmake/releases/download/v${CPM_DOWNLOAD_VERSION}/CPM.cmake
    ${CMAKE_CURRENT_LIST_DIR}/cmake/CPM.cmake
    TLS_VERIFY ON)
endif()
include(cmake/CPM.cmake)

# Catch2 (for tests)
CPMAddPackage("gh:catchorg/Catch2@3.6.0")

# Targets
add_library(greeter src/lib/greeter.cpp)
target_include_directories(greeter PUBLIC ${CMAKE_CURRENT_LIST_DIR}/include)
target_compile_options(greeter PRIVATE -Wall -Wextra -Wpedantic)

add_executable(hello src/main.cpp)
target_link_libraries(hello PRIVATE greeter)

# Tests
enable_testing()
add_executable(tests tests/test_greeter.cpp)
target_link_libraries(tests PRIVATE greeter Catch2::Catch2WithMain)
include(CTest)
include(Catch)
catch_discover_tests(tests)
