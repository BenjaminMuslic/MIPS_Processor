-------------------------------------------------------------------------
-- Joon Park
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- halfAdder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 9/03/23 by Joon Park::Created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity halfAdder is

   port(iX		: in std_logic;
	iY		: in std_logic;
	sO		: out std_logic;
	cO		: out std_logic);

end halfAdder;

architecture structure of halfAdder is

  
  -- Describe the component entities as defined in Adder.vhd, Reg.vhd,
  -- Multiplier.vhd, RegLd.vhd (not strictly necessary).
  component xorg2
    port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
  end component;

  component andg2
    port(i_A          : in std_logic;
	 i_B	      : in std_logic;
         o_F          : out std_logic);
  end component;

begin

  ---------------------------------------------------------------------------
  -- Level 0: Load two half adders
  ---------------------------------------------------------------------------

  hAdderS_1: xorg2
    port MAP(i_A             => iX,
	     i_B	     => iY,
             o_F             => sO);

  hAdderC_1: andg2
    port MAP(i_A               => iX,
             i_B               => iY,
             o_F               => cO);

end structure;




