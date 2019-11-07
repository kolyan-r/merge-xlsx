cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_STANDARD 17)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -W -Wall -Werror -Wno-unused-parameter -Wno-sign-compare -Wno-ignored-qualifiers -Wno-unknown-pragmas -Wno-unused-variable -Wno-unused-but-set-variable -pedantic -std=c++17 -fdiagnostics-color=always")

if (CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread -fdiagnostics-color=always")
endif()

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

if(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/cmake-conan/conanbuildinfo.cmake)
    message(FATAL_ERROR "The file conanbuildinfo.cmake doesn't exist, you have to run conan install first")
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake-conan/conanbuildinfo.cmake)
conan_basic_setup()

add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/src")