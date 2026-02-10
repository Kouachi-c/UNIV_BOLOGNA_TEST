# FILES_DIR
FILES_DIR = ../code/design
# SIM_DIR
SIM_DIR = ../code/sim
# SIM_TOP
SIM_TOP = top_module
# SIM_SRC
SIM_SRC = $(FILES_DIR)/top_module.sv
# SIM_ARGS

.PHONY: all
all: sim


sim: $(SIM_SRC)
	@echo "Running simulation..."
	@cd $(SIM_DIR) && vlog -sv $(SIM_SRC) && vsim -c -do "run -all; quit" $(SIM_TOP)


# Clean simulation files
.PHONY: clean
clean:
	@echo "Cleaning simulation files..."
	@cd $(SIM_DIR) && rm -rf work transcript vsim.wlf


# view waveform
.PHONY: view
view:
	@echo "Viewing waveform..."
	@cd $(SIM_DIR) && vsim -view vsim.wlf
	