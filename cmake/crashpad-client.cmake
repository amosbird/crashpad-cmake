# Crashpad client library
add_library(crashpad_client STATIC)

set_target_properties(crashpad_client PROPERTIES
    CXX_STANDARD 14
    POSITION_INDEPENDENT_CODE ON
    CXX_VISIBILITY_PRESET "hidden"
    C_VISIBILITY_PRESET "hidden"
    VISIBILITY_INLINES_HIDDEN ON
)

target_include_directories(crashpad_client SYSTEM PUBLIC
    ${MINI_CHROMIUM_SRC_DIR}
    ${CRASHPAD_SRC_DIR}
)

target_link_libraries(crashpad_client PRIVATE
    minichromium
    crashpad_common
    crashpad_compat
    crashpad_util
)

target_sources(crashpad_client PRIVATE
    ${CRASHPAD_SRC_DIR}/client/annotation.cc
    ${CRASHPAD_SRC_DIR}/client/annotation_list.cc
    ${CRASHPAD_SRC_DIR}/client/crash_report_database.cc
    ${CRASHPAD_SRC_DIR}/client/crashpad_info.cc
    ${CRASHPAD_SRC_DIR}/client/prune_crash_reports.cc
    ${CRASHPAD_SRC_DIR}/client/settings.cc
)

if(APPLE)
    target_sources(crashpad_client PRIVATE
        ${CRASHPAD_SRC_DIR}/client/crash_report_database_mac.mm
        ${CRASHPAD_SRC_DIR}/client/crashpad_client_mac.cc
        ${CRASHPAD_SRC_DIR}/client/simulate_crash_mac.cc
    )
endif()

if (UNIX AND NOT APPLE)
    target_sources(crashpad_client PRIVATE
        ${CRASHPAD_SRC_DIR}/client/crashpad_client_linux.cc
        ${CRASHPAD_SRC_DIR}/client/client_argv_handling.cc
        ${CRASHPAD_SRC_DIR}/client/crashpad_info_note.S
        ${CRASHPAD_SRC_DIR}/client/crash_report_database_generic.cc
    )
endif()

if(WIN32)
    target_sources(crashpad_client PRIVATE
        ${CRASHPAD_SRC_DIR}/client/crash_report_database_win.cc
        ${CRASHPAD_SRC_DIR}/client/crashpad_client_win.cc
    )
endif()
