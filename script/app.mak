.DEFAULT_GOAL := help
.PHONY = all clean release debug upload help

include cfg/cfg.mak
include cfg/set_path.mak

ifeq ($(DEBUG),debug)
all: clean debug upload
else 
ifeq ($(DEBUG),release)
all: clean release upload
else
all: help
endif
endif

clean: 
	@echo Cleaning the working area...
	@echo "Cleaning up..."
	del /q /f $(OUTPUT_DIR)\*

release: $(OUTPUT)
	@echo RELEASE: Done Compiling...

debug: $(OUTPUT_ELF)
	@echo DEBUG: Done Compiling...

$(OUTPUT): $(OBJ)
	$(CC) $(CFLAGS) $(INC_MCU) $(OUTPUT_FORMAT) $(MAP) $^ -o $(OUTPUT_DIR)\$@
	avr-size.exe --format=avr --mcu=atmega328p $(OUTPUT_DIR)\$(OUTPUT)	
	avr-objcopy.exe -j .text -j .data -O ihex $(OUTPUT_DIR)\$@ $(OUTPUT_DIR)\$(OUTPUT)	

$(OUTPUT_ELF): $(OBJ)
	$(CC) $(CFLAGS) $(INC_MCU) $(MAP) $^ -o $(OUTPUT_DIR)\$@ 
	avr-size.exe --format=avr --mcu=atmega328p $(OUTPUT_DIR)\$(OUTPUT_ELF)

$(OUTPUT_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INC_SRC)

$(OUTPUT_DIR)/%.o: $(APP_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INC_APP)

$(OUTPUT_DIR)/%.o: $(MCU_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INC_MCU)

$(OUTPUT_DIR)/%.o: $(DEV_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INC_DEV)

$(OUTPUT_DIR)/%.o: $(SVC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INC_SVC)

$(OUTPUT_DIR)/%.o: $(AVR_LIBS_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INC_AVR_LIBS)

$(OUTPUT_DIR)/%.o: $(AVR_DEBUG_LIBS_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INC_AVR_DEBUGGER_LIBS)

upload:
	@echo Upload binary to board...
ifeq ($(DEBUG),debug)
	$(AVRDUDE) -C $(AVR_CFG_FILE) -v -p $(AVR_BOARD) -c $(PROGRAMMER) -P $(COM) \
	-b $(BAUDRATE) -U $(WRITE_DEBUG_FLASH)
else
	$(AVRDUDE) -C $(AVR_CFG_FILE) -v -p $(AVR_BOARD) -c $(PROGRAMMER) -P $(COM) \
	-b $(BAUDRATE) -U $(WRITE_FLASH)
endif

help:
	@echo.
	@echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!HELP!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	@echo.
	@echo The next script run generate a executable for $(AVR_BOARD), in order to 
	@echo compile the current project follow the next instructions.
	@echo.
	@echo Use the build system in the next way:
	@echo ./build.bat ARG1 ARG2
	@echo.
	@echo Where the ARG1 could be one of the next supported commands:
	@echo.
	@echo - all: release/debug clean upload (required the ARG2(debug/release))
	@echo - clean: clean working area
	@echo - release: compile project without debug information, generate a HEX output file
	@echo - debug: compile project with debug information, generate a HEX and ELF output file
	@echo - upload: upload executable 
	@echo.
	@echo The ARG2 is used in "all" command to indicate the compilation type and could be one
	@echo of the next commands:
	@echo.
	@echo - release: compile project without debug information, generate a HEX output file 
	@echo - debug: compile project with debug information, generate a HEX and ELF output file
	@echo.
	@echo E.g.
	@echo.
	@echo - ./build.bat clean
	@echo - ./build.bat compile
	@echo.
	@echo Enjoy!!!