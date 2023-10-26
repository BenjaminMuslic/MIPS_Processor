LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;

LIBRARY work;
USE work.MIPS_types.ALL;
ENTITY mux32t1 IS
    PORT(i_Data : IN bus_array;
        i_S : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        o_O : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));

END mux32t1;

ARCHITECTURE dataflow OF mux32t1 IS

BEGIN
    WITH i_S SELECT
        o_O <= i_Data(0) WHEN "00000",
        i_Data(1) WHEN "00001",
        i_Data(2) WHEN "00010",
        i_Data(3) WHEN "00011",
        i_Data(4) WHEN "00100",
        i_Data(5) WHEN "00101",
        i_Data(6) WHEN "00110",
        i_Data(7) WHEN "00111",
        i_Data(8) WHEN "01000",
        i_Data(9) WHEN "01001",
        i_Data(10) WHEN "01010",
        i_Data(11) WHEN "01011",
        i_Data(12) WHEN "01100",
        i_Data(13) WHEN "01101",
        i_Data(14) WHEN "01110",
        i_Data(15) WHEN "01111",
        i_Data(16) WHEN "10000",
        i_Data(17) WHEN "10001",
        i_Data(18) WHEN "10010",
        i_Data(19) WHEN "10011",
        i_Data(20) WHEN "10100",
        i_Data(21) WHEN "10101",
        i_Data(22) WHEN "10110",
        i_Data(23) WHEN "10111",
        i_Data(24) WHEN "11000",
        i_Data(25) WHEN "11001",
        i_Data(26) WHEN "11010",
        i_Data(27) WHEN "11011",
        i_Data(28) WHEN "11100",
        i_Data(29) WHEN "11101",
        i_Data(30) WHEN "11110",
        i_Data(31) WHEN OTHERS;
END dataflow;
