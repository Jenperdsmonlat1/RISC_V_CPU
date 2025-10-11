library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Instruction_Register is
	port(
		instruction: in std_logic_vector(31 downto 0);
		opcode: out std_logic_vector(6 downto 0);
		rd: out std_logic_vector(4 downto 0);
		funct3: out std_logic_vector(2 downto 0);
		rs1: out std_logic_vector(4 downto 0);
		rs2: out std_logic_vector(4 downto 0);
		funct7: out std_logic_vector(6 downto 0));
end entity;

architecture IR of Instruction_Register is
begin
	opcode <= instruction(6 downto 0);
	rd <= instruction(11 downto 7);
	funct3 <= instruction(14 downto 12);
	rs1 <= instruction(19 downto 15);
	rs2 <= instruction(24 downto 20);
	funct7 <= instruction(31 downto 25);
end architecture;