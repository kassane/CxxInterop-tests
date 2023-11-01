cmake_minimum_required(VERSION 3.20)
project(externC_Swift LANGUAGES CXX Swift)

set(CMAKE_Swift_COMPILER_VERSION 5.9)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
# Verify that we have a new enough compiler
if("${CMAKE_Swift_COMPILER_VERSION}" VERSION_LESS 5.9)
  message(FATAL_ERROR "Bidirectional C++ Interop requires Swift 5.9 or greater. Have ${CMAKE_Swift_COMPILER_VERSION}")
endif()
include_directories(../cpp)
add_library(cats STATIC ../cpp/cats.cpp)
add_executable(${PROJECT_NAME} Sources/cat.swift)
target_link_libraries(${PROJECT_NAME} PRIVATE cats)
target_compile_options(${PROJECT_NAME} PUBLIC
  "$<$<COMPILE_LANGUAGE:Swift>:-cxx-interoperability-mode=default>")

# Add a custom target to run the executable
add_custom_target(run
    COMMAND ${PROJECT_NAME}
    DEPENDS ${PROJECT_NAME}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)
# Set the "bench" target as the default target when building the project
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})

install(TARGETS ${PROJECT_NAME} DESTINATION .)
