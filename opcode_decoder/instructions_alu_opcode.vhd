library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package instructions_opcode_list_RV32I is

	constant ADD_INSTR: std_logic_vector(4 downto 0) := "00001";
	constant SUB_INSTR: std_logic_vector(4 downto 0) := "00010";
	constant XOR_INSTR: std_logic_vector(4 downto 0) := "00011";
	constant OR_INSTR: std_logic_vector(4 downto 0) := "00100";
	constant AND_INSTR: std_logic_vector(4 downto 0) := "00101";
	constant SLL_INSTR: std_logic_vector(4 downto 0) := "00110";
	constant SRL_INSTR: std_logic_vector(4 downto 0) := "00111";
	constant SRA_INSTR: std_logic_vector(4 downto 0) := "01000";
	constant SLT_INSTR: std_logic_vector(4 downto 0) := "01001";
	constant SLTU_INSTR: std_logic_vector(4 downto 0) := "01010";
	constant ADDI_INSTR: std_logic_vector(4 downto 0) := "01011";
	constant XORI_INSTR: std_logic_vector(4 downto 0) := "01100";
	constant ORI_INSTRU: std_logic_vector(4 downto 0) := "01101";
	constant ANDI_INSTR: std_logic_vector(4 downto 0) := "01110";
	constant SLLI_INSTR: std_logic_vector(4 downto 0) := "01111";
	constant SRLI_INSTR: std_logic_vector(4 downto 0) := "10000";
	constant SRAI_INSTR: std_logic_vector(4 downto 0) := "10001";
	constant SLTI_INSTR: std_logic_vector(4 downto 0) := "10010";
	constant SLTIU_INSTR: std_logic_vector(4 downto 0) := "10011";
	constant MUL_INSTR: std_logic_vector(4 downto 0) := "10100";
	constant MULH_INSTR: std_logic_vector(4 downto 0) := "10101";
	constant MULSU_INSTR: std_logic_vector(4 downto 0) := "10110";
	constant MULU_INSTR: std_logic_vector(4 downto 0) := "10111";
	constant DIV_INSTR: std_logic_vector(4 downto 0) := "11000";
	constant DIVU_INSTR: std_logic_vector(4 downto 0) := "11001";
	constant REM_INSTR: std_logic_vector(4 downto 0) := "11010";
	constant REMU_INSTR: std_logic_vector(4 downto 0) := "11011";
end package;