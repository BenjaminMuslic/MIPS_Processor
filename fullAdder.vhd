-------------------------------------------------------------------------
-- Joon Park
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- fullAdder.vhd
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

entity fullAdder is

   port(iX		: in std_logic;
	iY		: in std_logic;
	cIn		: in std_logic;
	sO		: out std_logic;
	cO		: out std_logic);

end fullAdder;

architecture structure of fullAdder is

  
  -- Describe the component entities as defined in Adder.vhd, Reg.vhd,
  -- Multiplier.vhd, RegLd.vhd (not strictly necessary).

  component halfAdder 
     port(iX		: in std_logic;
	iY		: in std_logic;
	sO		: out std_logic;
	cO		: out std_logic);
  end component;

  component org2
    port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
  end component;


  -- Signals to carry and gates iX and iY

  signal s_S, s_C, s_OR : std_logic;

begin

  ---------------------------------------------------------------------------
  -- Level 0: Load two half adders
  ---------------------------------------------------------------------------

  hAdder1: halfAdder
    port MAP(iX             => iX,
	     iY	     	    => iY,
             sO             => s_S,
	     cO		    => s_C);
  hAdder2: halfAdder
    port MAP(iX             => s_S,
	     iY	     	    => cIn,
             sO             => sO,
	     cO		    => s_OR);

  ---------------------------------------------------------------------------
  -- Level 1: Load "or" gate
  ---------------------------------------------------------------------------

 
  fAdder_C: org2
    port MAP(i_A               => s_C,
             i_B               => s_OR,
             o_F               => cO);

end structure;





