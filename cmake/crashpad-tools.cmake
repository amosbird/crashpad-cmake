# Tools library
add_library(crashpad_tools STATIC)

set_target_properties(crashpad_tools
    PROPERTIES
    CXX_STANDARD 14
    POSITION_INDEPENDENT_CODE ON
    CXX_VISIBILITY_PRESET "hidden"
    C_VISIBILITY_PRESET "hidden"
    VISIBILITY_INLINES_HIDDEN ON
)

target_link_libraries(crashpad_tools PRIVATE
    minichromium
    crashpad_common
)

target_sources(crashpad_tools PRIVATE
    ${CRASHPAD_SRC_DIR}/tools/tool_support.cc
)

add_executable(crashpad_database_util ${CRASHPAD_SRC_DIR}/tools/crashpad_database_util.cc)

set_target_properties(crashpad_database_util PROPERTIES
    CXX_STANDARD 14
    POSITION_INDEPENDENT_CODE ON
    CXX_VISIBILITY_PRESET "hidden"
    C_VISIBILITY_PRESET "hidden"
    VISIBILITY_INLINES_HIDDEN ON
)

target_link_libraries(crashpad_database_util PRIVATE
    minichromium
    crashpad_tools
    crashpad_client
    crashpad_compat
    crashpad_util
)

add_executable(crashpad_http_upload ${CRASHPAD_SRC_DIR}/tools/crashpad_http_upload.cc)

set_target_properties(crashpad_http_upload PROPERTIES
    CXX_STANDARD 14
    POSITION_INDEPENDENT_CODE ON
    CXX_VISIBILITY_PRESET "hidden"
    C_VISIBILITY_PRESET "hidden"
    VISIBILITY_INLINES_HIDDEN ON
)

target_link_libraries(crashpad_http_upload PRIVATE
    minichromium
    crashpad_tools
    crashpad_client
    crashpad_compat
    crashpad_util
)
