#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

int main(int argc, char *argv[]) {
    // Setup syslog logging
    openlog("writer", LOG_PID, LOG_USER);

    // Check if we have exactly 2 arguments (plus the program name = 3)
    if (argc != 3) {
        syslog(LOG_ERR, "Invalid number of arguments: %d", argc - 1);
        printf("Error: Two arguments required: <writefile> <writestr>\n");
        closelog();
        return 1;
    }

    const char *filepath = argv[1];
    const char *string_to_write = argv[2];

    // Log the action
    syslog(LOG_DEBUG, "Writing %s to %s", string_to_write, filepath);

    // Open the file for writing (Create if not exists, Truncate if exists)
    // 0644 sets permissions: Read/Write for owner, Read for others.
    int fd = open(filepath, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd == -1) {
        syslog(LOG_ERR, "Failed to open file %s: %s", filepath, strerror(errno));
        perror("Error opening file");
        closelog();
        return 1;
    }

    // Write the string to the file
    ssize_t nr = write(fd, string_to_write, strlen(string_to_write));
    if (nr == -1) {
        syslog(LOG_ERR, "Failed to write to file %s: %s", filepath, strerror(errno));
        perror("Error writing to file");
        close(fd);
        closelog();
        return 1;
    }

    // Close file and syslog
    close(fd);
    closelog();
    
    return 0;
}
