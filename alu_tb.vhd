library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL; -- to_integer and unsigned


entity alu_tb is
end alu_tb;

architecture tb of alu_tb is
	a         : STD_LOGIC_VECTOR(31 downto 0);
	b         : STD_LOGIC_VECTOR(31 downto 0);
	operation : STD_LOGIC_VECTOR(3 downto 0);
	result    : STD_LOGIC_VECTOR(31 downto 0);
	zero      : STD_LOGIC;
	overflow  : STD_LOGIC;
     --Probe ports used for testing
     -- $t0 & $t1 & t2 & t3
	signal DEBUG_TMP_REGS : STD_LOGIC_VECTOR(32*4 - 1 downto 0);
	 -- $s0 & $s1 & s2 & s3
	signal DEBUG_SAVED_REGS : STD_LOGIC_VECTOR(32*4 - 1 downto 0)
begin
	UUT:entity work.ALU port map(a,b,operation,result,zero,overflow);
	
	tb1:process
		constant period: time :=10ns;
		begin
			a <= X"0000000F"
			b <= X"00000001";
			operation <= "0000"
			wait for period;
			assert (result = X"00000001" and zero = '0' overflow = '0')
			report "Error in and" severity error;
			wait for period;

			a <= X"FFFFFFFF"
			b <= X"00000001";
			operation <= "0001"
			wait for period;
			assert (result = X"FFFFFFFF" and zero = '0' overflow = '0')
			report "Error in or" severity error;
			wait for period;

			a <= X"FFFFFFFF"
			b <= X"00000010";
			operation <= "0010"
			wait for period;
			assert (result = X"0000000F" and zero = '0' overflow = '1')
			report "Error in overflow or add" severity error;
			wait for period;

			a <= X"0000000A"
			b <= X"00000001";
			operation <= "0010"
			wait for period;
			assert (result = X"0000000B" and zero = '0' overflow = '0')
			report "Error in add" severity error;
			wait for period;

			a <= X"0000000A"
			b <= X"00000001";
			operation <= "0110"
			wait for period;
			assert (result = X"00000009" and zero = '0' overflow = '0')
			report "Error in subtract" severity error;
			wait for period;

			a <= X"0000000A"
			b <= X"0000000A";
			operation <= "0110"
			wait for period;
			assert (result = X"00000000" and zero = '1' overflow = '0')
			report "Error in subtract or zero" severity error;
			wait for period;
			

			
		end process;
end tb;