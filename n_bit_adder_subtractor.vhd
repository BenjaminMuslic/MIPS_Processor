-------------------------------------------------------------------------
-- Joon Park
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- N_bit_Adder_subtractor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 9/05/23 by Joon Park::Created.
-------------------------------------------------------------------------


library IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.std_logic_unsigned.ALL;

LIBRARY work;
USE work.MIPS_types.ALL;

entity 	N_bit_Adder_subtractor is
   generic(N: integer :=32);
   port(i_AD		: in std_logic_vector(N-1 downto 0);
	i_BD		: in std_logic_vector(N-1 downto 0);
	addOrSubtract	: in std_logic;
   overflow_enable : in std_logic;
	sumofAll	: out std_logic_vector(N-1 downto 0);
	carryOut	: out std_logic;
  	Overflow 	: out std_logic
   );
	

end N_bit_Adder_subtractor;

architecture structure of N_bit_Adder_subtractor is

  component N_bit_Adder is
   generic(N: integer :=32);
   port(i_XD		: in std_logic_vector(N-1 downto 0);
	i_YD		: in std_logic_vector(N-1 downto 0);
	carryIn		: in std_logic;
   overflow_enable : in std_logic;
	sum_D		: out std_logic_vector(N-1 downto 0);
	c_DO		: out std_logic;
	overflow	: out std_logic);
end component;

  component onesComp is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
   port(i_O          : in std_logic_vector(N-1 downto 0);
        o_O          : out std_logic_vector(N-1 downto 0));
end component;

  component mux2t1_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
  end component;

   COMPONENT xorg2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
    END COMPONENT;



signal s_inverted: std_logic_vector(N-1 downto 0);
signal yval: std_logic_vector(N-1 downto 0);
begin
  
   Inverter: onesComp port map(
		i_O		=> i_BD,
		o_O		=> s_inverted);

   mux_N: mux2t1_N port map(
		i_S		=> addOrSubtract,
		i_D0		=> i_BD,
		i_D1		=> s_inverted,
		o_O		=> yval);

   nbitAdder: N_bit_Adder port map(
		i_XD		=> i_AD,
		i_YD		=> yval,
		carryIn		=> addOrSubtract,
      overflow_enable => overflow_enable,
		sum_D		=> sumofAll, 
		c_DO		=> carryout,
		overflow 	=> overflow);

end structure;
















