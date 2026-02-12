# Simulator: modelsim
VSIM = vsim

# systemverilog flags
SV_FLAGS = -sv



# FILES_DIR
FILES_DIR = design
PARAMS_DIR = params

# TB_DIR
TB_DIR = testbench

# SIM_DIR
SIM_DIR = sim

# TOP_MODULE
SIM_TOP = top_module

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
WORK_DIR = $(SIM_DIR)/work

# WAVEFORM output directory
WAVE = $(SIM_DIR)/wave

# SIM files directory
SIM_FILES = $(SIM_DIR)/hw



.PHONY: all
all: compile simulate

# Compile the design
.PHONY: compile
compile:
	mkdir -p $(WAVE)
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
	-wlf $(WAVE)/wave.wlf $(TOP_MODULE) \
	-do "log -r /*; run -all; quit" \
	| tee $(WORK_DIR)/simulation.log
	@echo "Simulation completed. Check simulation.log for details."



.PHONY: clean
clean:
	rm -rf $(WORK_DIR) $(SIM_FILES) $(WAVE) sim.log transcript