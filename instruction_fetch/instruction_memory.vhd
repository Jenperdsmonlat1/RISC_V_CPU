library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity instruction_memory is
	port(
		clk: in std_logic;
		rst: in std_logic;
		pc_address: in unsigned(11 downto 0);
		d_out: out std_logic_vector(31 downto 0));
end entity;

architecture IM of instruction_memory is
	type t_register is array(0 to 4095) of std_logic_vector(31 downto 0);
	signal memory: t_register := (
		0  => x"00000013",
	    1  => x"00100093",
    	2  => x"00200113",
	    3  => x"00308193",
		others => (others => '0'));
begin
	process(clk, rst)
	begin
		if rst='1' then
			d_out <= (others => '0');
		else
			if rising_edge(clk) then
				d_out <= memory(to_integer(pc_address(11 downto 2)));
			end if;
		end if;
	end process;
end architecture;