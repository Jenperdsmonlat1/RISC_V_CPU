library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Instruction_Memory is
	port(
		reset: in std_logic;
		pc_address: in unsigned(11 downto 0);
		d_out: out std_logic_vector(31 downto 0));
end entity;

architecture IM of Instruction_Memory is
	type t_register is array(0 to 4095) of std_logic_vector(31 downto 0);
	signal memory: t_register := (others => (others => '0'));

begin
	process(reset, pc_address)
	begin
		if reset='1' then
			d_out <= (others => '0');
		else
			d_out <= memory(to_integer(pc_address));
		end if;
	end process;
end architecture;