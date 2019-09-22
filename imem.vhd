library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- STD_LOGIC and STD_LOGIC_VECTOR
use IEEE.numeric_std.ALL; -- to_integer and unsigned

entity IMEM is
-- The instruction memory is a byte addressable, big-endian, read-only memory
-- Reads occur continuously
-- HINT: Use the provided dmem.vhd as a starting point
generic(NUM_BYTES : integer := 128);
-- NUM_BYTES is the number of bytes in the memory (small to save computation resources)
port(
     Address  : in  STD_LOGIC_VECTOR(31 downto 0); -- Address to read from
     ReadData : out STD_LOGIC_VECTOR(31 downto 0)
);
end IMEM;

architecture imem_behaviour of IMEM is
type ByteArray is array (0 to NUM_BYTES) of STD_LOGIC_VECTOR(7 downto 0);
signal imemBytes : ByteArray;
begin
	process
	variable first:boolean:=true;
		if(first) then
			imemBytes(1) <= "00010001";
			imemBytes(2) <= "00110011";
			imemBytes(3) <= "00000000";
			imemBytes(4) <= "10011000";
			first := false;
		end if;
	end process;
	ReadData <= imemBytes(to_integer(unsigned(Address)))&
				imemBytes(to_integer(unsigned(Address))+1)&
				imemBytes(to_integer(unsigned(Address))+2)&
				imemBytes(to_integer(unsigned(Address))+3);



end imem_behaviour