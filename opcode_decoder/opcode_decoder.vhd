library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.opcode_constants.all;
use work.instructions_opcode_list_alu.all;


entity opcode_decoder is
	port(clk: in std_logic;
		rst: in std_logic;
		opcode: in std_logic_vector(6 downto 0);
		funct3: in std_logic_vector(2 downto 0);
		funct7: in std_logic_vector(6 downto 0);
		alu_op: out std_logic_vector(4 downto 0);
		alu_src: out std_logic;
		reg_write: out std_logic;
		mem_read: out std_logic;
		mem_write: out std_logic;
		branch: out std_logic;
		jump: out std_logic);
end entity;

architecture od from opcode_decoder is
begin
	process(clk, rst)
	begin
		if rst='1' then
			alu_op <= (others => '0');
			alu_src <= '0';
			reg_write <= '0';
			mem_read <= '0';
			mem_write <= '0';
			branch <= '0';
			jump <= '0';
		elsif rising_edge(clk) then
			if opcode=OPCODE_R_TYPE then
				if funct3=x"0" and funct7=x"00" then
					alu_op <= ADD_INSTR;
				elsif funct3=x"0" and funct7=x"20" then
					alu_op <= SUB_INSTR;
				else
					alu_op <= "XXXXX";
			end if;
		end if;
	end process;
end architecture;