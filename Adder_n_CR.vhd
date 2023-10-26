library IEEE;
use IEEE.std_logic_1164.all;



entity Adder_n is
    generic(N: integer := 32);
    port(i_D0 :in std_logic_vector(N-1 downto 0);
         i_D1 :in std_logic_vector(N-1 downto 0);
         i_C  :in std_logic;
         o_S  :out std_logic_vector(N-1 downto 0);
         o_C  :out std_logic);
end Adder_n;

architecture structural of Adder_n is
    signal carry : std_logic_vector(N-1 downto 0);
    signal sum : std_logic_vector(N-1 downto 0);
    
    component Adder_CR
        port(i_D0 :in std_logic;
         i_D1 :in std_logic;
         i_C  :in std_logic;
         o_S  :out std_logic;
         o_C  :out std_logic);
    end component;


begin 

    FULL_ADDR_1 :Adder_CR
        port map(i_D0 => i_D0(0),
                 i_D1 => i_D1(0),
                 i_C => i_C,
                 o_S => sum(0),
                 o_C => carry(0));
    Adder_n: for i in 1 to N-2 generate

    FULL_ADDR_2 :Adder_CR
        port map(i_C => carry(i-1),
                i_D0 => i_D0(i),
                i_D1 => i_D1(i),
                o_S => sum(i),
                o_C => carry(i));
    end generate Adder_n; 

    FULL_ADDR_N :Adder_CR
        port map(i_C => carry(N-2),
                i_D0 => i_D0(N-1),
                i_D1 => i_D1(N-1),
                o_S => sum(N-1),
                o_C => o_C);

    o_S <= sum;

end structural;
    
