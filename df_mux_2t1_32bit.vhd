-------------------------------------------------------------------------
-- Joon Park
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- df_mux2t1_32bit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 8/31/23 by Joon Park::Created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity df_mux2t1_32bit is
   generic(N: integer := 32);
 port  (sel		: in std_logic;
	n_iX		: in std_logic_vector(N-1 downto 0);
	n_iY		: in std_logic_vector(N-1 downto 0);
	n_O		: out std_logic_vector(N-1 downto 0));

end df_mux2t1_32bit;

architecture behavior of df_mux2t1_32bit is
begin

    with sel select

	n_O <=
		n_iX when '0',
		n_iY when '1',
		(others =>'0') when others;

end behavior;














