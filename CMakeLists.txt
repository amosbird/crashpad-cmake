set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake/")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})

set(CRASHPAD_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../crashpad)
set(MINI_CHROMIUM_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../mini_chromium)

add_compile_options(
    "-w"
    "-isystem$ENV{TSEARCH_TOOLCHAIN_PATH}/usr/include"
    "-isystem$ENV{TSEARCH_TOOLCHAIN_PATH}/usr/include/x86_64-linux-gnu"
)

include(crashpad-common)
include(minichromium)
include(crashpad-compat)
include(crashpad-tools)
include(crashpad-util)
include(crashpad-client)
include(crashpad-minidump)
include(crashpad-snapshot)
include(crashpad-handler)

add_library(crashpad STATIC crashpad.cc)
target_link_libraries(crashpad PRIVATE crashpad_client)
