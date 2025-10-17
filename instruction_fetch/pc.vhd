library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity program_counter is
	port(clk: in std_logic;
			rst: in std_logic;
			load: in std_logic;
			next_pc: in unsigned(11 downto 0);
			pc_out: out unsigned(11 downto 0));
end entity;


architecture pc of program_counter is
	signal pc_reg: unsigned(11 downto 0) := (others => '0');
begin
	process(clk, rst)
	begin
		if rst='1' then
			pc_reg <= (others => '0');
		elsif rising_edge(clk) then
			if load='1' then
				pc_reg <= next_pc;
			elsif load='0' then
				pc_reg <= pc_reg + 4;
			end if;
		end if;
	end process;
	
	pc_out <= pc_reg;
end architecture;
