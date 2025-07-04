crashpad_add_test(crashpad_client_test)

target_sources(crashpad_client_test PRIVATE
    ${CRASHPAD_SRC_DIR}/client/annotation_list_test.cc
    ${CRASHPAD_SRC_DIR}/client/annotation_test.cc
    ${CRASHPAD_SRC_DIR}/client/crash_report_database_test.cc
    ${CRASHPAD_SRC_DIR}/client/prune_crash_reports_test.cc
    ${CRASHPAD_SRC_DIR}/client/settings_test.cc
    ${CRASHPAD_SRC_DIR}/client/simple_address_range_bag_test.cc
    ${CRASHPAD_SRC_DIR}/client/simple_string_dictionary_test.cc
)

if(APPLE)
    target_sources(crashpad_client_test PRIVATE
        ${CRASHPAD_SRC_DIR}/client/simulate_crash_mac_test.cc
    )
endif()

target_link_libraries(crashpad_client_test PRIVATE
    crashpad_util
    crashpad_snapshot
    crashpad_client
    crashpad_test
    crashpad_handler_obj
    snapshot_test_support
    gtest
    gtest_main
    gmock
    minichromium
    ch-contrib::zlib
)
