-------------------------------------------------------------------------
-- Joon Park
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- multiplexor16to1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 10/15/23 by Joon Park::Created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;


LIBRARY work;
USE work.MIPS_types.ALL;

entity 	multiplexor16to1 is
   generic(
	   M: integer :=31);

   port(
	i_D		: in t_array_mux;						-- 16 inputs
	sel		: in std_logic_vector(3 downto 0);
	Q		: out std_logic_vector(M downto 0) );				-- output
	
end multiplexor16to1;

architecture behave of multiplexor16to1 is

begin 
 with sel select

   Q <=
	i_D(0) when "0000",
	i_D(1) when "0001",
	i_D(2) when "0010",
	i_D(3) when "0011",
	i_D(4) when "0100",
	i_D(5) when "0101",
	i_D(6) when "0110",
	i_D(7) when "0111",
	i_D(8) when "1000",
	i_D(9) when "1001",
	i_D(10) when "1010",
	i_D(11) when "1011",
	i_D(12) when "1100",
	i_D(13) when "1101",
	i_D(14) when "1110",
	i_D(15) when "1111",


	(others => '0') when others;


end architecture behave;

