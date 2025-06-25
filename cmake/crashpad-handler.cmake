# Handler executable
add_library(crashpad_handler_obj OBJECT)

set_target_properties(crashpad_handler_obj PROPERTIES
    CXX_STANDARD 14
    POSITION_INDEPENDENT_CODE ON
    CXX_VISIBILITY_PRESET "hidden"
    C_VISIBILITY_PRESET "hidden"
    VISIBILITY_INLINES_HIDDEN ON
)

target_link_libraries(crashpad_handler_obj PRIVATE
    minichromium
    crashpad_common
    crashpad_compat
    crashpad_client
    crashpad_minidump
    crashpad_snapshot
    crashpad_tools
    ch_contrib::zlib
)

target_sources(crashpad_handler_obj PRIVATE
    ${CRASHPAD_SRC_DIR}/handler/crash_report_upload_thread.cc
    ${CRASHPAD_SRC_DIR}/handler/handler_main.cc
    ${CRASHPAD_SRC_DIR}/handler/minidump_to_upload_parameters.cc
    ${CRASHPAD_SRC_DIR}/handler/prune_crash_reports_thread.cc
    ${CRASHPAD_SRC_DIR}/handler/user_stream_data_source.cc
)

if(UNIX AND NOT APPLE)
    target_sources(crashpad_handler_obj PRIVATE
        ${CRASHPAD_SRC_DIR}/handler/linux/capture_snapshot.cc
        ${CRASHPAD_SRC_DIR}/handler/linux/crash_report_exception_handler.cc
        ${CRASHPAD_SRC_DIR}/handler/linux/exception_handler_server.cc
    )

    if(NOT ANDROID)
        target_sources(crashpad_handler_obj PRIVATE
            ${CRASHPAD_SRC_DIR}/handler/linux/cros_crash_report_exception_handler.cc
        )
    endif()
endif()

add_executable(crashpad_handler ${CRASHPAD_SRC_DIR}/handler/main.cc)

set_target_properties(crashpad_handler PROPERTIES
    CXX_STANDARD 14
    POSITION_INDEPENDENT_CODE ON
    CXX_VISIBILITY_PRESET "hidden"
    C_VISIBILITY_PRESET "hidden"
    VISIBILITY_INLINES_HIDDEN ON
)

target_link_libraries(crashpad_handler PRIVATE
    minichromium
    crashpad_common
    crashpad_compat
    crashpad_client
    crashpad_minidump
    crashpad_snapshot
    crashpad_tools
    crashpad_handler_obj
    ch_contrib::zlib
)
