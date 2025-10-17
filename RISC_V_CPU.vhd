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
	signal opcode: std_logic_vector(6 downto 0) := (others => '0');
	signal rd: std_logic_vector(4 downto 0) := (others => '0');
	signal funct3: std_logic_vector(2 downto 0) := (others => '0');
	signal rs1: std_logic_vector(4 downto 0) := (others => '0');
	signal rs2: std_logic_vector(4 downto 0) := (others => '0');
	signal funct7: std_logic_vector(6 downto 0) := (others => '0');
	
	component program_counter
		port(
			clk: in std_logic;
			rst: in std_logic;
			load: in std_logic;
			next_pc: in unsigned(11 downto 0);
			pc_out: out unsigned(11 downto 0));
	end component;
			
	component instruction_memory
		port(
			reset: in std_logic;
			pc_address: in unsigned(11 downto 0);
			d_out: out std_logic_vector(31 downto 0));
	end component;
	
	component instruction_register
		port(
			instruction: in std_logic_vector(31 downto 0);
			opcode: out std_logic_vector(6 downto 0);
			rd: out std_logic_vector(4 downto 0);
			funct3: out std_logic_vector(2 downto 0);
			rs1: out std_logic_vector(4 downto 0);
			rs2: out std_logic_vector(4 downto 0);
			funct7: out std_logic_vector(6 downto 0));
	end component;

begin
	pc_counter: program_counter
		port map(
			clk => clk,
			rst => rst,
			load => '0',
			next_pc => (others => '0'),
			pc_out => pc_out
		);
		
	im_register: instruction_memory
		port map(
			reset => rst,
			pc_address => pc_out,
			d_out => output_instruction
		);

	instruction <= output_instruction;
	
	ir_register: instruction_register
		port map(
			instruction => output_instruction,
			opcode => opcode,
			rd => rd,
			funct3 => funct3,
			rs1 => rs1,
			rs2 => rs2,
			funct7 => funct7
		);
end architecture;
