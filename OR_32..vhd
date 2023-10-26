library IEEE;
use IEEE.std_logic_1164.all;

entity OR_32 is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end OR_32;

architecture dataflow of OR_32 is
begin

  o_F <= i_A or i_B;
  
end dataflow;
