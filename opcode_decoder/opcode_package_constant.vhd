library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package opcode_constants is

	constant OPCODE_R_TYPE: std_logic_vector(6 downto 0) := "0110011";
	constant OPCODE_R_ATOMIC_TYPE: std_logic_vector(6 downto 0) := "0101111";
	constant OPCODE_I_TYPE: std_logic_vector(6 downto 0) := "0010011";
	constant OPCODE_I_LOAD_TYPE: std_logic_vector(6 downto 0) := "000011";
	constant OPCODE_I_ENV_TYPE: std_logic_vector(6 downto 0) := "1110011";
	constant OPCODE_S_TYPE: std_logic_vector(6 downto 0) := "0100011";
	constant OPCODE_B_TYPE: std_logic_vector(6 downto 0) := "1100011";
	constant OPCODE_U_TYPE: std_logic_vector(6 downto 0) := "0110111";
	constant OPCODE_J_TYPE: std_logic_vector(6 downto 0) := "1101111";
end package opcode_constants;