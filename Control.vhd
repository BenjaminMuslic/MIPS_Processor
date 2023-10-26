LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY Control IS
    PORT (
        iOP : IN STD_LOGIC_VECTOR(31 DOWNTO 26);
        iFunc : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        oOverfl : out std_logic;
        oRegDst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        oALUSrc : OUT STD_LOGIC;
        oPCsel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        oBranch : OUT STD_LOGIC;
        oMRead : OUT STD_LOGIC;
        oMemtReg : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        oALUop : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        oRSsel : OUT STD_LOGIC;
        oMWrite : OUT STD_LOGIC;
        oRegWrite : OUT STD_LOGIC;
	    oSignExt : OUT STD_LOGIC;
        oHalt : OUT STD_LOGIC
    );
END Control;
ARCHITECTURE structure OF Control IS
BEGIN
    --Register Destination
    oRegDst <= b"10" WHEN iOP = b"000000" AND iFunc = b"100000" ELSE
        b"00" WHEN iOP = b"001000" ELSE
        b"00" WHEN iOP = b"001001" ELSE
        b"10" WHEN iOP = b"000000" AND iFunc = b"100001" ELSE
        b"10" WHEN iOP = b"000000" AND iFunc = b"100100" ELSE
        b"00" WHEN iOP = b"001100" ELSE
        b"00" WHEN iOP = b"001111" ELSE
        b"00" WHEN iOP = b"100011" ELSE
        b"10" WHEN iOP = b"000000" AND iFunc = b"100111" ELSE
        b"10" WHEN iOP = b"000000" AND iFunc = b"100110" ELSE
        b"00" WHEN iOP = b"001110" ELSE
        b"10" WHEN iOP = b"000000" AND iFunc = b"100101" ELSE
        b"00" WHEN iOP = b"001101" ELSE
        b"10" WHEN iOP = b"000000" AND iFunc = b"101010" ELSE
        b"00" WHEN iOP = b"001010" ELSE
        b"10" WHEN iOP = b"000000" AND iFunc = b"000000" ELSE
        b"10" WHEN iOP = b"000000" AND iFunc = b"000010" ELSE
        b"10" WHEN iOP = b"000000" AND iFunc = b"000011" ELSE
        b"00" WHEN iOP = b"101011" ELSE
        b"10" WHEN iOP = b"000000" AND iFunc = b"100010" ELSE
        b"10" WHEN iOP = b"000000" AND iFunc = b"100011" ELSE
        b"00" WHEN iOP = b"000100" ELSE
        b"10" WHEN iOP = b"000101" AND iFunc = b"100010" ELSE
        b"10" WHEN iOP = b"000010" ELSE
        b"01" WHEN iOP = b"000011" ELSE
        b"10" WHEN iOP = b"000000" AND iFunc = b"001000" ELSE
        b"11";

    --Alu source mux select
    oALUSrc <= 
        '1' WHEN iOP = b"001000" ELSE
        '1' WHEN iOP = b"001001" ELSE
        '1' WHEN iOP = b"001100" ELSE
        '1' WHEN iOP = b"001111" ELSE
        '1' WHEN iOP = b"001110" ELSE
        '1' WHEN iOP = b"001101" ELSE
        '1' WHEN iOP = b"001010" ELSE
        '1' WHEN iOP = b"101011" ELSE
	'1' WHEN iOP = b"100011" ELSE
        '0';

    --Alu overflow mux select
   --Alu overflow mux select
    oOverfl <= 
    '1' WHEN  iOP = b"000000" AND iFunc = b"100000" else -- add
    '1' WHEN  iOP = b"001000" else 
    '1' WHEN  iOP = b"000000" AND iFunc = b"100010" else   --sub
    -- '0' WHEN  iOP = b"000000" AND iFunc = b"100001" else   --addu
    -- '0' WHEN  iOP = b"000000" AND iFunc = b"100111" else   --nor
    '0';                           



    --Select bits for PC mux
    oPCsel <= b"00" WHEN iOP = b"000100" ELSE
        b"00" WHEN iOP = b"000101" ELSE
        b"01" WHEN iOP = b"000010" ELSE
        b"01" WHEN iOP = b"000011" ELSE
        b"10" WHEN iOP = b"000000" AND iFunc = b"001000" ELSE
        b"11";

    --Branch signal to indicate branch instruction
    oBranch <= '0' WHEN iOP = b"000000" AND iFunc = b"100000" ELSE
        '0' WHEN iOP = b"001000" ELSE
        '0' WHEN iOP = b"001001" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100001" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100100" ELSE
        '0' WHEN iOP = b"001100" ELSE
        '0' WHEN iOP = b"001111" ELSE
        '0' WHEN iOP = b"100011" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100111" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100110" ELSE
        '0' WHEN iOP = b"001110" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100101" ELSE
        '0' WHEN iOP = b"001101" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"101010" ELSE
        '0' WHEN iOP = b"001010" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"000000" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"000010" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"000011" ELSE
        '0' WHEN iOP = b"101011" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100010" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100011" ELSE
        '1' WHEN iOP = b"000100" ELSE       --beq
        '1' WHEN iOP = b"000101"  ELSE       --bne
        '0' WHEN iOP = b"000010" ELSE
        '0' WHEN iOP = b"000011" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"001000" ELSE
        '0';

    --Signals memory to read in values
    oMRead <= '0' WHEN iOP = b"000000" AND iFunc = b"100000" ELSE
        '0' WHEN iOP = b"001000" ELSE
        '0' WHEN iOP = b"001001" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100001" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100100" ELSE
        '0' WHEN iOP = b"001100" ELSE
        '0' WHEN iOP = b"001111" ELSE
        '1' WHEN iOP = b"100011" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100111" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100110" ELSE
        '0' WHEN iOP = b"001110" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100101" ELSE
        '0' WHEN iOP = b"001101" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"101010" ELSE
        '0' WHEN iOP = b"001010" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"000000" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"000010" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"000011" ELSE
        '0' WHEN iOP = b"101011" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100010" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100011" ELSE
        '1' WHEN iOP = b"000100" ELSE
        '1' WHEN iOP = b"000101" AND iFunc = b"100010" ELSE
        '0' WHEN iOP = b"000010" ELSE
        '0' WHEN iOP = b"000011" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"001000" ELSE
        '0';

    --Select bit to output values to be written into the register file
    oMemtReg <= b"00" WHEN iOP = b"000000" AND iFunc = b"100000" ELSE
        b"00" WHEN iOP = b"001000" ELSE
        b"00" WHEN iOP = b"001001" ELSE
        b"00" WHEN iOP = b"000000" AND iFunc = b"100001" ELSE
        b"00" WHEN iOP = b"000000" AND iFunc = b"100100" ELSE
        b"00" WHEN iOP = b"001100" ELSE
        b"00" WHEN iOP = b"001111" ELSE
        b"10" WHEN iOP = b"100011" ELSE
        b"00" WHEN iOP = b"000000" AND iFunc = b"100111" ELSE
        b"00" WHEN iOP = b"000000" AND iFunc = b"100110" ELSE
        b"00" WHEN iOP = b"001110" ELSE
        b"00" WHEN iOP = b"000000" AND iFunc = b"100101" ELSE
        b"00" WHEN iOP = b"001101" ELSE
        b"00" WHEN iOP = b"000000" AND iFunc = b"101010" ELSE
        b"00" WHEN iOP = b"001010" ELSE
        b"00" WHEN iOP = b"000000" AND iFunc = b"000000" ELSE
        b"00" WHEN iOP = b"000000" AND iFunc = b"000010" ELSE
        b"00" WHEN iOP = b"000000" AND iFunc = b"000011" ELSE
        b"00" WHEN iOP = b"101011" ELSE
        b"00" WHEN iOP = b"000000" AND iFunc = b"100010" ELSE
        b"00" WHEN iOP = b"000000" AND iFunc = b"100011" ELSE
        b"00" WHEN iOP = b"000100" ELSE
        b"00" WHEN iOP = b"000101" AND iFunc = b"100010" ELSE
        b"00" WHEN iOP = b"000010" ELSE
        b"01" WHEN iOP = b"000011" ELSE
        b"00" WHEN iOP = b"000000" AND iFunc = b"001000" ELSE
        b"11";

    --Select bits outputted to the ALU for each instruction
    oALUop <= b"1001" WHEN iOP = b"000000" AND iFunc = b"100000" ELSE
        b"1001" WHEN iOP = b"001000" ELSE
        b"1101" WHEN iOP = b"001001" ELSE
        b"1101" WHEN iOP = b"000000" AND iFunc = b"100001" ELSE	
        b"0000" WHEN iOP = b"000000" AND iFunc = b"100100" ELSE
        b"0000" WHEN iOP = b"001100" ELSE
        b"0100" WHEN iOP = b"001111" ELSE
        b"1001" WHEN iOP = b"100011" ELSE
        b"0111" WHEN iOP = b"000000" AND iFunc = b"100111" ELSE
        b"0110" WHEN iOP = b"000000" AND iFunc = b"100110" ELSE
        b"0110" WHEN iOP = b"001110" ELSE
        b"0101" WHEN iOP = b"000000" AND iFunc = b"100101" ELSE
        b"0101" WHEN iOP = b"001101" ELSE
        b"1000" WHEN iOP = b"000000" AND iFunc = b"101010" ELSE
        b"1000" WHEN iOP = b"001010" ELSE
        b"1111" WHEN iOP = b"000000" AND iFunc = b"000000" ELSE
        b"0001" WHEN iOP = b"000000" AND iFunc = b"000010" ELSE
        b"0011" WHEN iOP = b"000000" AND iFunc = b"000011" ELSE
        b"1001" WHEN iOP = b"101011" ELSE
        b"1110" WHEN iOP = b"000000" AND iFunc = b"100010" ELSE
        b"1100" WHEN iOP = b"000000" AND iFunc = b"100011" ELSE
        b"1010" WHEN iOP = b"000100" ELSE
        b"1011" WHEN iOP = b"000101" ELSE
        --'0' WHEN iOP = b"000010" ELSE
        --'0' WHEN iOP = b"000011" ELSE
        --b"1111" WHEN iOP = b"000000" AND iFunc = b"001000" ELSE
        b"1111";

    --Selects whether to load the RS value from the machine code or the R[31]
    oRSsel <= '0' WHEN iOP = b"000000" AND iFunc = b"100000" ELSE
        '0' WHEN iOP = b"001000" ELSE
        '0' WHEN iOP = b"001001" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100001" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100100" ELSE
        '0' WHEN iOP = b"001100" ELSE
        '0' WHEN iOP = b"001111" ELSE
        '0' WHEN iOP = b"100011" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100111" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100110" ELSE
        '0' WHEN iOP = b"001110" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100101" ELSE
        '0' WHEN iOP = b"001101" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"101010" ELSE
        '0' WHEN iOP = b"001010" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"000000" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"000010" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"000011" ELSE
        '0' WHEN iOP = b"101011" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100010" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100011" ELSE
        '0' WHEN iOP = b"000100" ELSE
        '0' WHEN iOP = b"000101" AND iFunc = b"100010" ELSE
        '0' WHEN iOP = b"000010" ELSE
        '0' WHEN iOP = b"000011" ELSE
        '1' WHEN iOP = b"000000" AND iFunc = b"001000" ELSE
        '0';

    --Enables the memory to write during the sw instruction
    oMWrite <= '0' WHEN iOP = b"000000" AND iFunc = b"100000" ELSE
        '0' WHEN iOP = b"001000" ELSE
        '0' WHEN iOP = b"001001" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100001" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100100" ELSE
        '0' WHEN iOP = b"001100" ELSE
        '0' WHEN iOP = b"001111" ELSE
        '0' WHEN iOP = b"100011" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100111" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100110" ELSE
        '0' WHEN iOP = b"001110" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100101" ELSE
        '0' WHEN iOP = b"001101" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"101010" ELSE
        '0' WHEN iOP = b"001010" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"000000" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"000010" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"000011" ELSE
        '1' WHEN iOP = b"101011" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100010" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"100011" ELSE
        '0' WHEN iOP = b"000100" ELSE
        '0' WHEN iOP = b"000101" AND iFunc = b"100010" ELSE
        '0' WHEN iOP = b"000010" ELSE
        '0' WHEN iOP = b"000011" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"001000" ELSE
        '0';

    --Enables the register file to write values
    oRegWrite <= '1' WHEN iOP = b"000000" AND iFunc = b"100000" ELSE
        '1' WHEN iOP = b"001000" ELSE
        '1' WHEN iOP = b"001001" ELSE
        '1' WHEN iOP = b"000000" AND iFunc = b"100001" ELSE
        '1' WHEN iOP = b"000000" AND iFunc = b"100100" ELSE
        '1' WHEN iOP = b"001100" ELSE
        '1' WHEN iOP = b"001111" ELSE
        '1' WHEN iOP = b"100011" ELSE
        '1' WHEN iOP = b"000000" AND iFunc = b"100111" ELSE
        '1' WHEN iOP = b"000000" AND iFunc = b"100110" ELSE
        '1' WHEN iOP = b"001110" ELSE
        '1' WHEN iOP = b"000000" AND iFunc = b"100101" ELSE
        '1' WHEN iOP = b"001101" ELSE
        '1' WHEN iOP = b"000000" AND iFunc = b"101010" ELSE
        '1' WHEN iOP = b"001010" ELSE
        '1' WHEN iOP = b"000000" AND iFunc = b"000000" ELSE
        '1' WHEN iOP = b"000000" AND iFunc = b"000010" ELSE
        '1' WHEN iOP = b"000000" AND iFunc = b"000011" ELSE
        '0' WHEN iOP = b"101011" ELSE
        '1' WHEN iOP = b"000000" AND iFunc = b"100010" ELSE
        '1' WHEN iOP = b"000000" AND iFunc = b"100011" ELSE
        '0' WHEN iOP = b"000100" ELSE
        '0' WHEN iOP = b"000101" AND iFunc = b"100010" ELSE
        '0' WHEN iOP = b"000010" ELSE
        '1' WHEN iOP = b"000011" ELSE
        '0' WHEN iOP = b"000000" AND iFunc = b"001000" ELSE
        '0';

    --Halt Signal
    oHalt <= '1' WHEN iOP = b"010100" ELSE
        '0';
    
    oSignExt <= 
        '1' WHEN iOP = b"001000" ELSE
        '1' WHEN iOP = b"001001" ELSE
        '1' WHEN iOP = b"100011" ELSE
        '1' WHEN iOP = b"001010" ELSE
        '1' WHEN iOP = b"101011" ELSE
        '1' when iOP = b"000101" else
        '1' WHEN iOP = b"000000" AND iFunc = b"001000" ELSE
        '0';

END structure;