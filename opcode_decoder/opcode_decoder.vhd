library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.opcode_constants.all;


entity opcode_decoder is
	port(
		opcode: in std_logic_vector(6 downto 0);
		funct3: in std_logic_vector(2 downto 0);
		funct7: in std_logic_vector(6 downto 0);
		
	);
end entity;