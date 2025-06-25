add_library(minichromium STATIC)

set_target_properties(minichromium
    PROPERTIES
    CXX_STANDARD 14
    POSITION_INDEPENDENT_CODE ON
    CXX_VISIBILITY_PRESET "hidden"
    C_VISIBILITY_PRESET "hidden"
    VISIBILITY_INLINES_HIDDEN ON
)

target_link_libraries(minichromium PRIVATE crashpad_common)

target_sources(minichromium PRIVATE
    ${MINI_CHROMIUM_SRC_DIR}/base/debug/alias.cc
    ${MINI_CHROMIUM_SRC_DIR}/base/files/file_path.cc
    ${MINI_CHROMIUM_SRC_DIR}/base/files/scoped_file.cc
    ${MINI_CHROMIUM_SRC_DIR}/base/logging.cc
    ${MINI_CHROMIUM_SRC_DIR}/base/process/memory.cc
    ${MINI_CHROMIUM_SRC_DIR}/base/rand_util.cc
    ${MINI_CHROMIUM_SRC_DIR}/base/strings/string_number_conversions.cc
    ${MINI_CHROMIUM_SRC_DIR}/base/strings/stringprintf.cc
    ${MINI_CHROMIUM_SRC_DIR}/base/strings/utf_string_conversion_utils.cc
    ${MINI_CHROMIUM_SRC_DIR}/base/strings/utf_string_conversions.cc
    ${MINI_CHROMIUM_SRC_DIR}/base/synchronization/lock.cc
    ${MINI_CHROMIUM_SRC_DIR}/base/third_party/icu/icu_utf.cc
    ${MINI_CHROMIUM_SRC_DIR}/base/threading/thread_local_storage.cc
)

if(UNIX)
    target_sources(minichromium PRIVATE
        ${MINI_CHROMIUM_SRC_DIR}/base/files/file_util_posix.cc
        ${MINI_CHROMIUM_SRC_DIR}/base/memory/page_size_posix.cc
        ${MINI_CHROMIUM_SRC_DIR}/base/posix/safe_strerror.cc
        ${MINI_CHROMIUM_SRC_DIR}/base/synchronization/condition_variable_posix.cc
        ${MINI_CHROMIUM_SRC_DIR}/base/synchronization/lock_impl_posix.cc
        ${MINI_CHROMIUM_SRC_DIR}/base/threading/thread_local_storage_posix.cc
    )
endif()
