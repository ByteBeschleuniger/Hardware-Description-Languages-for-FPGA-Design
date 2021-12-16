
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity FIFO8x9 is
   port(
      clk, rst:		in std_logic; 
      RdPtrClr, WrPtrClr:	in std_logic; 
      RdInc, WrInc:	in std_logic; 
      DataIn:	 in std_logic_vector(8 downto 0); 
      DataOut: out std_logic_vector(8 downto 0); 
      rden, wren: in std_logic 
	);
end entity FIFO8x9;

architecture RTL of FIFO8x9 is
	--signal declarations
	type fifo_array is array(7 downto 0) of std_logic_vector(8 downto 0);  -- makes use of VHDL’s enumerated type
	signal fifo:  fifo_array; --holds all the data in the fifo
	signal wrptr : unsigned(2 downto 0) :="000"; --holds the depth position of where data will be written to
	signal rdptr: unsigned(2 downto 0):="000"; --holds the depth position of where data will be read from
	signal en: std_logic_vector(7 downto 0) :="00000000"; --Really dont need this
	signal dmuxout: std_logic_vector(8 downto 0) :="000000000"; --Really dont need this 

begin

------------------------writing to and clearing FIFO Process--------------------------
FIFO_WRITE: process(clk,rst)
begin
	if rst = '1' then --reset must do 3 things: clear fifo elements, zero rdptr, and zero wrptr
		for i in 7 downto 0 loop
			fifo(i) <= (others => '0'); 
		end loop;
		wrptr <= (others => '0'); -- send wrptr to point at first element in fifo
		rdptr <= (others => '0'); -- sends rdptr to point at the first element in fifo
	elsif rising_edge(clk) then
		if wren = '1' then
			fifo(to_integer(wrptr)) <= DataIn; --writes input data to fifo at location indicated by the wrptr
		else 
			fifo(to_integer(wrptr)) <= fifo(to_integer(wrptr)); --keeps us from using memory. always have to show what occurs for other cases
		end if;
		if RdPtrClr = '1' then
			rdptr <= (others => '0');
		elsif RdInc = '1' then
			rdptr <= rdptr + 1; 
		end if;
		if WrPtrClr = '1' then
			wrptr <= (others => '0'); 
		elsif WrInc = '1' then
			wrptr <= wrptr + 1; 
		end if;
	end if;
end process;

------------------------reading data from FIFO buffer--------------------------
data_read: process(rden,rdptr)
begin
	if rden = '1' then 
		DataOut <= fifo(to_integer(rdptr));		--load the fifo element specified by rdptr into the DataOut when rden is 1
	else 
		DataOut <= (others => 'Z'); 			--high impedance if read isnt enabled
	end if;
end process;
end RTL;
