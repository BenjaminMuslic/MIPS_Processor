 -------------------------------------------------------------------------
-- Joon Park
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- bitExtender2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 9/26/23 by Joon Park::Created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity bitExtender2 is
   generic(N: integer :=32);
   port(input_16		: in std_logic_vector(15 downto 0);
	sel_sign		: in std_logic;
	output_32		: out std_logic_vector(31 downto 0));
	

end bitExtender2;


architecture behavior of bitExtender2 is


constant ones: std_logic_vector(15 downto 0) := x"FFFF";
constant zeros: std_logic_vector(15 downto 0) := x"0000";
begin

	EXT: process(input_16, sel_sign) is 
	begin

	output_32(15 downto 0) <= input_16;
	if(input_16(15)) and sel_sign then
		output_32(31 downto 16) <= ones;
	else
		output_32(31 downto 16) <= zeros;
	end if;

   end process;

end behavior;











