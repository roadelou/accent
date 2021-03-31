# Makefile compiled automatically by compass-build.

SRC_DIR = src
BUILD_DIR = build
COMPASS_FLAGS = -c $(CFLAGS)
SRC_ACCENT = $(SRC_DIR)/accent.cmps
SRC_A_LOW_FSM = $(SRC_DIR)/a_low_fsm.cmps
SRC_A_UP_FSM = $(SRC_DIR)/a_up_fsm.cmps
SRC_E_LOW_FSM = $(SRC_DIR)/e_low_fsm.cmps
SRC_E_UP_FSM = $(SRC_DIR)/e_up_fsm.cmps
SRC_C_LOW_FSM = $(SRC_DIR)/c_low_fsm.cmps
SRC_C_UP_FSM = $(SRC_DIR)/c_up_fsm.cmps
SRC_O_LOW_FSM = $(SRC_DIR)/o_low_fsm.cmps
SRC_O_UP_FSM = $(SRC_DIR)/o_up_fsm.cmps

# C source code with the main function.
SRC_MAIN = $(SRC_DIR)/main.c

DEST_ACCENT = $(BUILD_DIR)/accent.o
DEST_C_ACCENT = $(BUILD_DIR)/accent.c
DEST_A_LOW_FSM = $(BUILD_DIR)/a_low_fsm.o
DEST_C_A_LOW_FSM = $(BUILD_DIR)/a_low_fsm.c
DEST_A_UP_FSM = $(BUILD_DIR)/a_up_fsm.o
DEST_C_A_UP_FSM = $(BUILD_DIR)/a_up_fsm.c
DEST_E_LOW_FSM = $(BUILD_DIR)/e_low_fsm.o
DEST_C_E_LOW_FSM = $(BUILD_DIR)/e_low_fsm.c
DEST_E_UP_FSM = $(BUILD_DIR)/e_up_fsm.o
DEST_C_E_UP_FSM = $(BUILD_DIR)/e_up_fsm.c
DEST_C_LOW_FSM = $(BUILD_DIR)/c_low_fsm.o
DEST_C_C_LOW_FSM = $(BUILD_DIR)/c_low_fsm.c
DEST_C_UP_FSM = $(BUILD_DIR)/c_up_fsm.o
DEST_C_C_UP_FSM = $(BUILD_DIR)/c_up_fsm.c
DEST_O_LOW_FSM = $(BUILD_DIR)/o_low_fsm.o
DEST_C_O_LOW_FSM = $(BUILD_DIR)/o_low_fsm.c
DEST_O_UP_FSM = $(BUILD_DIR)/o_up_fsm.o
DEST_C_O_UP_FSM = $(BUILD_DIR)/o_up_fsm.c
ALL_DEST = $(DEST_ACCENT) $(DEST_A_LOW_FSM) $(DEST_A_UP_FSM) $(DEST_E_LOW_FSM) $(DEST_E_UP_FSM) $(DEST_C_LOW_FSM) $(DEST_C_UP_FSM) $(DEST_O_LOW_FSM) $(DEST_O_UP_FSM)
ALL_DEST_C = $(DEST_C_ACCENT) $(DEST_C_A_LOW_FSM) $(DEST_C_A_UP_FSM) $(DEST_C_E_LOW_FSM) $(DEST_C_E_UP_FSM) $(DEST_C_C_LOW_FSM) $(DEST_C_C_UP_FSM) $(DEST_C_O_LOW_FSM) $(DEST_C_O_UP_FSM)

SRC_ENTRY_POINT = $(SRC_ACCENT)
HEAD_ENTRY_POINT = $(BUILD_DIR)/accent_compass.h

# Final elf executable.
ELF = $(BUILD_DIR)/accent.elf

################################################################################

.PHONY: all clean

all: $(ELF)

$(ELF): $(ALL_DEST) $(HEAD_ENTRY_POINT) $(BUILD_DIR) $(SRC_MAIN)
	$(CC) $(CFLAGS) -I $(BUILD_DIR) -o $(ELF) $(SRC_MAIN) $(ALL_DEST)

$(HEAD_ENTRY_POINT): $(SRC_ENTRY_POINT)
	compass -r accent -o $(HEAD_ENTRY_POINT) --lang header $(SRC_ENTRY_POINT)

$(DEST_C_ACCENT): $(SRC_ACCENT) $(BUILD_DIR)
	compass -r accent -o $(DEST_C_ACCENT) --lang C $(SRC_ACCENT)

