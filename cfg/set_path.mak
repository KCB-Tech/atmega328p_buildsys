.DEFAULT_GOAL := all

# Output dir
OUTPUT_DIR = $(CWD)\out

# Testing paths
TEST_DIR = $(CWD)\test

# Tool, configuration and script paths
SCRIPT_DIR = $(CWD)\script
CFG_DIR = $(CWD)\cfg
TOOL_DIR = $(CWD)\tools

# Libraries 
AVR_LIBS_DIR = $(CWD)\tools\avr-gcc\avr\include

# Source code structure
SRC_DIR = $(CWD)\src
APP_DIR = $(SRC_DIR)\app
MCU_DIR = $(SRC_DIR)\mcu
DEV_DIR = $(SRC_DIR)\mcu\device
SVC_DIR = $(SRC_DIR)\svc

# Creating rules
# SRC
SRC = $(wildcard $(SRC_DIR)/*.c)
OBJ = $(patsubst $(SRC_DIR)/%.c, $(OUTPUT_DIR)/%.o, $(SRC))
INC_SRC = -I$(SRC_DIR) 

# APP
APP = $(wildcard $(APP_DIR)/*.c)
OBJ += $(patsubst $(APP_DIR)/%.c, $(OUTPUT_DIR)/%.o, $(APP))
INC_APP = -I$(APP_DIR)

# MCU
MCU = $(wildcard $(MCU_DIR)/*.c)
OBJ += $(patsubst $(MCU_DIR)/%.c, $(OUTPUT_DIR)/%.o, $(MCU))
INC_MCU = -I$(MCU_DIR) -I$(DEV_DIR) -I$(SVC_DIR) -I$(AVR_LIBS_DIR)

# DEV
DEV = $(wildcard $(DEV_DIR)/*.c)
OBJ += $(patsubst $(DEV_DIR)/%.c, $(OUTPUT_DIR)/%.o, $(DEV))
INC_DEV = -I$(DEV_DIR)

# SVC
SVC = $(wildcard $(SVC_DIR)/*.c)
OBJ += $(patsubst $(SVC_DIR)/%.c, $(OUTPUT_DIR)/%.o, $(SVC))
INC_SVC = -I$(SVC_DIR) -I$(MCU_DIR) -I$(AVR_LIBS_DIR) -I$(AVR_DEBUG_LIBS_DIR)

# AVR LIBS
AVR_LIBS = $(wildcard $(AVR_LIBS_DIR)/*.c)
OBJ += $(patsubst $(AVR_LIBS_DIR)/%.c, $(OUTPUT_DIR)/%.o, $(AVR_LIBS))
INC_AVR_LIBS = -I$(AVR_LIBS_DIR)

all: def_path def_rule def_includes

def_path:
	@echo Defining directories...
	@echo $(OUTPUT_DIR)
	@echo $(TEST_DIR)
	@echo $(SCRIPT_DIR)
	@echo $(CFG_DIR)
	@echo $(TOOL_DIR)
	@echo $(SRC_DIR)
	@echo $(MCU_DIR)
	@echo $(DEV_DIR)
	@echo $(SVC_DIR)
	@echo $(AVR_LIBS_DIR)


def_rule:
	@echo Defining rules...
	@echo $(SRC)
	@echo $(APP)
	@echo $(MCU)
	@echo $(DEV)
	@echo $(SVC)
	@echo $(AVR_LIBS)
	@echo $(OBJ)

def_includes:
	@echo Defining includes...
	@echo $(INC_SRC)
	@echo $(INC_APP)
	@echo $(INC_MCU)
	@echo $(INC_DEV)
	@echo $(INC_SVC)
	@echo $(INC_AVR_LIBS)


	
