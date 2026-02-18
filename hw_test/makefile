# Current directory: hw_test
CUR_DIR = $(shell pwd)

# Simulator: modelsim
VSIM = vsim

# systemverilog flags
SV_FLAGS = -sv



# FILES_DIR
FILES_DIR = $(CUR_DIR)/design
PARAMS_DIR = $(CUR_DIR)/params

# TB_DIR
TB_DIR = $(CUR_DIR)/testbench

# SIM_DIR
SIM_DIR = $(CUR_DIR)/sim

# TOP_MODULE
TOP_MODULE = tb

# Source files for simulation
SRC_FILES = $(FILES_DIR)/top_module.sv \
			$(FILES_DIR)/fifo.sv \
			$(FILES_DIR)/parity_check.sv \
			$(FILES_DIR)/sram.sv \
			$(PARAMS_DIR)/params.sv

TB_FILES = $(TB_DIR)/tb.sv \
		   $(TB_DIR)/checker.sv \
		   $(TB_DIR)/grantin_gen.sv \
		   $(TB_DIR)/traffic_gen.sv 

#WORK_DIR
WORK_DIR = work

# Outputs directory
LOG_FILES = $(SIM_DIR)/log

# SIM files directory
SIM_FILES = $(SIM_DIR)/hw


.PHONY: all
all: clean compile simulate view_wave

# Compile the design
.PHONY: compile
compile:
	mkdir -p $(LOG_FILES)
	mkdir -p $(SIM_FILES)
	@for file in $(SRC_FILES) $(TB_FILES); do \
		cp $$file $(SIM_FILES)/; \
	done
	@echo "Starting compilation ..."
	vlib $(WORK_DIR)
	vlog $(SV_FLAGS) -work $(WORK_DIR) $(SIM_FILES)/*.sv
	@echo "Compilation completed." 



.PHONY: simulate
simulate:
	@echo "Starting simulation ..."
	vsim -c -voptargs=+acc \
	-wlf $(LOG_FILES)/wave.wlf $(TOP_MODULE) \
	-do "log -r /*; run -all; quit" \
	| tee $(LOG_FILES)/simulation.log
	@echo "Simulation completed. Check simulation.log for details."


.PHONY: view_wave
view_wave:
	@echo "Opening waveform viewer ..."
	vsim -view $(LOG_FILES)/wave.wlf \
	-do $(SIM_DIR)/signals.do



.PHONY: clean
clean:
	rm -rf $(WORK_DIR) $(SIM_FILES) $(LOG_FILES) transcript