$(DEST_ACCENT): $(DEST_C_ACCENT) $(BUILD_DIR)
	$(CC) $(COMPASS_FLAGS) -o $(DEST_ACCENT) $(DEST_C_ACCENT)

$(DEST_C_A_LOW_FSM): $(SRC_A_LOW_FSM) $(BUILD_DIR)
	compass -r a_low_fsm -o $(DEST_C_A_LOW_FSM) --lang C $(SRC_A_LOW_FSM)

$(DEST_A_LOW_FSM): $(DEST_C_A_LOW_FSM) $(BUILD_DIR)
	$(CC) $(COMPASS_FLAGS) -o $(DEST_A_LOW_FSM) $(DEST_C_A_LOW_FSM)

$(DEST_C_A_UP_FSM): $(SRC_A_UP_FSM) $(BUILD_DIR)
	compass -r a_up_fsm -o $(DEST_C_A_UP_FSM) --lang C $(SRC_A_UP_FSM)

$(DEST_A_UP_FSM): $(DEST_C_A_UP_FSM) $(BUILD_DIR)
	$(CC) $(COMPASS_FLAGS) -o $(DEST_A_UP_FSM) $(DEST_C_A_UP_FSM)

$(DEST_C_E_LOW_FSM): $(SRC_E_LOW_FSM) $(BUILD_DIR)
	compass -r e_low_fsm -o $(DEST_C_E_LOW_FSM) --lang C $(SRC_E_LOW_FSM)

$(DEST_E_LOW_FSM): $(DEST_C_E_LOW_FSM) $(BUILD_DIR)
	$(CC) $(COMPASS_FLAGS) -o $(DEST_E_LOW_FSM) $(DEST_C_E_LOW_FSM)

$(DEST_C_E_UP_FSM): $(SRC_E_UP_FSM) $(BUILD_DIR)
	compass -r e_up_fsm -o $(DEST_C_E_UP_FSM) --lang C $(SRC_E_UP_FSM)

$(DEST_E_UP_FSM): $(DEST_C_E_UP_FSM) $(BUILD_DIR)
	$(CC) $(COMPASS_FLAGS) -o $(DEST_E_UP_FSM) $(DEST_C_E_UP_FSM)

$(DEST_C_C_LOW_FSM): $(SRC_C_LOW_FSM) $(BUILD_DIR)
	compass -r c_low_fsm -o $(DEST_C_C_LOW_FSM) --lang C $(SRC_C_LOW_FSM)

$(DEST_C_LOW_FSM): $(DEST_C_C_LOW_FSM) $(BUILD_DIR)
	$(CC) $(COMPASS_FLAGS) -o $(DEST_C_LOW_FSM) $(DEST_C_C_LOW_FSM)

$(DEST_C_C_UP_FSM): $(SRC_C_UP_FSM) $(BUILD_DIR)
	compass -r c_up_fsm -o $(DEST_C_C_UP_FSM) --lang C $(SRC_C_UP_FSM)

$(DEST_C_UP_FSM): $(DEST_C_C_UP_FSM) $(BUILD_DIR)
	$(CC) $(COMPASS_FLAGS) -o $(DEST_C_UP_FSM) $(DEST_C_C_UP_FSM)

$(DEST_C_O_LOW_FSM): $(SRC_O_LOW_FSM) $(BUILD_DIR)
	compass -r o_low_fsm -o $(DEST_C_O_LOW_FSM) --lang C $(SRC_O_LOW_FSM)

$(DEST_O_LOW_FSM): $(DEST_C_O_LOW_FSM) $(BUILD_DIR)
	$(CC) $(COMPASS_FLAGS) -o $(DEST_O_LOW_FSM) $(DEST_C_O_LOW_FSM)

$(DEST_C_O_UP_FSM): $(SRC_O_UP_FSM) $(BUILD_DIR)
	compass -r o_up_fsm -o $(DEST_C_O_UP_FSM) --lang C $(SRC_O_UP_FSM)

$(DEST_O_UP_FSM): $(DEST_C_O_UP_FSM) $(BUILD_DIR)
	$(CC) $(COMPASS_FLAGS) -o $(DEST_O_UP_FSM) $(DEST_C_O_UP_FSM)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -f $(ALL_DEST) $(ALL_DEST_C) $(HEAD_ENTRY_POINT) $(DEBUG_ENTRY_POINT) $(DEBUG_C_ENTRY_POINT)

