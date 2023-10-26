library IEEE;
use IEEE.std_logic_1164.all;

entity nor2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end nor2;

architecture dataflow of nor2 is
begin

  o_F <= i_A nor i_B;
  
end dataflow;
