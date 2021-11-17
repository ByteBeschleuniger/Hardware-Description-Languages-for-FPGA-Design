LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ALU IS
PORT( Op_code : IN STD_LOGIC_VECTOR( 2 DOWNTO 0 );
A, B : IN STD_LOGIC_VECTOR( 31 DOWNTO 0 );
Y : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 ) );
END ALU;

architecture ARC_ALU of ALU is

begin
CALCULATE : process (A, B, OP_CODE)
begin

case OP_CODE is

when "000" => Y <= A;				-- Y is assigned A's value

when "001" => Y <= A + B;		        -- Addition of A and B 

when "010" => Y <= A - B;                       -- Subtraction of A and B

when "011" => Y <= A and B;	                -- Logical AND of A and B

when "100" => Y <= A or B;	                -- Logical OR of A and B

when "101" => Y <= A + 1;	                -- Increment A

when "110" => Y <= A - 1;	                -- Decrement A

when "111" => Y <= B;				-- Y is assigned B's value

when others => Y <= A;				-- Default Assignment

end case;
end process CALCULATE;
end architecture ARC_ALU;
