/********************************** METADATA **********************************/

/*
 * Contributors: roadelou
 * Contacts:
 * Creation Date: 2021-03-18
 * Language: C Source
 */

/********************************** INCLUDES **********************************/

// Used for file operations.
#include <stdio.h>

// Used for malloc.
#include <stdlib.h>

// Used for getopt.
#include <getopt.h>

// Used for the accent state machine, built from Compass code.
#include <accent.h>

/********************************* SINGLETONS *********************************/

const char *help = ""
"Usage: accent [options] input_file\n"
"\n"
"Description\n"
"===========\n"
"Substitutes formatted text with french accents.\n"
"\n"
"Options\n"
"=======\n"
" -o, --output <output_file>\n"
"\tWrite the substituted string to th provided file, default is french.txt\n"
" -h, --help\n"
"\tPrints this message and exits";

/********************************* PROTOYPES **********************************/

// Returns the size of the provided file.
static size_t get_file_size(FILE *file);

/************************************ MAIN ************************************/

int main(int argc, char **argv) {
    // The path to the input file.
    char *input_path = NULL;
    // The path to the output file, with a default value.
    char *output_path = "french.txt";
    // A variable used to hold the getopt option.
    int getopt_option;
    // Description of the long command line options for getopt. See man 3
    // getopt.
    static struct option long_options[] = {
        {"output", required_argument, NULL, 'o'},
        {"help", no_argument, NULL, 'h'}};

    // Handling getopt arguments.
    while ((getopt_option = getopt_long(argc, (char *const *)argv, "+o:h",
                                        long_options, NULL)) != -1) {
        switch (getopt_option) {
        case 'o':
            // An explicit path for the output file was provided.
            output_path = optarg;
            break;
		case 'h':
			// Prints a simple help message to stdout.
			puts(help);
        default:
            // Invalid command line option.
            return -1;
        }
    }
    // We get the input file from the first positional argument.
    // Error handling.
    if (optind == argc) {
        fputs("No input file provided\n", stderr);
        return -1;
    }
    // else...
    input_path = argv[optind];

	// We open the input file.
	FILE *input_file = fopen(input_path, "r");
	// Error checking.
	if (input_file == NULL) {
		fprintf(stderr, "No such file %s\n", input_path);
		return -1;
	}

	// We open the output file to write the resulting text (we wouldn't want to
	// fail at the end of the execution because of that).
	FILE *output_file = fopen(output_path, "w");
	// Error checking.
	if (output_file == NULL) {
		fprintf(stderr, "Could not create file %s\n", output_path);
		return -1;
	}

	// We get the size of the input file from the OS.
	size_t input_size = get_file_size(input_file);

	// We allocate some memory for the output file.
	// NOTE
	// For the substitutions we are performing, we always replace 2x8 bits ASCII
	// characters with a 16 bits UTF-8 character, so the size should be the
	// same.
	char *output_buffer = malloc(input_size * sizeof(char));

	// Because the substitutions we are performing are always of the same size,
	// we will do them in-place. So we read the entire input file into the
	// output buffer.
	fread(output_buffer, sizeof(char), input_size, input_file);

	// We no longer need the input file, we may close it.
	fclose(input_file);
	
	// We create some cursors to read the input file and write the output one.
	size_t cursor = 0;

	// We create the signals for the state machine
	int token;
	int erase_previous = 1;
	// The two characters used to perform a substitution.
	int utf8_high;
	int utf8_low;

	// We use a loop to perform all the substitutions.
	for (cursor = 0; cursor < input_size; cursor++) {
		// Getting the next token. Note the implicit cast from char to int.
		token = output_buffer[cursor];
		// Calling the compass code.
		accent(&token, &erase_previous, &utf8_high, &utf8_low);
		if (erase_previous) {
			// If erase previous is set, we have to chenge the current character
			// we are pointing to (output_cursor has not been incremented yet)
			// and the next one.
			output_buffer[cursor-1] = utf8_high;
			output_buffer[cursor] = utf8_low;
		}
		// else...
		// If erase previous is not set, we have nothing to do, we just echoed
		// the same character.
	}

	// We write the new utf8 text to the output file.
	fwrite(output_buffer, sizeof(char), input_size, output_file);
	
	// We close the output file to trigger the flush.
	fclose(output_file);

	// We free the memory we had requested.
	free(output_buffer);

	// Execution is over, we exit.
	return EXIT_SUCCESS;
}

/********************************* FUNCTIONS **********************************/

static size_t get_file_size(FILE *file) {
	// We move to the end of the file.
	fseek(file, 0L, SEEK_END);
	// We get our current position.
	size_t current_position = ftell(file);
	// We rewind to the beginning of the file.
	rewind(file);
	// We return the expected size.
	return current_position;
}

/************************************ EOF *************************************/
