library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;

entity InstructionMemory is
    Port (
        CLK, RST : in std_logic;
        Instr : out std_logic_vector(31 downto 0)
    );
end InstructionMemory;

architecture Behavioral of InstructionMemory is

signal PC : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
    
type RAM_TYPE is array (31 downto 0) of std_logic_vector (31 downto 0);
signal RAM : RAM_TYPE := (others=>(others=>'0'));

begin

    --INSTRUCTIONS
    RAM(0) <= "00000000000000000000000000000000"; --WHEN RESET IS ON, EVERYTHING WILL BE 0 (EASIER TO PARSE THE INFORMATION)
    
     --The Original table of instructions
    RAM(1) <= "11100010100000010001000000001010"; -- ADD R1, R1, #10
    RAM(2) <= "11100010010000100010000000000101"; -- SUB R2, R2, #5
    RAM(3) <= "11100000100000010011000000000010"; -- ADD R3, R1, R2
    RAM(4) <= "11100000010000010100000000000010"; -- SUB R4, R1, R2
    RAM(5) <= "11100010000000110101000000000101"; -- AND R5, R3, #5
    RAM(6) <= "11100011100001000110000000000000"; -- ORR R6, R4, #0
    RAM(7) <= "11100000000001000111000000000110"; -- AND R7, R4, R6
    RAM(8) <= "11100001100000011000000000000110"; -- ORR R8, R1, R6
    RAM(9) <= "11100100100000000010000000000001"; -- STR R2, R0, #1
    RAM(10) <= "11100100100100001001000000000001"; -- LDR R9, R0, #1
    RAM(11) <= "11100110100000000001000000000001"; -- STR R1, R0, R1
    RAM(12) <= "11100110100100001010000000000001"; -- LDR R10, R0, R1

process(CLK) is
begin

if (rising_edge(CLK)) then
     if (RST = '1') then
        PC <= "00000000000000000000000000000000";
    else
        PC <= PC + 1;
    end if;


if(to_integer(unsigned(PC)) <= 31) then
    Instr <= RAM(to_integer(unsigned(PC)));
else
    Instr <= RAM(0);
end if;

end if;
end process;

end Behavioral;