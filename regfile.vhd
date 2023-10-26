LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
LIBRARY work;
USE work.MIPS_types.ALL;
ENTITY regfile IS
    PORT (
        i_CLK : IN STD_LOGIC;
        i_En : IN STD_LOGIC;
        i_RST : IN STD_LOGIC;
        i_WA : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        i_D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        i_srcA : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        i_srcB : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        o_RData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        o_RData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END regfile;

ARCHITECTURE structural OF regfile IS

    COMPONENT reg_nbit IS
        PORT (
            i_CLK : IN STD_LOGIC;
            i_RST : IN STD_LOGIC;
            i_WE : IN STD_LOGIC;
            i_D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            o_Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
    END COMPONENT;

    COMPONENT decoder_5t32 IS
        PORT (
            i_In : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            i_En : IN STD_LOGIC;
            o_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
    END COMPONENT;

    COMPONENT mux32t1 IS
        PORT (
            i_Data : IN bus_array;
            i_S : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            o_O : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
    END COMPONENT;

    SIGNAL s_WE : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_DO : bus_array;

BEGIN

    DEC_5t32 : decoder_5t32
    PORT MAP(
        i_In => i_WA,
        i_En => i_En,
        o_Out => s_WE);

    Zero_REG_N : reg_nbit
    PORT MAP(
        i_CLK => i_CLK,
        i_RST => '1',
        i_WE => s_WE(0),
        i_D => i_D,
        o_Q => s_DO(0));

    G_REG_NBIT : FOR i IN 1 TO 31 GENERATE
        REG_N : reg_nbit PORT MAP(
            i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE => s_WE(i),
            i_D => i_D,
            o_Q => s_DO(i));
    END GENERATE G_REG_NBIT;

    Data1_MUX : mux32t1
    PORT MAP(
        i_Data => s_DO,
        i_S => i_srcA,
        o_O => o_RData1);

    Data2_MUX : mux32t1
    PORT MAP(
        i_Data => s_DO,
        i_S => i_srcB,
        o_O => o_RData2
    );

END structural;
