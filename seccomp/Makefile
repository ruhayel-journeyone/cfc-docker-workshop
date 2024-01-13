CC=gcc
CFLAGS=-Wall
BIN_DIR=bin

# The 'all' target will build both compliant and non-compliant programs
all: $(BIN_DIR) compliant non_compliant

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

compliant: compliant.c
	$(CC) $(CFLAGS) compliant.c -o $(BIN_DIR)/compliant -lseccomp

non_compliant: non_compliant.c
	$(CC) $(CFLAGS) non_compliant.c -o $(BIN_DIR)/non_compliant -lseccomp

run_compliant: $(BIN_DIR)/compliant
	./$(BIN_DIR)/compliant

run_non_compliant: $(BIN_DIR)/non_compliant
	./$(BIN_DIR)/non_compliant

# The 'clean' target will remove the compiled programs and the bin directory
clean:
	rm -rf $(BIN_DIR)

.PHONY: all compliant non_compliant run_compliant run_non_compliant clean
