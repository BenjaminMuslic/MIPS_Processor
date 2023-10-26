Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- Using numeric_std for signed operations


entity SLT_32 is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));
end SLT_32;

architecture dataflow of SLT_32 is
begin
  o_F <= "00000000000000000000000000000001" when signed(i_A) < signed(i_B) else
         "00000000000000000000000000000000";
end dataflow;

