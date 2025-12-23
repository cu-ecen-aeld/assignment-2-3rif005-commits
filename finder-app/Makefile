# Variable for compiler. Defaults to gcc, but can be overridden
CC = $(CROSS_COMPILE)gcc
# Compiler flags (optional but good practice)
CFLAGS = -g -Wall

# Default target: builds the 'writer' executable
all: writer

# Rule to build 'writer' from 'writer.c'
writer: writer.c
	$(CC) $(CFLAGS) -o writer writer.c

# Clean target: removes the executable and object files
clean:
	rm -f writer *.o
