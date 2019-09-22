library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL; -- to_integer and unsigned


entity registers_tb is
end registers_tb;

architecture tb of registers_tb is
	signal RR1      : STD_LOGIC_VECTOR (4 downto 0); 
	signal RR2      : STD_LOGIC_VECTOR (4 downto 0); 
	signal WR       : STD_LOGIC_VECTOR (4 downto 0); 
	signal WD       : STD_LOGIC_VECTOR (31 downto 0);
	signal RegWrite : STD_LOGIC;
	signal Clock    : STD_LOGIC;
	signal RD1      : STD_LOGIC_VECTOR (31 downto 0);
	signal RD2      : STD_LOGIC_VECTOR (31 downto 0);
     --Probe ports used for testing
     -- $t0 & $t1 & t2 & t3
	signal DEBUG_TMP_REGS : STD_LOGIC_VECTOR(32*4 - 1 downto 0);
	 -- $s0 & $s1 & s2 & s3
	signal DEBUG_SAVED_REGS : STD_LOGIC_VECTOR(32*4 - 1 downto 0);
begin
	UUT:entity work.registers port map(RR1,RR2,WR,WD,RegWrite,Clock,RD1,RD2);
	
	clk_pro:process
		constant clk_period: time :=3ns;
		begin
			Clock<='0';
			wait for clk_period;
			Clock<='1';
			wait for clk_period;
		end process;
	tb1:process
		constant period: time :=10ns;
		begin
			RR1 <= "00000";
			RR2 <= "00000";
			WR  <= "00000";
			WD  <= X"ABCDEF12";
			RegWrite <= '1';
			wait for period;
			assert (RD1 = X"00000000" and RD2 = X"00000000")
			report "Error in writing to $0" severity error;
			wait for period;

			RR1 <= "01000";
			RR2 <= "01001";
			WR  <= "01100";
			WD  <= X"ABCDEF12";
			RegWrite <= '1';
			wait for period;
			assert (RD1 = X"00000000" and RD2 = X"00000001")
			report "Error in reading $t0 and $t2" severity error;
			wait for period;

			RR1 <= "01010";
			RR2 <= "01011";
			WR  <= "01101";
			WD  <= X"12345678";
			RegWrite <= '0';
			wait for period;
			assert (RD1 = X"00000002" and RD2 = X"00000004")
			report "Error in reading $t3 and $t4" severity error;
			wait for period;

			RR1 <= "10000";
			RR2 <= "10001";
			WR  <= "00000";
			WD  <= X"00000000";
			RegWrite <= '0';
			wait for period;
			assert (RD1 = X"00000008" and RD2 = X"00000010")
			report "Error in reading $s0 and $s1" severity error;
			wait for period;

			RR1 <= "10010";
			RR2 <= "10011";
			WR  <= "00000";
			WD  <= X"00000000";
			RegWrite <= '0';
			wait for period;
			assert (RD1 = X"00000020" and RD2 = X"00000040")
			report "Error in reading $t5 and $t6" severity error;
			wait for period;
			

			
		end process;
end tb;