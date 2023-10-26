LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux4t1_n IS
    GENERIC (N : INTEGER := 32);
    PORT (
        i_S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        i_D0 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        i_D1 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        i_D2 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        i_D3 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        o_O : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0));

END mux4t1_n;

ARCHITECTURE Behavioral OF mux4t1_n IS

BEGIN
    PROCESS (i_S, i_D0, i_D1, i_D2, i_D3)
    BEGIN
        CASE i_S IS
            WHEN "00" =>
                o_O <= i_D0;
            WHEN "01" =>
                o_O <= i_D1;
            WHEN "10" =>
                o_O <= i_D2;
            WHEN "11" =>
                o_O <= i_D3;
            WHEN OTHERS =>
                o_O <= (others => '0');
        END CASE;
    END PROCESS;
END Behavioral;
