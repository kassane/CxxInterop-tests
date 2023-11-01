cmake_minimum_required(VERSION 3.0)
project(libcats)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(cats STATIC cats.cpp)
install(TARGETS cats DESTINATION .)
