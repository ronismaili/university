library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port(
        Instr : in std_logic_vector(31 downto 0);
        Flags : in std_logic_vector(1 downto 0);
        ALUControl : out std_logic_vector(1 downto 0);
        MemToReg, MemWrite, ALUSrc, ImmSrc, RegWrite, RegSrc : out std_logic        
    );
end ControlUnit;

architecture Behavioral of ControlUnit is

    signal Funct : std_logic_vector(5 downto 0);
    signal Cond, Rd : std_logic_vector(3 downto 0);
    signal Op : std_logic_vector(1 downto 0);
    signal ALUOp : std_logic;
    signal ERROR : std_logic := '0';

begin

process(Instr) --Updating all of the fields
begin
    --PRIMARY SIGNALS
    Cond <= Instr(31 downto 28);
    Op <= Instr(27 downto 26);
    Funct <= Instr(25 downto 20); 
    Rd <= Instr(15 downto 12);

end process;

process(Op, Funct) -- Main Decoder
begin

if (Op = "00") then -- DATA-PROCESSING INSTRUCTION

    if (Funct(5) = '0') then -- Non-shifted register operand
        MemToReg <= '0';
        MemWrite <= '0';
        ALUSrc <= '0';
        ImmSrc <= '0'; --IRRELEVANT VALUE
        RegWrite <= '1';
        RegSrc <= '0';
        ALUOp <= '1';
        
    else -- Immediate value operand
        MemToReg <= '0';
        MemWrite <= '0';
        ALUSrc <= '1';
        ImmSrc <= '0';
        RegWrite <= '1';
        RegSrc <= '0';
        ALUOp <= '1';
    end if;
    
else --MEMORY INSTRUCTION

    if (Funct(0) = '0') then -- STR INSTRUCTION
        
        if (Funct(5) = '0') then -- IMMEDIATE OFFSET (STR)
            MemToReg <= '0'; --IRRELEVANT VALUE
            MemWrite <= '1';
            ALUSrc <= '1';
            ImmSrc <= '1'; 
            RegWrite <= '0';
            RegSrc <= '1';
            ALUOp <= '0';
        
        else -- REGISTER OFFSET (STR)
            MemToReg <= '0'; --IRRELEVANT VALUE
            MemWrite <= '1';
            ALUSrc <= '0';
            ImmSrc <= '0'; --IRRELEVANT VALUE
            RegWrite <= '0';
            RegSrc <= '0';
            ALUOp <= '0';

        end if;
        
    else -- LDR INSTRUCTION
        
        if (Funct(5) = '0') then -- IMMEDIATE OFFSET (LDR)
            MemToReg <= '1'; 
            MemWrite <= '0';
            ALUSrc <= '1';
            ImmSrc <= '1';
            RegWrite <= '1';
            RegSrc <= '0';
            ALUOp <= '0';

        else -- REGISTER OFFSET (LDR)
            MemToReg <= '1'; 
            MemWrite <= '0';
            ALUSrc <= '0';
            ImmSrc <= '1'; --IRRELEVANT VALUE
            RegWrite <= '1';
            RegSrc <= '0';
            ALUOp <= '0';
        end if;
    end if;
end if;

end process;

process(Funct, ALUOp) -- ALU Decoder
begin

if (ALUOp = '0') then
    ALUControl <= "00";
else
    case Funct(4 downto 1) is
        when "0100" => -- "0100" means ADDITION
            ALUControl <= "00";
            
        when "0010" => -- "0010" means SUBTRACTION
            ALUControl <= "01";
            
        when "0000" => -- "0000" means BITWISE AND
            ALUControl <= "10";
            
        when "1100" => -- "1100" means BITWISE ORR
            ALUControl <= "11";      
        
        when others => -- An Error has occured (!?)
            ERROR <= '1';
    end case; 
end if;
end process;
end Behavioral;