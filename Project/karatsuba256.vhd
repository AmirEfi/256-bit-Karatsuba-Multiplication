LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY karatsuba256 IS
	PORT (
		a , b : IN UNSIGNED(255 DOWNTO 0);
		clk   : IN STD_LOGIC;
		start : IN STD_LOGIC;
		nrst  : IN STD_LOGIC;
		p     : OUT UNSIGNED(511 DOWNTO 0);
		done  : OUT STD_LOGIC
	);
END karatsuba256;

ARCHITECTURE karatsuba_imp OF karatsuba256 IS
	COMPONENT karatsuba128 IS
		PORT(
       		 a, b: IN UNSIGNED(127 DOWNTO 0);
       		 clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 start : IN STD_LOGIC;
       		 outp: OUT UNSIGNED(511 DOWNTO 0)
     		);
   	END COMPONENT;

	SIGNAL a_high   : UNSIGNED (127 DOWNTO 0);
	SIGNAL a_low    : UNSIGNED (127 DOWNTO 0);
	SIGNAL b_high   : UNSIGNED (127 DOWNTO 0);
	SIGNAL b_low    : UNSIGNED (127 DOWNTO 0);
	SIGNAL z2       : UNSIGNED (255 DOWNTO 0);
	SIGNAL z1       : UNSIGNED (255 DOWNTO 0);
	SIGNAL z1_tmp1  : UNSIGNED (127 DOWNTO 0);
	SIGNAL z1_tmp2  : UNSIGNED (127 DOWNTO 0);
	SIGNAL z0       : UNSIGNED (255 DOWNTO 0);

BEGIN
	a_high <= a (255 DOWNTO 128);
	a_low  <= a (127 DOWNTO 0);
	b_high <= b (255 DOWNTO 128);
	b_low  <= b (127 DOWNTO 0);
  	z1_tmp1 <= a_high + a_low;
	z1_tmp2 <= b_high + b_low;

    	karatsuba128_1: ENTITY work.karatsuba128 PORT MAP(a_high, b_high, clk, nrst, start, z2);
   	karatsuba128_2: ENTITY work.karatsuba128 PORT MAP(z1_tmp1, z1_tmp2, clk, nrst, start, z1);
  	karatsuba128_3: ENTITY work.karatsuba128 PORT MAP(a_low, b_low, clk, nrst, start, z0);
    
    PROCESS(clk)
    	VARIABLE tmp1 : UNSIGNED (511 DOWNTO 0) := (OTHERS => '0');
	VARIABLE tmp2 : UNSIGNED (511 DOWNTO 0) := (OTHERS => '0');
	VARIABLE tmp3 : UNSIGNED (511 DOWNTO 0) := (OTHERS => '0');
	VARIABLE counter : INTEGER := 0;
    BEGIN
	IF(clk = '1') THEN
	    IF (start = '1') THEN
	            tmp1(511 DOWNTO 256) := z2;
	            tmp2(383 DOWNTO 128) := (z1 - z2 - z0);
                    tmp3(255 DOWNTO 0) := z0;
	            p <= tmp1 + tmp2 + tmp3;
		    counter := counter + 1;
	    END IF;   
        END IF;
	
	IF (counter = 35) THEN
	    done <= '1';
	END IF;
    END PROCESS;
END karatsuba_imp;
