library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity register_file is
	port(
		clk: in std_logic;
		rst: in std_logic;
		a_in_1: in std_logic_vector(4 downto 0);
		a_in_2: in std_logic_vector(4 downto 0);
		a_in_3: in std_logic_vector(4 downto 0);
		d_out_1: out std_logic_vector(31 downto 0);
		d_out_2: out std_logic_vector(31 downto 0));
end entity;

architecture rf of register_file is
end architecture;
