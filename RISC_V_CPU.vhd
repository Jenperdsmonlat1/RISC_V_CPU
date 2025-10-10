library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity RISC_V_CPU is
	port(
		clk: in std_logic;
		rst: in std_logic;
		instruction: out std_logic_vector(31 downto 0));
end entity;


architecture ctr of RISC_V_CPU is
	signal pc_out: unsigned(11 downto 0) := (others => '0');
	signal output_instruction: std_logic_vector(31 downto 0) := (others => '0');
	
	component Program_Counter
		port(
			clk: in std_logic;
			rst: in std_logic;
			load: in std_logic;
			next_pc: in unsigned(11 downto 0);
			pc_out: out unsigned(11 downto 0));
	end component;
			
	component Instruction_Memory
		port(
			reset: in std_logic;
			pc_address: in unsigned(11 downto 0);
			d_out: out std_logic_vector(31 downto 0));
	end component;
begin
	pc_counter: Program_Counter
		port map(
			clk => clk,
			rst => rst,
			load => '0',
			next_pc => (others => '0'),
			pc_out => pc_out
		);
		
	im_register: Instruction_Memory
		port map(
			reset => rst,
			pc_address => pc_out,
			d_out => output_instruction
		);
	instruction <= output_instruction;
end architecture;