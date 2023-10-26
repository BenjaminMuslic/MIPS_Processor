-------------------------------------------------------------------------
-- Joon Park
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- barrelShifter.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an barrelshifter
-- using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 10/12/23 by Joon Park::Created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity barrelShifter is
   generic(N: integer := 32);
 port  (shamt	: in std_logic_vector(4 downto 0);	 -- 5 bits shift amount
	input		: in std_logic_vector(N-1 downto 0);	-- 32-bits inputs
	selShift	: in std_logic_vector(3 downto 0);			-- sll, srl, sra functions  sll = 1111 // srl = 0001 // sra = 0011
	output		: out std_logic_vector(N-1 downto 0));

end barrelShifter;

architecture mixed of barrelShifter is

component df_mux2t1_32bit is
   generic(N: integer := 32);
 port  (sel		: in std_logic;
	n_iX		: in std_logic_vector(N-1 downto 0);
	n_iY		: in std_logic_vector(N-1 downto 0);
	n_O		: out std_logic_vector(N-1 downto 0));
end component;

signal s_mux1Out, s_mux2Out, s_mux3Out,s_mux4Out, s_mux5Out : std_logic_vector(31 downto 0);
signal s_padBit	: std_logic_vector(15 downto 0);
signal s_concat_output1, s_concat_output2, s_concat_output3, s_concat_output4, s_concat_output5: std_logic_vector(31 downto 0);
signal s_input, s_output : std_logic_vector(31 downto 0);

begin

-- How the hell does left shift work? 
process (input,selShift)
begin
if selShift = "0011" and input(31) = '1'then   
	s_padBit <= x"FFFF";
else 
	s_padBit <= x"0000";
end if;
end process;

process(input, selShift)
begin
if selShift = "0001" or  selShift = "0011" then
	for i in 0 to 31 loop
		s_input(i) <= input(31 - i);
		
	end loop;
else
	s_input <= input;
end if;
end process;

s_concat_output1 <= s_input(30 downto 0) & s_padBit(0);
s_concat_output2 <= s_mux1Out(29 downto 0) & s_padBit(1 downto 0);
s_concat_output3 <= s_mux2Out(27 downto 0) & s_padBit(3 downto 0);
s_concat_output4 <= s_mux3Out(23 downto 0) & s_padBit(7 downto 0);
s_concat_output5 <= s_mux4Out(15 downto 0) & s_padBit(15 downto 0);

  mux1:  df_mux2t1_32bit
    port MAP(sel             => shamt(0),
	     n_iX	     => s_input,
             n_iY            => s_concat_output1,
	     n_O	     => s_mux1Out);
  mux2: df_mux2t1_32bit
    port MAP(sel             => shamt(1),
	     n_iX	     => s_mux1Out,
             n_iY            => s_concat_output2,
	     n_O	     => s_mux2Out);
 mux3: df_mux2t1_32bit
    port MAP(sel             => shamt(2),
	     n_iX	     => s_mux2Out,
             n_iY            => s_concat_output3,
	     n_O	     => s_mux3Out);
 mux4: df_mux2t1_32bit
    port MAP(sel             => shamt(3),
	     n_iX	     => s_mux3Out,
             n_iY            => s_concat_output4,
	     n_O	     => s_mux4Out);
 mux5: df_mux2t1_32bit
    port MAP(sel             => shamt(4),
	     n_iX	     => s_mux4Out,
             n_iY            => s_concat_output5,
	     n_O	     => s_mux5Out);

	Gen: for i in 0 to 31 generate
		 s_output(i) <= s_mux5Out(31 - i);
	end generate;

output <= s_output when selShift = "0001" or selShift = "0011" else
		  s_mux5Out;

end mixed;















