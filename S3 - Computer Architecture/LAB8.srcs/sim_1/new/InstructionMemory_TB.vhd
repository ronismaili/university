library IEEE;
use IEEE.std_logic_1164.all;

entity InstructionMemory_TB is
end InstructionMemory_TB;

architecture Behavioral of InstructionMemory_TB is

    component InstructionMemory is
        Port (
            CLK, RST : in std_logic;
            Instr : out std_logic_vector(31 downto 0)
        );
    end component;
    
    signal CLK, RST : std_logic;
    signal Instr : std_logic_vector(31 downto 0);
    
    Constant period : TIME := 10ns;
    
begin
    DUT: InstructionMemory port map(CLK => CLK, RST => RST, Instr => Instr);
    
    clkproc: process
    begin
        CLK <= '0';
        wait for period;
        CLK <= '1';
        wait for period;
    end process;
    
    stim_proc: process
    begin
        RST <= '0';
        wait for 40ns;
        RST <= '1';
        wait for 40ns;
        RST <= '0';
        wait for 60ns;
        wait for 4*period;
        wait for 40ns;
        wait;
    end process;
    
end Behavioral;