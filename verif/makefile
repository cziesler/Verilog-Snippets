###############################################################################
# File name: makefile
# Author: Cody Cziesler
#
# A makefile for running the test bench simulations. For use with vcs and dve.
#
###############################################################################

# directories
TB_DIR  = ../tb
RTL_DIR = ../rtl

# vcs options
VCS_OPTS =         \
  +v2k             \
  -debug_pp        \
  +lint=all,noVCDE \
  -full64          \
  +libext+.v       \
  -y $(RTL_DIR)

###############################################################################
# Verify the sync module
###############################################################################

# Default NUM_FFS plusarg
NUM_FFS = 2

# The command to run vcs
run_sync:
	vcs $(TB_DIR)/tb_sync.v $(VCS_OPTS) +define+NUM_FFS=$(NUM_FFS)
	simv

###############################################################################
# Verify the full_adder module
###############################################################################

# The command to run vcs
run_fa:
	vcs $(TB_DIR)/tb_full_adder.v $(VCS_OPTS)
	simv

###############################################################################
# Verify the half_adder module
###############################################################################

# The command to run vcs
run_ha:
	vcs $(TB_DIR)/tb_half_adder.v $(VCS_OPTS)
	simv

###############################################################################
# Verify the dff module
###############################################################################

# The command to run vcs
run_dff:
	vcs $(TB_DIR)/tb_dff.v $(VCS_OPTS)
	simv

###############################################################################
# Verify the counter module
###############################################################################

# Default WIDTH plusarg
WIDTH = 4

# The command to run vcs
run_counter:
	vcs $(TB_DIR)/tb_counter.v $(VCS_OPTS) +define+WIDTH=$(WIDTH)
	simv

###############################################################################
# Verify the ram module
###############################################################################

# Default plusargs
AWIDTH = 4
DWIDTH = 8

# The command to run vcs
run_ram:
	vcs $(TB_DIR)/tb_ram.v $(VCS_OPTS) +define+AWIDTH=$(AWIDTH) +define+DWIDTH=$(DWIDTH)
	simv

###############################################################################
# Remove unneeded files
###############################################################################
CLEAN clean:
	- rm -r simv simv.daidir ucli.key vcdplus.vpd csrc DVEfiles
