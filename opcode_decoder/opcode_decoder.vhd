library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.opcode_constants.all;
use work.instructions_opcode_list_RV32I.all;


entity opcode_decoder is
	port(clk: in std_logic;
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
end entity;

architecture od of opcode_decoder is

	type control_signals_t is record
		alu_op: std_logic_vector(4 downto 0);
		branch: std_logic;
		mem_read: std_logic;
		mem_to_reg: std_logic;
		mem_write: std_logic;
		alu_src: std_logic;
		reg_write: std_logic;
	end record;
	
	type decode_entry_t is record
		key: std_logic_vector(16 downto 0);
		control_signal: control_signals_t;
	end record;
	
	type decode_table_t is array (natural range <>) of decode_entry_t;
	constant decode_table: decode_table_t := (
		-- ADD
		(key => OPCODE_R_TYPE & "000" & "0000000",
		 control_signal => (alu_op => ADD_INSTR, alu_src => '0', mem_read => '0', mem_write => '0', mem_to_reg => '0', reg_write => '1', branch => '0')),
		-- SUB
		(key => OPCODE_R_TYPE & "000" & "0100000",
		 control_signal => (alu_op => SUB_INSTR, alu_src => '0', mem_read => '0', mem_write => '0', mem_to_reg => '0', reg_write => '1', branch => '0')),
		-- XOR
		(key => OPCODE_R_TYPE & "100" & "0000000",
		 control_signal => (alu_op => XOR_INSTR, alu_src => '0', mem_read => '0', mem_write => '0', mem_to_reg => '0', reg_write => '1', branch => '0')),
		-- OR
		(key => OPCODE_R_TYPE & "110" & "0000000",
		 control_signal => (alu_op => OR_INSTR, alu_src => '0', mem_read => '0', mem_write => '0', mem_to_reg => '0', reg_write => '1', branch => '0')),
		-- AND
		(key => OPCODE_R_TYPE & "111" & "0000000",
		 control_signal => (alu_op => AND_INSTR, alu_src => '0', mem_read => '0', mem_write => '0', mem_to_reg => '0', reg_write => '1', branch => '0')),
		-- SLL
		(key => OPCODE_R_TYPE & "001" & "0000000",
		 control_signal => (alu_op => SLL_INSTR, alu_src => '0', mem_read => '0', mem_write => '0', mem_to_reg => '0', reg_write => '1', branch => '0')),
		-- SRL
		(key => OPCODE_R_TYPE & "101" & "0000000",
		 control_signal => (alu_op => SRL_INSTR, alu_src => '0', mem_read => '0', mem_write => '0', mem_to_reg => '0', reg_write => '1', branch => '0')),
		-- SRA
		(key => OPCODE_R_TYPE & "101" & "0100000",
		 control_signal => (alu_op => SRA_INSTR, alu_src => '0', mem_read => '0', mem_write => '0', mem_to_reg => '0', reg_write => '1', branch => '0')),
		-- SLT
		(key => OPCODE_R_TYPE & "010" & "0000000",
		 control_signal => (alu_op => SLT_INSTR, alu_src => '0', mem_read => '0', mem_write => '0', mem_to_reg => '0', reg_write => '1', branch => '0')),
		-- SLTU
		(key => OPCODE_R_TYPE & "001" & "0100000",
		 control_signal => (alu_op => SLTU_INSTR, alu_src => '0', mem_read => '0', mem_write => '0', mem_to_reg => '0', reg_write => '1', branch => '0'))
	);
	
	signal ctrl_signal: control_signals_t;
begin
	process(clk, rst)
	begin
		if rst='1' then
			ctrl_signal.alu_op <= (others => '0');
			ctrl_signal.alu_src <= '0';
			ctrl_signal.reg_write <= '0';
			ctrl_signal.mem_read <= '0';
			ctrl_signal.mem_write <= '0';
			ctrl_signal.branch <= '0';
			ctrl_signal.mem_to_reg <= '0';
		elsif rising_edge(clk) then
			for i in decode_table'range loop
				if (opcode & funct3 & funct7) = decode_table(i).key then
					ctrl_signal <= decode_table(i).control_signal;
				end if;
			end loop;
		end if;
	end process;
	alu_op <= ctrl_signal.alu_op;
	branch <= ctrl_signal.branch;
	mem_read <= ctrl_signal.mem_read;
	mem_to_reg <= ctrl_signal.mem_to_reg;
	mem_write <= ctrl_signal.mem_write;
	alu_src <= ctrl_signal.alu_src;
	reg_write <= ctrl_signal.reg_write;
end architecture;