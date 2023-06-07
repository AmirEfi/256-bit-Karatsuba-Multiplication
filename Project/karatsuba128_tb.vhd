LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ALL;

ENTITY karatsuba128_tb IS
END karatsuba128_tb;

ARCHITECTURE tb OF karatsuba128_tb IS
    
    COMPONENT karatsuba128 IS
	PORT(
            a , b  : IN UNSIGNED(127 DOWNTO 0);
	    clk    : IN STD_LOGIC;
	    start  : IN STD_LOGIC;
	    result : OUT UNSIGNED(255 DOWNTO 0)
    );
    END COMPONENT;
    

    SIGNAL a , b: UNSIGNED (127 DOWNTO 0);
    SIGNAL result: UNSIGNED (255 DOWNTO 0);
    SIGNAL clk: STD_LOGIC := '0'; 
    SIGNAL start : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC := '0';

BEGIN

    UUT_karatsuba256 : ENTITY work.karatsuba128 PORT MAP (a => a, b => b,clk => clk, rst => rst, start => start, result => result);

    clk <= NOT clk AFTER 5 ns;
    rst <= '0';
    start <= '1' AFTER 4 ns;
    a <= X"00000000000000000000000000000000", X"00000000000000000000000000003039" AFTER 3 ns;
    b <= X"00000000000000000000000000000000", X"00000000000000000000000000001A85" AFTER 3 ns; 
      
END tb ;