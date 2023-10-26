-------------------------------------------------------------------------
-- Joon Park
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1.vhd
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

entity mux2t1 is

   port(n_iX		: in std_logic;
	n_iY		: in std_logic;
	i_S		: in std_logic;
	n_O		: out std_logic);

end mux2t1;

architecture structure of mux2t1 is

  
  -- Describe the component entities as defined in Adder.vhd, Reg.vhd,
  -- Multiplier.vhd, RegLd.vhd (not strictly necessary).
  component andg2
    port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
  end component;

  component invg
    port(i_A          : in std_logic;
         o_F          : out std_logic);
  end component;

  component org2
    port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
  end component;


  -- Signals to carry and gates iX and iY
  signal sX, sY   : std_logic;
  -- Signals to not output
  signal inverse  : std_logic;

begin

  ---------------------------------------------------------------------------
  -- Level 0: Load one not gate
  ---------------------------------------------------------------------------

  notGate: Invg
    port MAP(i_A              => i_S,
             o_F             => inverse);

  ---------------------------------------------------------------------------
  -- Level 1: Load two and gates
  ---------------------------------------------------------------------------
 xInput: andg2
    port MAP(i_A               => n_iX,
             i_B               => inverse,
             o_F               => sX);

  yInput: andg2
    port MAP(i_A               => n_iY,
             i_B               => i_S,
             o_F               => sY);

  ---------------------------------------------------------------------------
  -- Level 2: Load one xor gate
  ---------------------------------------------------------------------------
 
  xorGate: org2
    port MAP(i_A               => sX,
             i_B               => sY,
             o_F               => n_O);

end structure;














