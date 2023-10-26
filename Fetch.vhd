LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY Fetch IS
    --To do: Add Signals
    PORT (
        iSysClk : IN STD_LOGIC;
        iPC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        iIns : IN STD_LOGIC_VECTOR(25 DOWNTO 0);
        iZero : IN STD_LOGIC;
        iBranch : IN STD_LOGIC;
        iSignExt : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        iPCcontrol : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        iRSreg : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        oPCout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        oPCadd : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END Fetch;

ARCHITECTURE structure OF Fetch IS
    --To do: Add Signals
    SIGNAL s_oBranch : STD_LOGIC;
    SIGNAL s_oPCadd : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_oJadd : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_oBranchmux : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --SIGNAL s_ShiftBit : STD_LOGIC_VECTOR(1 DOWNTO 0);
    --SIGNAL s_concat_PCadd_shift : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_concat_SHIFT : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_concat_SignExt_Shift : STD_LOGIC_VECTOR(31 DOWNTO 0);

    COMPONENT andg2 IS
        PORT (
            i_A : IN STD_LOGIC;
            i_B : IN STD_LOGIC;
            o_F : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT mux2t1_n IS
        GENERIC (N : INTEGER := 32); -- Generic of type integer for input/output data width. Default value is 32.
        PORT (
            i_S : IN STD_LOGIC;
            i_D0 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            i_D1 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            o_O : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0));
    END COMPONENT;

    COMPONENT Adder_n IS
        GENERIC (N : INTEGER := 32);
        PORT (
            i_D0 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            i_D1 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            i_C : IN STD_LOGIC;
            o_S : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            o_C : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT mux4t1_n IS
        GENERIC (N : INTEGER := 32);
        PORT (
            i_S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            i_D0 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            i_D1 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            i_D2 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            i_D3 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            o_O : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0));
    END COMPONENT;
BEGIN
    --To do: implement fetch logic
    s_concat_SHIFT <= s_oPCadd(31 DOWNTO 28) & iIns(25 DOWNTO 0) & b"00";
    --s_concat_PCadd_shift <= oPCadd(31 DOWNTO 0) and x"00000004";
    s_concat_SignExt_Shift <= iSignExt(29 DOWNTO 0) & b"00"; --Do we need the last two bits
    oPCadd <= s_oPCadd;

    PCAdder : Adder_n
    PORT MAP(
        i_C => '0',
        i_D0 => iPC,
        i_D1 => x"00000004",
        o_S => s_oPCadd
    );

    BranchAND : andg2
    PORT MAP(
        i_A => iBranch,
        i_B => iZero,
        o_F => s_oBranch
    );

    JAdder : Adder_n
    PORT MAP(
        i_C => '0',
        i_D0 => s_oPCadd, -- Needs signal from PC + 4
        i_D1 => s_concat_SignExt_Shift,
        o_S => s_oJadd
    );

    BranchMux : mux2t1_n
    PORT MAP(
        i_S => s_oBranch,
        i_D0 => s_oPCadd, --Needs signal from PC + 4
        i_D1 => s_oJadd,
        o_O => s_oBranchmux
    );

    PCSel : mux4t1_n
    PORT MAP(
        i_S => iPCcontrol,
        i_D0 => s_oBranchmux,
        i_D1 => s_concat_shift,
        i_D2 => iRSreg,
        i_D3 => s_oPCadd,
        o_O => oPCout
    );
END structure;
