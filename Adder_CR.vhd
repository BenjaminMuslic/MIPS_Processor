----------------------------------------------------------
-- Casper Run
-- Sep 19th 2023
----------------------------------------------------------
-- This is an implementation of a Adder written in VDHL


library IEEE;
use IEEE.std_logic_1164.all;


entity Adder_CR is 
    port(i_D0 :in std_logic;
         i_D1 :in std_logic;
         i_C  :in std_logic;
         o_S  :out std_logic;
         o_C  :out std_logic);
end Adder_CR;

architecture structural of Adder_CR is

    component andg2
        port(i_A    : in std_logic;
             i_B    : in std_logic;
             o_F    : out std_logic);
    end component;

    component xorg2 is
        port(i_A          : in std_logic;
             i_B          : in std_logic;
             o_F          : out std_logic);
    end component;

    component org2 is
        port(i_A          : in std_logic;
             i_B          : in std_logic;
             o_F          : out std_logic);
    end component;

    signal s_xor1 :std_logic;
    signal s_and1 :std_logic;
    signal s_and2 :std_logic;

begin

    g_Xor1: xorg2
        port Map(i_A => i_D0,
                 i_B => i_D1,
                 o_F => s_xor1);

    g_Xor2: xorg2
        port Map(i_A => s_xor1,
                 i_B => i_C,
                 o_F => o_S);

    g_And1: andg2
        port Map(i_A => i_C,
                 i_B => s_xor1,
                 o_F => s_and1);

    g_And2: andg2
        port Map(i_A => i_D1,
                 i_B => i_D0,
                 o_F => s_and2);

    g_Or: org2
        port Map(i_A => s_and1,
                 i_B => s_and2,
                 o_F => o_C);
    
    end structural;