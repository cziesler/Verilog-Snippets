###############################################################################
# File name: makefile
# Author: Cody Cziesler
#
# A makefile for running the test bench simulations. For use with vcs and dve.
#
###############################################################################

# vcs options
VCS_OPTS =         \
  +v2k             \
  -debug_pp        \
  +lint=all,noVCDE \
  -full64          \
  +libext+.v       \
  -y rtl

###############################################################################
# Verify the sync module
###############################################################################

# Default NUM_FFS plusarg
NUM_FFS = 2

# The command to run vcs
run_sync:
	vcs tb/tb_sync.v $(VCS_OPTS) +define+NUM_FFS=$(NUM_FFS)
	simv

###############################################################################
# Verify the full_adder module
###############################################################################

# The command to run vcs
run_fa:
	vcs tb/tb_full_adder.v $(VCS_OPTS)
	simv

###############################################################################
# Verify the half_adder module
###############################################################################

# The command to run vcs
run_ha:
	vcs tb/tb_half_adder.v $(VCS_OPTS)
	simv

###############################################################################
# Verify the dff module
###############################################################################

# The command to run vcs
run_dff:
	vcs tb/tb_dff.v $(VCS_OPTS)
	simv

###############################################################################
# Remove unneeded files
###############################################################################
CLEAN clean:
	- rm -r simv simv.daidir ucli.key vcdplus.vpd csrc DVEfiles
