-------------------------------------------------------------------------
-- Joon Park
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- N-bit_Adder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 9/03/23 by Joon Park::Created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;


entity N_bit_Adder is
   generic(N: integer :=32);
   port(i_XD		: in std_logic_vector(N-1 downto 0);
	i_YD		: in std_logic_vector(N-1 downto 0);
	carryIn		: in std_logic;
  overflow_enable : in std_logic;
	sum_D		: out std_logic_vector(N-1 downto 0);
	c_DO		: out std_logic;
	overflow	: out std_logic);
	

end N_bit_Adder;

architecture structure of N_bit_Adder is

  component fullAdder is
    port(iX		: in std_logic;
	iY		: in std_logic;
	cIn		: in std_logic;
	sO		: out std_logic;
	cO		: out std_logic);
  end component;

signal s_generic : std_logic_vector(N-1 downto 1);
constant c : INTEGER := 31;

begin

   AdderI: fullAdder port map(
              iX         => i_XD(0),      -- All instances share the same select input.
              iY         => i_YD(0),  -- ith instance's data 0 input hooked up to ith data 0 input.
              cIn	 => carryIn,
	      sO        => sum_D(0),  -- ith instance's data 1 input hooked up to ith data 1 input.
              cO      => s_generic(1));  -- ith instance's data output hooked up to ith data output.

  -- Instantiate N mux instances.
  G_NBit_Adder: for i in 1 to N-2 generate
   AdderII: fullAdder port map(
              iX         => i_XD(i),      -- All instances share the same select input.
              iY         => i_YD(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
              cIn	 => s_generic(i),
	      sO        => sum_D(i) ,  -- ith instance's data 1 input hooked up to ith data 1 input.
              cO      => s_generic(i+1));  -- ith instance's data output hooked up to ith data output.

  end generate G_NBit_Adder;

   AdderIII: fullAdder port map(
              iX         => i_XD(31),      -- All instances share the same select input.
              iY         => i_YD(31),  -- ith instance's data 0 input hooked up to ith data 0 input.
              cIn	 => s_generic(31),
	      sO        => sum_D(31),  -- ith instance's data 1 input hooked up to ith data 1 input.
              cO      => c_DO);  -- ith instance's data output hooked up to ith data output.

--Overflow <= (i_XD(N-1) and i_YD(N-1) and not sum_D(N-1)) or 
--              (not i_XD(N-1) and not i_YD(N-1) and sum_D(N-1));

-- Overflow <= (not i_XD(N-1) and not i_YD(N-1) and sum_D(N-1)) or 
--               (i_XD(N-1) and i_YD(N-1) and not sum_D(N-1));

--Overflow <= (c_DO xor s_generic(30) ) and overflow_enable ;
-- Overflow <= (not i_XD(N-1) and not i_YD(N-1) and sum_D(N-1)) or 
--             (i_XD(N-1) and i_YD(N-1) and not sum_D(N-1));

-- Overflow detection process

process(i_XD, i_YD, sum_D, c_DO, overflow_enable)
begin
    -- Check whether overflow detection is enabled
    if overflow_enable = '1' then
        -- Overflow detection is focused on signed addition
        -- Overflow in signed addition occurs when:
        -- 1. Both numbers being added are positive (MSB is 0) and the result is negative (MSB is 1)
        -- 2. Both numbers being added are negative (MSB is 1) and the result is positive (MSB is 0)
         -- MSB = MOST SIGNIFICANT BIT
        
        -- Check for condition 1 and 2 and set the Overflow signal accordingly
        if (i_XD(N-1) = '0' and i_YD(N-1) = '0' and sum_D(N-1) = '1') or 
           (i_XD(N-1) = '1' and i_YD(N-1) = '1' and sum_D(N-1) = '0') then
            Overflow <= '1'; -- Overflow has occurred
        else
            Overflow <= '0'; -- No Overflow
        end if;
    else
        -- If overflow detection is not enabled or it's not a signed addition operation,
        -- then we do not flag an overflow
        Overflow <= '0';
    end if;
end process;


-- Overflow <= 
--             overflow_enable and ( c_DO xor s_generic(30));
            





end structure;




