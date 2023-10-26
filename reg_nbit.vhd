library IEEE;
use IEEE.std_logic_1164.all;



entity reg_nbit is
    generic(N: integer:= 32);
    port(i_CLK :in std_logic;
         i_RST :in std_logic;
         i_WE  :in std_logic;
         i_D  :in std_logic_vector(N-1 downto 0);
         o_Q  :out std_logic_vector(N-1 downto 0));
end reg_nbit;


architecture structural of reg_nbit is
    
    component dffg is
        port(i_CLK        : in std_logic;     -- Clock input
             i_RST        : in std_logic;     -- Reset input
             i_WE         : in std_logic;     -- Write enable input
             i_D          : in std_logic;     -- Data value input
             o_Q          : out std_logic);   -- Data value output
    end component;

begin

    G_Nbit_reg: for i in 0 to N-1 generate
        REG_N: dffg port map(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE => i_WE,
            i_D => i_D(i),
            o_Q => o_Q(i));
    end generate G_Nbit_reg;

end structural; 