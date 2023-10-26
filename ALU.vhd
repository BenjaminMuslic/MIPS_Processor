LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.std_logic_unsigned.ALL;
use work.mux32inputs.all;

ENTITY ALU IS
    PORT (
        R_rs, R_rt_Imm : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALUOp : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- 4 bits for 10 operations
	shamt:  IN STD_LOGIC_VECTOR(4 DOWNTO 0);	-- signal [10-6] 5 bits
     overflow_enable : in std_logic;  
	ALU_result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- ALU Result
        c_out : OUT STD_LOGIC;			 -- carryOut
        Overflow : OUT STD_LOGIC;		
        branchTaken : OUT STD_LOGIC);			-- one for beq 0 for bne == zero
END ALU;

ARCHITECTURE structural OF ALU IS

    component multiplexor16to1 is
        port(
            i_D		: in t_array_mux;						-- input
            sel		: in std_logic_vector(3 downto 0);
            Q		: out std_logic_vector(31 downto 0) );				-- output
    end component;

    COMPONENT AND_32
        GENERIC (N : INTEGER := 32);
        PORT (
            i_A, i_B : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            o_F : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0));
    END COMPONENT;

    COMPONENT OR_32
        GENERIC (N : INTEGER := 32);
        PORT (
            i_A, i_B : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            o_F : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0));
    END COMPONENT;

    COMPONENT XOR_32
        GENERIC (N : INTEGER := 32);
        PORT (
            i_A, i_B : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            o_F : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0));
    END COMPONENT;

    COMPONENT NOR_32
        GENERIC (N : INTEGER := 32);
        PORT (
            i_A, i_B : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            o_F : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0));
    END COMPONENT;

    COMPONENT SLT_32
        GENERIC (N : INTEGER := 32);
        PORT (
            i_A, i_B : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            o_F : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0));
    END COMPONENT;

  component n_bit_adder_subtractor is
   generic(N: integer :=32);
   	port(i_AD	: in std_logic_vector(N-1 downto 0);
	i_BD		: in std_logic_vector(N-1 downto 0);
	addOrSubtract	: in std_logic;
    overflow_enable : in std_logic;
	sumofAll	: out std_logic_vector(N-1 downto 0);
	carryOut	: out std_logic;
	Overflow 	: out std_logic);
end component;

    --BARREL SHIFT      srl, sll, sra
    COMPONENT barrelShifter
        GENERIC (N : INTEGER := 32);
        PORT (
            shamt : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            input : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
            selShift : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
        );
    END COMPONENT;

    --signals
     SIGNAL s_barrel_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);   -- not used 

    --barrel shift signals
    SIGNAL s_selShift : STD_LOGIC_VECTOR(1 DOWNTO 0);   -- not used 

    signal s_array_reg : t_array_mux;  

    SIGNAL mux_output : STD_LOGIC_VECTOR(31 DOWNTO 0);   -- not used 
    SIGNAL load_upper_immediate : STD_LOGIC_VECTOR(31 downto 0);   -- not used 
    SIGNAL selected_op : STD_LOGIC_VECTOR(31 DOWNTO 0);   -- not used 
    SIGNAL s_addOrSubtract : std_logic;
    SIGNAL s_Shamt : STD_LOGIC_VECTOR(4 DOWNTO 0); 
    signal s_bne : std_logic;
    signal s_beq : std_logic;
BEGIN
    --s_Shamt <= shamt;
    and_gate : AND_32
    PORT MAP(
        i_A => R_rs,
        i_B => R_rt_Imm,
        o_F => s_array_reg(4)
    );

    or_gate : OR_32
    PORT MAP(
        i_A => R_rs,
        i_B => R_rt_Imm,
        o_F => s_array_reg(5)
    );

    xor_gate : XOR_32
    PORT MAP(
        i_A => R_rs,
        i_B => R_rt_Imm,
        o_F => s_array_reg(6)
    );

    nor_gate : NOR_32
    PORT MAP(
        i_A => R_rs,
        i_B => R_rt_Imm,
        o_F => s_array_reg(7)
    );

    slt : SLT_32
    PORT MAP(
        i_A => R_rs,
        i_B => R_rt_Imm,
        o_F => s_array_reg(8)
    );

    barrel_shift : barrelShifter
    PORT MAP(
        shamt => s_Shamt,
        input => R_rt_Imm,
        selShift => ALUOp, -- 1111 for sll, 0001 for srl, 0011 for sra
        output => s_array_reg(0) 
    );


s_addOrSubtract <= 
                   '1' when ((ALUOp = "1100") or (ALUOp = "1110")) else
                   '0';
s_Shamt <= "10000" when (ALUOp = "0100") else shamt; 


-- can subtract as well

branchTaken <= 
        '1' when (ALUOp = "1010" and (R_rs = R_rt_Imm) ) or (ALUOp = "1011" and (R_rs /= R_rt_Imm))  else 
		'0'   ;


        s_bne <= '1' when ALUOp = "1011" else '0';
        s_beq <= '1' when R_rs /= R_rt_Imm else '0';
        --		'1' when ((ALUOp = "1010") and x"00000000" = (R_rs xor R_rt_Imm)) or ((ALUOp = "1011") and x"00000000" /= (R_rs xor R_rt_Imm)) else 

--process (branchTaken,ALUOp)
--begin
--if ALUOp = "1010" then
 --  if (x"00000000" = (R_rs xor R_rt_Imm)) then
 --      branchTaken <= '1';
 --  end if;
--elsif ALUOp = "1011" then 
  -- if (x"00000000" /= (R_rs xor R_rt_Imm)) then
  --     branchTaken <= '1';
 --  end if;
--else 
 --   branchTaken <= '0';

--end if;
--end process;


    n_bit_adder_sub: n_bit_adder_subtractor 
    port map(
		i_AD			=> R_rs,
		i_BD			=> R_rt_Imm, 	-- output of mux2t1 32 bit. Need to implement in MIPS PROCESSOR
		addOrSubtract		=> s_addOrSubtract,
		sumofAll		=> s_array_reg(9),
        overflow_enable => overflow_enable,
		carryOut		=> c_out,
		Overflow 		=> Overflow);
 

  with ALUOp select

 ALU_result <= 
	-- barrel shifter
            s_array_reg(0) when "0100",	-- lui
 	    s_array_reg(0) when "0001", --srl
 	    s_array_reg(0) when "1111", --sll
    	    s_array_reg(0) when "0011", --sra
	-- and, or, xor, nor, slt
            s_array_reg(4) when "0000", -- and, andi
            s_array_reg(5) when "0101", -- or, ori
            s_array_reg(6) when "0110", -- xor, xori
            s_array_reg(7) when "0111", -- nor
            s_array_reg(8) when "1000", -- slt, slti

	--add, addi, addiu, addu, lw, sw, sub, subu, 

            s_array_reg(9) when "1001", -- add, addi, sw, lw 
            s_array_reg(9) when "1101", -- addiu, addu
            s_array_reg(9) when "1110", -- sub 
	    s_array_reg(9) when "1100", -- subu 

            (others => '0') when others;

end ARCHITECTURE structural;
