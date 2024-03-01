library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU is
    Port(
        CLK_TOP, RST_TOP : in std_logic 
    );
end CPU;

architecture Behavioral of CPU is

component InstructionMemory is
    Port (
        CLK, RST : in std_logic;
        Instr : out std_logic_vector(31 downto 0)
    );
end component;

signal Instr_T : std_logic_vector(31 downto 0);
--CLK and RST are already defined

component RegisterFile is 
    Port (
        CLK, RST, RegSrc, ImmSrc, RegWrite : in std_logic;
        WD3, Instr : in std_logic_vector(31 downto 0);
        RD1, RD2, ExtImm : out std_logic_vector(31 downto 0)
    );
end component;

signal RegSrc_T, ImmSrc_T, RegWrite_T : std_logic;
signal RD1_T, RD2_T, ExtImm_T : std_logic_vector(31 downto 0);
--CLK, RST and Instruction are already defined

component ALU is
    Port (
        ALUSrc : in std_logic;
        ALUControl : in std_logic_vector(1 downto 0);
        RD1, RD2, ExtImm : in std_logic_vector(31 downto 0);
        Flags : out std_logic_vector(1 downto 0);
        ALUResult : out std_logic_vector(31 downto 0)
    );
end component;

signal ALUSrc_T : std_logic;
signal ALUControl_T : std_logic_vector(1 downto 0);
signal Flags_T : std_logic_vector(1 downto 0);
signal ALUResult_T : std_logic_vector(31 downto 0);
--RD1, RD2 and ExtImm are already defined

component DataMemory
    Port(
        CLK, RST, MemWrite, MemToReg : in std_logic;
        ALUResult, WriteData : in std_logic_vector(31 downto 0);
        Result : out std_logic_vector(31 downto 0)
    );
end component;

signal MemWrite_T, MemToReg_T : std_logic;
signal WriteData_T : std_logic_vector(31 downto 0);
signal Result_T : std_logic_vector(31 downto 0);
--CLK, RST, ALUResult are already defined

component ControlUnit is
    Port (
        Instr : in std_logic_vector(31 downto 0);
        Flags : in std_logic_vector(1 downto 0);
        ALUControl : out std_logic_vector(1 downto 0);
        MemToReg, MemWrite, ALUSrc, ImmSrc, RegWrite, RegSrc : out std_logic    
    );
end component;
--Instr, Flags, ALUControl, PCSrc, MemToReg, MemWrite, ALUSrc, ImmSrc, RegWrite and RegSrc are already defined

begin

Part1 : InstructionMemory port map(CLK => CLK_TOP, RST => RST_TOP, Instr => Instr_T);
Part2 : RegisterFile port map(CLK => CLK_TOP, RST => RST_TOP, RegSrc => RegSrc_T, ImmSrc => ImmSrc_T, RegWrite => RegWrite_T, WD3 => Result_T,
Instr => Instr_T, RD1 => RD1_T, RD2 => RD2_T, ExtImm => ExtImm_T);
Part3 : ALU port map(ALUSrc => ALUSrc_T, ALUControl => ALUControl_T, RD1 => RD1_T, RD2 => RD2_T, ExtImm => ExtImm_T, Flags => Flags_T,
ALUResult => ALUResult_T);
Part4 : DataMemory port map(CLK => CLK_TOP, RST => RST_TOP, MemWrite => MemWrite_T, MemToReg => MemToReg_T, ALUResult => ALUResult_T,
WriteData => RD2_T, Result => Result_T);
Part5 : ControlUnit port map(Instr => Instr_T, Flags => Flags_T, ALUControl => ALUControl_T, MemToReg => MemToReg_T,
MemWrite => MemWrite_T, ALUSrc => ALUSrc_T, ImmSrc => ImmSrc_T, RegWrite => RegWrite_T, RegSrc => RegSrc_T);

end Behavioral;