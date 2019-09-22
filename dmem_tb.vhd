library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL; -- to_integer and unsigned


entity dmem_tb is
end dmem_tb;

architecture tb of dmem_tb is
	signal WriteData : STD_LOGIC_VECTOR (31 downto 0);
	signal Address : STD_LOGIC_VECTOR (31 downto 0);
	signal MemRead : STD_LOGIC;
	signal MemWrite : STD_LOGIC;
	signal Clock : STD_LOGIC;
	signal ReadData : STD_LOGIC_VECTOR(31 downto 0);
	signal DEBUG_MEM_CONTENTS : STD_LOGIC_VECTOR(32*4 - 1 downto 0);
begin
	UUT:entity work.DMEM port map(WriteData,Address,MemRead,MemWrite,Clock,ReadData,DEBUG_MEM_CONTENTS);
	
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
			WriteData <= X"ABCDEF12";
			Address <= X"00000000";
			MemRead <= '0';
			MemWrite <= '1';
			wait for period;
			
			WriteData <= X"12345678";
			Address <= X"00000008";
			MemRead <= '0';
			MemWrite <= '1';
			wait for period;

			WriteData <= X"87654321";
			Address <= X"0000000B";
			MemRead <= '0';
			MemWrite <= '1';
			wait for period;

			WriteData <= X"ABCDEF12";
			Address <= X"00000000";
			MemRead <= '1';
			MemWrite <= '0';
			wait for period;
			assert (ReadData = X"ABCDEF12")
			report "Error in Address 0" severity error;
			
			WriteData <= X"11330098";
			Address <= X"00000004";
			MemRead <= '1';
			MemWrite <= '0';
			wait for period;
			assert (ReadData = X"11330098")
			report "Error in Address 0" severity error;

			WriteData <= X"12345678";
			Address <= X"00000008";
			MemRead <= '1';
			MemWrite <= '0';
			wait for period;
			assert (ReadData = X"12345678")
			report "Error in Address 0" severity error;

			WriteData <= X"87654321";
			Address <= X"0000000B";
			MemRead <= '1';
			MemWrite <= '0';
			wait for period;
			assert (ReadData = X"87654321")
			report "Error in Address 0" severity error;
			wait for period;

		end process;
end tb;