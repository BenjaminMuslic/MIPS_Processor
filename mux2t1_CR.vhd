-------------------------------------------------------------------------
-- Joon Park
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1_1bit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 13/10/23 by Joon Park::Created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1_CR is

  port(i_S                  : in std_logic;
         i_D0                 : in std_logic;
         i_D1                 : in std_logic;
         o_O                  : out std_logic);
end mux2t1_CR;

architecture behavior of mux2t1_CR is
begin

    with i_S select

	o_O <=
		i_D0 when '0',
		i_D1 when '1',
		'0' when others;

end behavior;







