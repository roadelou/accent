################################### METADATA ###################################

# Contributors: roadelou
# Contacts: 
# Creation Date: 2021-03-18
# Language: Makefile

################################### ALIASES ####################################

# Compass source code for the substitutions.
CMPS = $(CURDIR)/src/accent.cmps
# C source code with the main.
MAIN = $(CURDIR)/src/main.c
# Build directory.
BUILDDIR = $(CURDIR)/build
# Header for the accent state machine.
CMPS_HEAD = $(BUILDDIR)/accent.h
# Source code for the accent state machine.
CMPS_SRC = $(BUILDDIR)/accent.c
# Compiled ELF file.
EXEC = $(BUILDDIR)/accent.elf

################################### SPECIAL ####################################

.PHONY: all clean

#################################### RULES #####################################

all: $(EXEC)

$(EXEC): $(CMPS_HEAD) $(CMPS_SRC) $(MAIN) $(BUILDDIR)
	$(CC) -Wall -pedantic -I $(BUILDDIR) $(CMPS_SRC) $(MAIN) -o $(EXEC)

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

$(CMPS_HEAD): $(CMPS) $(BUILDDIR)
	compass --lang H --output $(CMPS_HEAD) $(CMPS)

$(CMPS_SRC): $(CMPS) $(BUILDDIR)
	compass --lang C --output $(CMPS_SRC) $(CMPS)

clean:
	rm -f $(EXEC) $(CMPS_HEAD) $(CMPS_SRC)

##################################### EOF ######################################
