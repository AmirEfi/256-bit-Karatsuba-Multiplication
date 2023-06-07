LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ALL;

ENTITY karatsuba64_tb IS
END karatsuba64_tb;

ARCHITECTURE tb OF karatsuba64_tb IS
    
    COMPONENT karatsuba64 IS
	PORT(
            a , b  : IN UNSIGNED(63 DOWNTO 0);
	    clk    : IN STD_LOGIC;
	    start  : IN STD_LOGIC;
	    result : OUT UNSIGNED(127 DOWNTO 0)
    );
    END COMPONENT;
    

    SIGNAL a , b: UNSIGNED (63 DOWNTO 0);
    SIGNAL result: UNSIGNED (127 DOWNTO 0);
    SIGNAL clk: STD_LOGIC := '0'; 
    SIGNAL start : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC := '0';

BEGIN

    UUT_karatsuba256 : ENTITY work.karatsuba64 PORT MAP (a => a, b => b,clk => clk, rst => rst, start => start, result => result);

    clk <= NOT clk AFTER 5 ns;
    rst <= '0';
    start <= '1' AFTER 4 ns;
    a <= X"0000000000000000", X"0000000000003039" AFTER 3 ns;
    b <= X"0000000000000000", X"0000000000001A85" AFTER 3 ns; 
      
END tb ;
