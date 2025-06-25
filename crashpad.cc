#include <client/crash_report_database.h>
#include <client/crashpad_client.h>
#include <client/settings.h>

bool InitializeCrashpad(const std::string & db, const std::string & hd, const std::string & url)
{
    // Cache directory that will store crashpad information and minidumps
    base::FilePath database(db);
    // Path to the out-of-process handler executable
    base::FilePath handler(hd);
    // Optional annotations passed via --annotations to the handler
    std::map<std::string, std::string> annotations;
    // Optional arguments to pass to the handler
    // std::vector<std::string> arguments;
    std::vector<std::string> arguments = {
        "--no-rate-limit",
        "--no-upload-gzip"
    };

    crashpad::CrashpadClient client;
    bool success = client.StartHandler(
        handler,
        database,
        database,
        url,
        annotations,
        arguments,
        /* restartable */ true,
        /* asynchronous_start */ false);

    return success;
}
