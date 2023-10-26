-------------------------------------------------------------------------
-- Joon Park
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux32inputs.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 9/22/23 by Joon Park::Created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;


package mux32inputs is

type t_array_mux is array(0 to 15) of std_logic_vector(31 downto 0);

end package mux32inputs;
