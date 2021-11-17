LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use ieee.numeric_bit_unsigned.all; 
use ieee.std_logic_textio.all; 
use std.textio.all; 
use work.all;

ENTITY RAM128_32 IS
	PORT
	(
		address	: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END RAM128_32;

architecture ARC_RAM of RAM128_32 is

type RAM_TYPE is array (0 to (2**7)) of std_logic_vector(31 downto 0);

--impure function READ_FILE(txt_file : in string) return RAM_TYPE is                         -- function produces text output after reading data from RAM.
--	
--	file RAM_FILE : text open read_mode is txt_file;                                   -- open file "txt_file" in read mode
--
--	variable txt_line : line;
--	variable txt_bit : bit_vector( 31 downto 0 );
--	variable txt_ram : RAM_TYPE;
--
--	
--	begin for i in RAM_TYPE'range loop                                                       -- loop runs until the length of ram.
--		readline( RAM_FILE, txt_line);
--		read( txt_line, txt_bit);
--		txt_ram(i) := to_stdlogicvector(txt_bit);
--	end loop;
--	return txt_ram;
--end function READ_FILE;


signal ram : RAM_TYPE;                                     -- Read RAM text file using function above
signal data_reg : std_logic_vector ( 31 downto 0);

begin
RAM_process : process(wren,clock)
	begin
if (clock = '1') then
	if (wren = '1') then
		ram(to_integer(unsigned(address))) <= data;
		data_reg <= data;
	elsif (wren = '0') then
		data_reg <= ram(to_integer(unsigned(address)));
	end if;
end if;
	q <= data_reg;

end process RAM_process;

end architecture ARC_RAM;





