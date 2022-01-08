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


# Output configuration
OUTPUT = $(APPLICATION_NAME).hex
OUTPUT_ELF =  $(subst .hex,.elf,$(OUTPUT))
MAP_FILE = $(subst .hex,.map,$(OUTPUT))


#compiler flags, compiler definitions, linker flags
CC = avr-gcc.exe
STD = -std=gnu99
MAP = -Wl,-Map=$(OUTPUT_DIR)\$(MAP_FILE)
GNR_FLAGS = -flto -Wall -ffunction-sections -fdata-sections -fno-exceptions \
						-Wno-error=narrowing
ifeq ($(DEBUG),debug)
DEFINES_FLAGS = -D__AVR_ATmega328P__ -DF_CPU=16000000L -DDEBUG -DARDUINO_ARCH_AVR \
 								-DARDUINO_AVR_ATmega328P -DARDUINO_AVR_UNO \
        				-DPLATFORMIO -D__PLATFORMIO_BUILD_DEBUG__
DEBUG_INFO_FLAG = -g3
# -O0	optimization for compilation time (default)
# -O1 or -O	optimization for code size and execution time
# -O2	optimization more for code size and execution time
# -O3	optimization more for code size and execution time
# -Os	optimization for code size
# -Ofast	O3 with fast none accurate math calculations
OPTIM_FLAG = -O0
else
DEFINES_FLAGS = -D__AVR_ATmega328P__ -DF_CPU=16000000L -DARDUINO_ARCH_AVR\
 								-DARDUINO_AVR_ATmega328P -DARDUINO_AVR_UNO 
# -O0	optimization for compilation time (default)
# -O1 or -O	optimization for code size and execution time
# -O2	optimization more for code size and execution time
# -O3	optimization more for code size and execution time
# -Os	optimization for code size
# -Ofast	O3 with fast none accurate math calculations								 
DEBUG_INFO_FLAG = -g0
OPTIM_FLAG = -Os
endif

CFLAGS = $(STD) -mmcu=$(MMCU) $(OPTIM_FLAG) $(DEBUG_INFO_FLAG) $(DEFINES_FLAGS) $(GNR_FLAGS)


#avrdude config and command
AVR_CFG_FILE = $(TOOL_DIR)\avr-dude\etc\avrdude.conf
AVRDUDE = $(TOOL_DIR)\avr-dude\bin\avrdude.exe
WRITE_FLASH = flash:w:$(OUTPUT_DIR)\$(OUTPUT):i
WRITE_DEBUG_FLASH = flash:w:$(OUTPUT_DIR)\$(OUTPUT_ELF):a

