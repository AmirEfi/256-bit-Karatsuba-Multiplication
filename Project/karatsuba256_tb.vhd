LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ALL;

ENTITY karatsuba256_tb IS
END karatsuba256_tb;

ARCHITECTURE tb OF karatsuba256_tb IS
    
    COMPONENT karatsuba256 IS
	PORT(
            a , b  : IN UNSIGNED(255 DOWNTO 0);
	    clk    : IN STD_LOGIC;
	    start  : IN STD_LOGIC;
	    nrst   : IN STD_LOGIC;
	    p      : OUT UNSIGNED(511 DOWNTO 0);
            done   : OUT STD_LOGIC
    );
    END COMPONENT;
    

    SIGNAL a , b: UNSIGNED (255 DOWNTO 0);
    SIGNAL p: UNSIGNED (511 DOWNTO 0);
    SIGNAL clk: STD_LOGIC := '0'; 
    SIGNAL start : STD_LOGIC := '0';
    SIGNAL nrst : STD_LOGIC := '0';
    SIGNAL done : STD_LOGIC := '0';

BEGIN

    UUT_karatsuba256 : ENTITY work.karatsuba256 PORT MAP (a => a, b => b,clk => clk, start => start, nrst => nrst, p => p, done => done);

    clk <= NOT clk AFTER 5 ns;
    nrst <= '1', '0' AFTER 3 ns;
    start <= '1' AFTER 4 ns;
    a <= X"0000000000000000000000000000000000000000000000000000000000000000",X"0000000000000000000000000000000000000000000000000000000000001010" AFTER 2 ns;
    b <= X"0000000000000000000000000000000000000000000000000000000000000000",X"0000000000000000000000000000000000000000000000000000000000000111" AFTER 2 ns; 
      
END tb ;

