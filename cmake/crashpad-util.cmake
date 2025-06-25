# Utils library
add_library(crashpad_util STATIC)

set_target_properties(crashpad_util PROPERTIES
    CXX_STANDARD 14
    POSITION_INDEPENDENT_CODE ON
    CXX_VISIBILITY_PRESET "hidden"
    C_VISIBILITY_PRESET "hidden"
    VISIBILITY_INLINES_HIDDEN ON
)

target_compile_definitions(crashpad_util PRIVATE
    -DZLIB_CONST
)

target_link_libraries(crashpad_util PRIVATE
    minichromium
    crashpad_common
    crashpad_compat
    PUBLIC
    ch_contrib::zlib
)

target_sources(crashpad_util PRIVATE
    ${CRASHPAD_SRC_DIR}/util/file/delimited_file_reader.cc
    ${CRASHPAD_SRC_DIR}/util/file/file_helper.cc
    ${CRASHPAD_SRC_DIR}/util/file/file_io.cc
    ${CRASHPAD_SRC_DIR}/util/file/file_reader.cc
    ${CRASHPAD_SRC_DIR}/util/file/file_seeker.cc
    ${CRASHPAD_SRC_DIR}/util/file/file_writer.cc
    ${CRASHPAD_SRC_DIR}/util/file/output_stream_file_writer.cc
    ${CRASHPAD_SRC_DIR}/util/file/scoped_remove_file.cc
    ${CRASHPAD_SRC_DIR}/util/file/string_file.cc
    ${CRASHPAD_SRC_DIR}/util/misc/initialization_state_dcheck.cc
    ${CRASHPAD_SRC_DIR}/util/misc/lexing.cc
    ${CRASHPAD_SRC_DIR}/util/misc/metrics.cc
    ${CRASHPAD_SRC_DIR}/util/misc/pdb_structures.cc
    ${CRASHPAD_SRC_DIR}/util/misc/random_string.cc
    ${CRASHPAD_SRC_DIR}/util/misc/range_set.cc
    ${CRASHPAD_SRC_DIR}/util/misc/reinterpret_bytes.cc
    ${CRASHPAD_SRC_DIR}/util/misc/scoped_forbid_return.cc
    ${CRASHPAD_SRC_DIR}/util/misc/time.cc
    ${CRASHPAD_SRC_DIR}/util/misc/uuid.cc
    ${CRASHPAD_SRC_DIR}/util/misc/zlib.cc
    ${CRASHPAD_SRC_DIR}/util/net/http_body.cc
    ${CRASHPAD_SRC_DIR}/util/net/http_body_gzip.cc
    ${CRASHPAD_SRC_DIR}/util/net/http_multipart_builder.cc
    ${CRASHPAD_SRC_DIR}/util/net/http_transport.cc
    ${CRASHPAD_SRC_DIR}/util/net/url.cc
    ${CRASHPAD_SRC_DIR}/util/numeric/checked_address_range.cc
    ${CRASHPAD_SRC_DIR}/util/process/process_memory.cc
    ${CRASHPAD_SRC_DIR}/util/process/process_memory_range.cc
    ${CRASHPAD_SRC_DIR}/util/stdlib/aligned_allocator.cc
    ${CRASHPAD_SRC_DIR}/util/stdlib/string_number_conversion.cc
    ${CRASHPAD_SRC_DIR}/util/stdlib/strlcpy.cc
    ${CRASHPAD_SRC_DIR}/util/stdlib/strnlen.cc
    ${CRASHPAD_SRC_DIR}/util/stream/base94_output_stream.cc
    ${CRASHPAD_SRC_DIR}/util/stream/file_encoder.cc
    ${CRASHPAD_SRC_DIR}/util/stream/file_output_stream.cc
    ${CRASHPAD_SRC_DIR}/util/stream/log_output_stream.cc
    ${CRASHPAD_SRC_DIR}/util/stream/zlib_output_stream.cc
    ${CRASHPAD_SRC_DIR}/util/string/split_string.cc
    ${CRASHPAD_SRC_DIR}/util/thread/thread.cc
    ${CRASHPAD_SRC_DIR}/util/thread/thread_log_messages.cc
    ${CRASHPAD_SRC_DIR}/util/thread/worker_thread.cc
    ${CRASHPAD_SRC_DIR}/util/file/directory_reader_posix.cc
    ${CRASHPAD_SRC_DIR}/util/file/file_io_posix.cc
    ${CRASHPAD_SRC_DIR}/util/file/filesystem_posix.cc
    ${CRASHPAD_SRC_DIR}/util/misc/clock_posix.cc
    ${CRASHPAD_SRC_DIR}/util/posix/close_stdio.cc
    ${CRASHPAD_SRC_DIR}/util/posix/scoped_dir.cc
    ${CRASHPAD_SRC_DIR}/util/posix/scoped_mmap.cc
    ${CRASHPAD_SRC_DIR}/util/posix/signals.cc
    ${CRASHPAD_SRC_DIR}/util/synchronization/semaphore_posix.cc
    ${CRASHPAD_SRC_DIR}/util/thread/thread_posix.cc
    ${CRASHPAD_SRC_DIR}/util/posix/close_multiple.cc
    ${CRASHPAD_SRC_DIR}/util/posix/double_fork_and_exec.cc
    ${CRASHPAD_SRC_DIR}/util/posix/drop_privileges.cc
    ${CRASHPAD_SRC_DIR}/util/posix/symbolic_constants_posix.cc
    ${CRASHPAD_SRC_DIR}/util/net/http_transport_socket.cc
    ${CRASHPAD_SRC_DIR}/util/linux/auxiliary_vector.cc
    ${CRASHPAD_SRC_DIR}/util/linux/direct_ptrace_connection.cc
    ${CRASHPAD_SRC_DIR}/util/linux/exception_handler_client.cc
    ${CRASHPAD_SRC_DIR}/util/linux/exception_handler_protocol.cc
    ${CRASHPAD_SRC_DIR}/util/linux/memory_map.cc
    ${CRASHPAD_SRC_DIR}/util/linux/proc_stat_reader.cc
    ${CRASHPAD_SRC_DIR}/util/linux/proc_task_reader.cc
    ${CRASHPAD_SRC_DIR}/util/linux/ptrace_broker.cc
    ${CRASHPAD_SRC_DIR}/util/linux/ptrace_client.cc
    ${CRASHPAD_SRC_DIR}/util/linux/ptracer.cc
    ${CRASHPAD_SRC_DIR}/util/linux/scoped_pr_set_dumpable.cc
    ${CRASHPAD_SRC_DIR}/util/linux/scoped_pr_set_ptracer.cc
    ${CRASHPAD_SRC_DIR}/util/linux/scoped_ptrace_attach.cc
    ${CRASHPAD_SRC_DIR}/util/linux/socket.cc
    ${CRASHPAD_SRC_DIR}/util/linux/thread_info.cc
    ${CRASHPAD_SRC_DIR}/util/misc/capture_context_linux.S
    ${CRASHPAD_SRC_DIR}/util/misc/paths_linux.cc
    ${CRASHPAD_SRC_DIR}/util/misc/time_linux.cc
    ${CRASHPAD_SRC_DIR}/util/posix/process_info_linux.cc
    ${CRASHPAD_SRC_DIR}/util/process/process_memory_linux.cc
    ${CRASHPAD_SRC_DIR}/util/process/process_memory_sanitized.cc
)
