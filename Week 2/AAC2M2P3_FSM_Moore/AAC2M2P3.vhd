library ieee;
use ieee.std_logic_1164.all;

entity FSM is
port (In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);
end FSM;

architecture ARC_FSM of FSM is

subtype STATE_TYPE is std_logic_vector(1 downto 0);

constant A : STATE_TYPE := "00";
constant B : STATE_TYPE := "01";
constant C : STATE_TYPE := "10";

signal STATE, NEXTSTATE : STATE_TYPE;

begin

REG : process(CLK, RST)
begin
if (RST = '1') then
	STATE <= A;
elsif (CLK'EVENT and CLK = '1') then
	STATE <= NEXTSTATE;
end if;
end process REG;

CMB : process (IN1, STATE)
begin

NEXTSTATE <= STATE;
case STATE is

when A => if (IN1 = '1') then
	  NEXTSTATE <= B;
          end if;
when B => if (IN1 = '0') then
	  NEXTSTATE <= C;
          end if;
when C => if (IN1 = '1') then
	  NEXTSTATE <= A;
          end if;
when others =>
	  NEXTSTATE <= A;
end case;
end process CMB;

OUT1 <= '0' when ((STATE = A) or (STATE = B)) else
	'1';

end architecture ARC_FSM;






 