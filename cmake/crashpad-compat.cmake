# Compat library.
if(APPLE)
    add_library(crashpad_compat INTERFACE)
else()
    add_library(crashpad_compat STATIC)
    target_link_libraries(crashpad_compat PRIVATE crashpad_common)

    set_target_properties(crashpad_compat
        PROPERTIES
        CXX_STANDARD 14
        POSITION_INDEPENDENT_CODE ON
        CXX_VISIBILITY_PRESET "hidden"
        C_VISIBILITY_PRESET "hidden"
        VISIBILITY_INLINES_HIDDEN ON
    )
endif()


if(WIN32)
    target_sources(crashpad_compat PRIVATE
        ${CRASHPAD_SRC_DIR}/compat/win/strings.cc
        ${CRASHPAD_SRC_DIR}/compat/win/time.cc
        ${CRASHPAD_SRC_DIR}/third_party/getopt/getopt.cc
    )

    target_include_directories(crashpad_compat SYSTEM PUBLIC
        ${CRASHPAD_SRC_DIR}/compat/win
        ${CRASHPAD_SRC_DIR}/third_party/getopt
    )
else()
    target_include_directories(crashpad_compat SYSTEM INTERFACE
        ${CRASHPAD_SRC_DIR}/compat/non_win
    )
endif()

# Linux mostly.
if(UNIX AND NOT APPLE)
    target_sources(crashpad_compat PRIVATE
        ${CRASHPAD_SRC_DIR}/compat/linux/sys/mman_memfd_create.cc
    )

    target_include_directories(crashpad_compat SYSTEM PUBLIC
        ${CRASHPAD_SRC_DIR}/compat/linux
    )
else()
    target_include_directories(crashpad_compat SYSTEM INTERFACE
        ${CRASHPAD_SRC_DIR}/compat/non_elf
    )
endif()

if(APPLE)
    target_include_directories(crashpad_compat SYSTEM INTERFACE
        ${CRASHPAD_SRC_DIR}/compat/mac
    )
else()
    target_include_directories(crashpad_compat SYSTEM PUBLIC
        ${CRASHPAD_SRC_DIR}/compat/non_mac
    )
endif()
