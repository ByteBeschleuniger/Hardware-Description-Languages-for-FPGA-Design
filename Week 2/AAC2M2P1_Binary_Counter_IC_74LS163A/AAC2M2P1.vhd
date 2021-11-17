LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity AAC2M2P1 is port (                 	
   CP: 	in std_logic; 	-- clock
   SR:  in std_logic;  -- Active low, synchronous reset
   P:    in std_logic_vector(3 downto 0);  -- Parallel input
   PE:   in std_logic;  -- Parallel Enable (Load)
   CEP: in std_logic;  -- Count enable parallel input
   CET:  in std_logic; -- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0);            			
    TC:  out std_logic  -- Terminal Count
);            		
end AAC2M2P1;

architecture RTL of AAC2M2P1 is

signal Q_count : std_logic_vector(3 downto 0);

constant PERIOD : time := 28.57 ns;                           -- Freequency = 35MHz

begin

Q <= Q_count;
TC <= '1' when ( CET = '1' and Q_count =  "1111") else
     '0';

Count : Process (SR,CP,P,PE,CEP,CET)
begin

if (cp'event and cp = '1') then
	
	if (SR = '0') then
	Q_count <= "0000";

	elsif(PE = '0' ) then
	Q_count <= P;

	elsif ( (PE = '1' ) AND (CEP = '1' ) AND (CET = '1' ) ) then
	Q_count <= std_logic_vector((unsigned(Q_count) + 1));
	
	elsif ( (PE = '1' ) AND ((CEP = '0' ) OR (CET = '0' )) ) then
	Q_count <= Q_count;

	end if;

end if;

	
end process;
end RTL;
