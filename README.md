# Introduction 
Build system for Atmega328p, the current project was develop to generate you own libraries and project from scratch, some libraries from AVR-GCC toolchain are available, but the main purpose is generate your own components.  

# Goal
The goal is to make a system with the capabilities to compile and upload your own programs with avrdude tool and avr-gcc toolchain.

# How to use
## Adding a new folder 
If we want to add a new folder to be compiled we should add some variables into some makefiles for that check the next sections: in *Makefile* section check first *set_path.mak* and after that follow with *build.mak*

## How to compile
In order to compile, run build.bat with the next arguments.
```
Use the build system in the next way:
./build.bat ARG1 ARG2

Where the ARG1 could be one of the next supported commands:
- all: release/debug clean upload (required the ARG2(debug/release))
- clean: clean working area
- release: compile project without debug information, generate a HEX output file
- debug: compile project with debug information, generate a HEX and ELF output file
- upload: upload executable 

The ARG2 is used in "all" command to indicate the compilation type and could be one
of the next commands:
- release: compile project without debug information, generate a HEX output file 
- debug: compile project with debug information, generate a HEX and ELF output file

E.g.
- ./build.bat all debug
- ./build.bat all release
- ./build.bat clean
- ./build.bat debug
- ./build.bat release
- ./build.bat upload debug
- ./build.bat upload release
```

## Upload tool avrdude
The build system use the avrdude to upload the compiled project, for that reason the microcontroller must have a bootloader.

The current build system is already tested with OPTIBOOT, this bootloader is included in the Arduino UNO board, I used only the board in order to test.

## Makefile 
The actual output file is generated with help of some makefiles as cfg.mak, set_path.mak and build.mak, in the next subsections will explain each makefile and how to configure for you own project.
### cfg.mak
The configuration makefile (cfg.mak) is used to configure parameter as application output name, port, baudrate and other things like compiler flags.

Here is encapsulated almost the main configuration for output and upload the output file the system.

```
############################
## Start user configuration 
############################
# Application output name 
APPLICATION_NAME = APP
# Board configuration (e.g. PORT, baudrate, programmer)
COM = COM3
BAUDRATE = 115200
# AVR BOARD definition for avrdude programmer
AVR_BOARD = ATMEGA328P
PROGRAMMER = arduino
# board definition for avr-gcc compiler
MMCU = atmega328p
############################
## End user configuration 
############################
```

### set_path.mak
The set_path makefile is used to declare all folder with our source code to be compiled, as shown in block below.

```
# Source code structure
SRC_DIR = $(CWD)\src
APP_DIR = $(SRC_DIR)\app

# Creating rules
# SRC
SRC = $(wildcard $(SRC_DIR)/*.c)
OBJ = $(patsubst $(SRC_DIR)/%.c, $(OUTPUT_DIR)/%.o, $(SRC))
INC_SRC = -I$(SRC_DIR) 

# APP
APP = $(wildcard $(APP_DIR)/*.c)
OBJ += $(patsubst $(APP_DIR)/%.c, $(OUTPUT_DIR)/%.o, $(APP))
INC_APP = -I$(APP_DIR)
```

In order to add a new folder, we should add a set of variables with our new folder name and the necessary includes to compile.

- Add folder directory variable
```
# Source code structure
COMP_DIR = $(CWD)\COMP
```

- Add the rule for our new folder, the new rule shall contain a variable with C files (e.g. COMP), append the object file into OBJ variable (e.g. OBJ), and the include variable (e.g.INC_COMP) for all required files and libraries for the compilation.
```
# COMP
COMP = $(wildcard $(COMP_DIR)/*.c)
OBJ += $(patsubst $(COMP_DIR)/%.c, $(OUTPUT_DIR)/%.o, $(COMP))
INC_COMP = -I$(COMP_DIR)
```
- Add the prints for the console (optional), in def_path, def_rule, and def_includes the new variables created shall be added in order to print the information into the console.
```
def_path:
	@echo Defining directories...
	@echo $(COMP_DIR)

def_rule:
	@echo Defining rules...
	@echo $(COMP)

def_includes:
	@echo Defining includes...
	@echo $(INC_COMP)
```

### build.mak
The build makefile is where all compilation rules will be called, for that reason we need to add the rule for the new folders. Go and find the next structure and add your new rule with the new folder. 
```
The structure for the rules is the next:
$(OUTPUT_DIR)/%.o: $(**COMP_DIR**)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(**INC_SRC**)

Add the new rule with the same structure only replace the the BOLD word with your own folder to be added.
$(OUTPUT_DIR)/%.o: $(**SRC_DIR**)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(**INC_COMP**)

```


# Structure
The current project has the next structure:

```
project
│   README.md
│   build.bat    
│
└─── cfg
│   │   cfg.mak
│   │   set_path.mak
│   
└─── out
    │   .gitignore
│   
└─── script
│   │   build.mak
│   │   
└─── src
│   │   
│   └─── mcu
│   │   │   dio.c       
│   │   │   dio.h       
│   │   └─── device
│   │      │    startup.c
│   │      │    startup.h
│   │
│   └─── svc
│       │   main.c
│       │   main.h
│       │   typedefs.h
│       │   util.c
│       │   util.h
│
└─── tools
│   │
│   └─── avr-dude
│   │   |   *
│   └─── avr-gcc
│   │   |   *
│   └─── MinGW
│   │   |   *
| 
```

# Future work
The build system will be tested in other boards and other microcontroller in the future.

# Hardware compatible 
- Arduino Uno (Optiboot bootloader)