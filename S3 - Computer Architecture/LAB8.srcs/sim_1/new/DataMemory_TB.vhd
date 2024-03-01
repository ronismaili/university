library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory_TB is
end DataMemory_TB;

architecture Behavioral of DataMemory_TB is

    component DataMemory
        Port(
            CLK, RST, MemWrite, MemToReg : in std_logic;
            ALUResult, WriteData : in std_logic_vector(31 downto 0);
            Result : out std_logic_vector(31 downto 0) --WE ALSO IMPLEMENT THE MULTIPLEXOR INTO THIS DESIGN
        );
    end component;

        signal CLK, RST, MemWrite, MemToReg : std_logic;
        signal ALUResult, WriteData : std_logic_vector(31 downto 0);
        signal Result : std_logic_vector(31 downto 0);
        CONSTANT period : TIME := 10 ns;

begin

    DUT : DataMemory port map (CLK => CLK, RST => RST, MemWrite => MemWrite, MemToReg => MemToReg, ALUResult => ALUResult,
    WriteData => WriteData, Result => Result);

CLKproc : process
begin
    CLK <= '0';
    wait for period;
    CLK <= '1';
    wait for period;
end process;

SIMproc : process
begin
    ALUResult <= "00000000000000000000000000000000";
    WriteData <= "00000000000000000101010101010101";
    MemWrite <= '0';
    MemToReg <= '0';
    RST <= '0';
    wait for 3*period;
    
    for x in 0 to 1 loop
        ALUResult <= ALUResult + 1;
        wait for 2*period;
    end loop;
    
    MemWrite <= '1';
    
    for x in 0 to 3 loop
        ALUResult <= ALUResult + 1;
        wait for 2*period;
    end loop;
    
    MemWrite <= '0';
    MemToReg <= '1';
    ALUResult <= "00000000000000000000000000000000";
    wait for 4*period;
    
    for x in 0 to 7 loop
        ALUResult <= ALUResult + 1;
        wait for 2*period;
    end loop;
    
    wait for 4*period;
    RST <= '1'; --SET THE MEMORY BACK TO DEFAULT
    wait;
end process;
end Behavioral;