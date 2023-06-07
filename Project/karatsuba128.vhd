LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY karatsuba128 IS
	PORT (
		a , b : IN UNSIGNED(127 DOWNTO 0);
		clk   : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		start : IN STD_LOGIC;
		result: OUT UNSIGNED(255 DOWNTO 0)
	);
END karatsuba128;

ARCHITECTURE karatsuba_imp OF karatsuba128 IS
	COMPONENT karatsuba64 IS
		PORT(
       		 a, b: IN UNSIGNED(63 DOWNTO 0);
       		 clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 start : IN STD_LOGIC;
       		 outp: OUT UNSIGNED(127 DOWNTO 0)
     		);
   	END COMPONENT;

	SIGNAL a_high   : UNSIGNED (63 DOWNTO 0);
	SIGNAL a_low    : UNSIGNED (63 DOWNTO 0);
	SIGNAL b_high   : UNSIGNED (63 DOWNTO 0);
	SIGNAL b_low    : UNSIGNED (63 DOWNTO 0);
	SIGNAL z2       : UNSIGNED (127 DOWNTO 0);
	SIGNAL z1       : UNSIGNED (127 DOWNTO 0);
	SIGNAL z1_tmp1  : UNSIGNED (63 DOWNTO 0);
	SIGNAL z1_tmp2  : UNSIGNED (63 DOWNTO 0);
	SIGNAL z0       : UNSIGNED (127 DOWNTO 0);

BEGIN
	a_high <= a (127 DOWNTO 64);
	a_low  <= a (63 DOWNTO 0);
	b_high <= b (127 DOWNTO 64);
	b_low  <= b (63 DOWNTO 0);
  	z1_tmp1 <= a_high + a_low;
	z1_tmp2 <= b_high + b_low;
    	karatsuba64_1: ENTITY work.karatsuba64 PORT MAP(a_high, b_high, clk, rst, start, z2);
   	karatsuba64_2: ENTITY work.karatsuba64 PORT MAP(z1_tmp1, z1_tmp2, clk, rst, start, z1);
  	karatsuba64_3: ENTITY work.karatsuba64 PORT MAP(a_low, b_low, clk, rst, start, z0);
    
    PROCESS(clk)
    	VARIABLE tmp1   : UNSIGNED (255 DOWNTO 0) := (OTHERS => '0');
	VARIABLE tmp2   : UNSIGNED (255 DOWNTO 0) := (OTHERS => '0');
	VARIABLE tmp3   : UNSIGNED (255 DOWNTO 0) := (OTHERS => '0');
    BEGIN
        IF(clk = '1') THEN
	    IF (start = '1') THEN
	            tmp1(255 DOWNTO 128) := z2;
	            tmp2(191 DOWNTO 64) := (z1 - z2 - z0);
                    tmp3(127 DOWNTO 0) := z0;
	            result <= tmp1 + tmp2 + tmp3;  
	   END IF;   
        END IF;
    END PROCESS;
END karatsuba_imp;
