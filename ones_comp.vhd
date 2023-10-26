-------------------------------------
-- Casper Run
--Lab1
--Ones Comp.
-------------------------------------




library IEEE;
use IEEE.std_logic_1164.all;


entity ones_comp is
    generic(N: integer := 32);
    port(i_IN    : in std_logic_vector(N-1 downto 0);
         o_O    : out std_logic_vector(N-1 downto 0));

end ones_comp;


architecture structural of ones_comp is

    component invg
         port(i_A          : in std_logic;
              o_F          : out std_logic);
    end component;


begin

  G_Nbit_ones: for i in 0 to N-1 generate
    ones_comp: invg
        port Map(i_A => i_IN(i),
                 o_F => o_O(i));
  end generate G_Nbit_ones;

end structural;

