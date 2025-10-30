SIM ?= ghdl
TOPLEVEL_LANG ?= vhdl

VHDL_SOURCES += /home/rayane/Desktop/risc_v_cpu/RISC_V_CPU/opcode_decoder/opcode_decoder.vhd \
				/home/rayane/Desktop/risc_v_cpu/RISC_V_CPU/opcode_decoder/opcode_package_constant.vhd \
				/home/rayane/Desktop/risc_v_cpu/RISC_V_CPU/opcode_decoder/instructions_alu_opcode.vhd
COCOTB_TOPLEVEL = opcode_decoder

# COCOTB_TEST_MODULES is the basename of the Python test file(s)
COCOTB_TEST_MODULES = od_testbench
include $(shell cocotb-config --makefiles)/Makefile.sim