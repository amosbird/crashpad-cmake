# Server exe for tests to run against
add_executable(http_transport_test_server 
    ${CRASHPAD_SRC_DIR}/util/net/http_transport_test_server.cc
)

set_target_properties(http_transport_test_server
    PROPERTIES
    CXX_STANDARD 14
    POSITION_INDEPENDENT_CODE ON
    CXX_VISIBILITY_PRESET "hidden"
    C_VISIBILITY_PRESET "hidden"
    VISIBILITY_INLINES_HIDDEN ON
)
  
target_link_libraries(http_transport_test_server
    PRIVATE
    crashpad_common
    crashpad_compat
    ch-contrib::zlib
    crashpad_util
    crashpad_tools
    minichromium
    $<$<CXX_COMPILER_ID:MSVC>:ws2_32.lib>
)

# Shared test library
add_library(crashpad_test OBJECT)

set_target_properties(crashpad_test
    PROPERTIES
    CXX_STANDARD 14
    POSITION_INDEPENDENT_CODE ON
    CXX_VISIBILITY_PRESET "hidden"
    C_VISIBILITY_PRESET "hidden"
    VISIBILITY_INLINES_HIDDEN ON
)

target_link_libraries(crashpad_test PRIVATE crashpad_common crashpad_compat)
target_link_libraries(crashpad_test PUBLIC gtest)

target_sources(crashpad_test
    PRIVATE
    ${CRASHPAD_SRC_DIR}/test/errors.cc
    ${CRASHPAD_SRC_DIR}/test/file.cc
    ${CRASHPAD_SRC_DIR}/test/filesystem.cc
    ${CRASHPAD_SRC_DIR}/test/hex_string.cc
    ${CRASHPAD_SRC_DIR}/test/main_arguments.cc
    ${CRASHPAD_SRC_DIR}/test/multiprocess_exec.cc
    ${CRASHPAD_SRC_DIR}/test/process_type.cc
    ${CRASHPAD_SRC_DIR}/test/scoped_module_handle.cc
    ${CRASHPAD_SRC_DIR}/test/scoped_temp_dir.cc
    ${CRASHPAD_SRC_DIR}/test/test_paths.cc
)

if(UNIX)
    target_sources(crashpad_test
        PRIVATE
        ${CRASHPAD_SRC_DIR}/test/scoped_guarded_page_posix.cc
        ${CRASHPAD_SRC_DIR}/test/scoped_temp_dir_posix.cc
        ${CRASHPAD_SRC_DIR}/test/multiprocess_exec_posix.cc
        ${CRASHPAD_SRC_DIR}/test/multiprocess_posix.cc
    )
endif()

if(APPLE)
    target_sources(crashpad_test
        PRIVATE
        ${CRASHPAD_SRC_DIR}/test/mac/dyld.cc
        ${CRASHPAD_SRC_DIR}/test/mac/exception_swallower.cc
        ${CRASHPAD_SRC_DIR}/test/mac/mach_errors.cc
        ${CRASHPAD_SRC_DIR}/test/mac/mach_multiprocess.cc
    )
endif()

if(UNIX AND NOT APPLE)
    target_sources(crashpad_test
        PRIVATE
        ${CRASHPAD_SRC_DIR}/test/linux/fake_ptrace_connection.cc
        ${CRASHPAD_SRC_DIR}/test/linux/get_tls.cc
    )
endif()

if(WIN32)
    target_sources(crashpad_test
        PRIVATE
        ${CRASHPAD_SRC_DIR}/test/multiprocess_exec_win.cc
        ${CRASHPAD_SRC_DIR}/test/scoped_guarded_page_win.cc
        ${CRASHPAD_SRC_DIR}/test/scoped_temp_dir_win.cc
        ${CRASHPAD_SRC_DIR}/test/win/child_launcher.cc
        ${CRASHPAD_SRC_DIR}/test/win/win_child_process.cc
        ${CRASHPAD_SRC_DIR}/test/win/win_multiprocess.cc
        ${CRASHPAD_SRC_DIR}/test/win/win_multiprocess_with_temp_dir.cc
    )
endif()

# This file is required for the tests to work - but
# the ctest launcher seems to run it from the subdirectory
# always - so let's make sure we copy it to two different places
file(
    COPY ${CRASHPAD_SRC_DIR}/test/test_paths_test_data_root.txt
    DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/test
)

file(
    COPY ${CRASHPAD_SRC_DIR}/test/test_paths_test_data_root.txt
    DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
)

add_library(gtest_main OBJECT)
set_target_properties(gtest_main
    PROPERTIES
    CXX_STANDARD 14
    POSITION_INDEPENDENT_CODE ON
    CXX_VISIBILITY_PRESET "hidden"
    C_VISIBILITY_PRESET "hidden"
    VISIBILITY_INLINES_HIDDEN ON
)
target_sources(gtest_main PRIVATE ${CRASHPAD_SRC_DIR}/test/gtest_main.cc)
target_link_libraries(gtest_main PUBLIC gtest PRIVATE crashpad_common minichromium)
target_compile_definitions(gtest_main PUBLIC CRASHPAD_TEST_LAUNCHER_GOOGLETEST)

add_library(gmock_main OBJECT)
set_target_properties(gmock_main
    PROPERTIES
    CXX_STANDARD 14
    POSITION_INDEPENDENT_CODE ON
    CXX_VISIBILITY_PRESET "hidden"
    C_VISIBILITY_PRESET "hidden"
    VISIBILITY_INLINES_HIDDEN ON
)
target_sources(gmock_main PRIVATE ${CRASHPAD_SRC_DIR}/test/gtest_main.cc)
target_link_libraries(gmock_main PUBLIC gmock gtest PRIVATE crashpad_common minichromium)
target_compile_definitions(gmock_main PUBLIC CRASHPAD_TEST_LAUNCHER_GOOGLEMOCK)

# Catch all target and macro to build tests
add_custom_target(build_tests)

macro(crashpad_add_test NAME)
    add_executable(${NAME})
    set_target_properties(${NAME}
        PROPERTIES
        CXX_STANDARD 14
        POSITION_INDEPENDENT_CODE ON
        CXX_VISIBILITY_PRESET "hidden"
        C_VISIBILITY_PRESET "hidden"
        VISIBILITY_INLINES_HIDDEN ON
    )

    target_link_libraries(${NAME} PRIVATE crashpad_common crashpad_compat)

    if(APPLE)
        target_link_libraries(${NAME} PRIVATE AppleFrameworks)
    endif()

    if(NOT ANDROID)
        gtest_discover_tests(${NAME} WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
    endif()
    add_dependencies(build_tests ${NAME})
endmacro()
