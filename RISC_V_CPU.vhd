library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity RISC_V_CPU is
	port(
		clk: in std_logic;
		rst: in std_logic);
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
	signal alu_op: std_logic_vector(4 downto 0) := (others => '0');
	signal branch: std_logic;
	signal mem_read: std_logic;
	signal mem_to_reg: std_logic;
	signal mem_write: std_logic;
	signal alu_src: std_logic;
	signal reg_write: std_logic;
	
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
			clk: in std_logic;
			rst: in std_logic;
			pc_address: in unsigned(11 downto 0);
			d_out: out std_logic_vector(31 downto 0));
	end component;
	
	component instruction_register
		port(
			clk: in std_logic;
			rst: in std_logic;
			instruction: in std_logic_vector(31 downto 0);
			opcode: out std_logic_vector(6 downto 0);
			rd: out std_logic_vector(4 downto 0);
			funct3: out std_logic_vector(2 downto 0);
			rs1: out std_logic_vector(4 downto 0);
			rs2: out std_logic_vector(4 downto 0);
			funct7: out std_logic_vector(6 downto 0));
	end component;
	
	component opcode_decoder
		port(
			clk: in std_logic;
			rst: in std_logic;
			opcode: in std_logic_vector(6 downto 0);
			funct3: in std_logic_vector(2 downto 0);
			funct7: in std_logic_vector(6 downto 0);
			alu_op: out std_logic_vector(4 downto 0);
			branch: out std_logic;
			mem_read: out std_logic;
			mem_to_reg: out std_logic;
			mem_write: out std_logic;
			alu_src: out std_logic;
			reg_write: out std_logic);
	end component;

begin
	pc_counter: program_counter
		port map(
			clk => clk,
			rst => rst,
			load => '0',
			next_pc => (others => '0'),
			pc_out => pc_out);
		
	im_register: instruction_memory
		port map(
			clk => clk,
			rst => rst,
			pc_address => pc_out,
			d_out => output_instruction);
	
	ir_register: instruction_register
		port map(
			clk => clk,
			rst => rst,
			instruction => output_instruction,
			opcode => opcode,
			rd => rd,
			funct3 => funct3,
			rs1 => rs1,
			rs2 => rs2,
			funct7 => funct7);
			
	op_decoder: opcode_decoder
		port map(
			clk => clk,
			rst => rst,
			opcode => opcode,
			funct3 => funct3,
			funct7 => funct7,
			alu_op => alu_op,
			branch => branch,
			mem_read => mem_read,
			mem_to_reg => mem_to_reg,
			mem_write => mem_write,
			alu_src => alu_src,
			reg_write => reg_write);
end architecture;
