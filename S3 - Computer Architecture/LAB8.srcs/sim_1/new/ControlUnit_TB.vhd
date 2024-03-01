library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit_TB is
end ControlUnit_TB;

architecture Behavioral of ControlUnit_TB is

component ControlUnit is
    Port (
        Instr : in std_logic_vector(31 downto 0);
        Flags : in std_logic_vector(1 downto 0);
        ALUControl : out std_logic_vector(1 downto 0);
        MemToReg, MemWrite, ALUSrc, ImmSrc, RegWrite, RegSrc : out std_logic
    );
end component;

signal Instr : std_logic_vector(31 downto 0);
signal Flags : std_logic_vector(1 downto 0);
signal ALUControl : std_logic_vector(1 downto 0);
signal MemToReg, MemWrite, ALUSrc, ImmSrc, RegWrite, RegSrc : std_logic;

begin

DUT : ControlUnit port map(Instr => Instr, Flags => Flags, ALUControl => ALUControl, MemToReg => MemToReg,
MemWrite => MemWrite, ALUSrc => ALUSrc, ImmSrc => ImmSrc, RegWrite => RegWrite, RegSrc => RegSrc);

simproc : process
begin

    Instr <= "11100010100000010001000000001010"; -- ADD R1, R1, #10
    wait for 10ns;
    
    Instr <= "11100010010000100010000000000101"; -- SUB R2, R2, #5
    wait for 10ns;
    
    Instr <= "11100000100000010011000000000010"; -- ADD R3, R1, R2
    wait for 10ns;
    
    Instr <= "11100000010000010100000000000010"; -- SUB R4, R1, R2
    wait for 10ns;

    Instr <= "11100010000000110101000000000101"; -- AND R5, R3, #5
    wait for 10ns;

    Instr <= "11100011100001000110000000000000"; -- ORR R6, R4, #0
    wait for 10ns;
    
    Instr <= "11100000000001000111000000000110"; -- AND R7, R4, R6
    wait for 10ns;
    
    Instr <= "11100001100000011000000000000110"; -- ORR R8, R1, R6
    wait for 10ns;
    
    Instr <= "11100100100000000010000000000001"; -- STR R2, R0, #1
    wait for 10ns;
    
    Instr <= "11100100100100001001000000000001"; -- LDR R9, R0, #1
    wait for 10ns;
    
    Instr <= "11100110100000000001000000000001"; -- STR R1, R0, R1
    wait for 10ns;
    
    Instr <= "11100110100100001010000000000001"; -- LDR R10, R0, R1
    wait for 10ns;
    
    Instr <= "00000000000000000000000000000000"; -- LDR R10, R0, R1
    wait for 10ns;
    
    wait;
end process;

end Behavioral;