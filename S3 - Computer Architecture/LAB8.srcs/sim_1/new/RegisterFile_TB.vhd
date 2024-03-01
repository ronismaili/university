library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity RegisterFile_TB is
    
end RegisterFile_TB;

architecture Behavioral of RegisterFile_TB is

    component RegisterFile is 
        Port (
            CLK, RST, RegSrc, ImmSrc, RegWrite : in std_logic;
            WD3, Instr : in std_logic_vector(31 downto 0);
            RD1, RD2, ExtImm : out std_logic_vector(31 downto 0)
        );
    end component;

    signal CLK, RST, RegSrc, ImmSrc, RegWrite : std_logic;
    signal WD3, Instr : std_logic_vector(31 downto 0);
    signal RD1, RD2, ExtImm : std_logic_vector(31 downto 0);
    CONSTANT period : TIME := 10 ns;

begin

DUT : RegisterFile port map(CLK => CLK, RST => RST, RegSrc => RegSrc, ImmSrc => ImmSrc, RegWrite => RegWrite, WD3 => WD3,
Instr => Instr, RD1 => RD1, RD2 => RD2, ExtImm => ExtImm);

CLKproc : process
begin
    CLK <= '0';
    wait for period;
    CLK <= '1';
    wait for period;
end process;

simproc : process
begin
    
    Instr <= "01000011000001111111111111111111";
    WD3 <= "00000000000000000000000000000000";
    RST <= '0';
    RegSrc <= '0';
    RegWrite <= '0';
    ImmSrc <= '0'; --TESTING THE EXTENSION BLOCK
    wait for 10ns;
    
    ImmSrc <= '1'; --TESTING THE EXTENSION BLOCK
    wait for 5ns;
    
    ImmSrc <= '0';
    wait for 5ns;
    
    RegWrite <= '1'; -- RegSrc (originally)
    WD3 <= "00000000000000000000000000000001";
    Instr <= "00000000000000001111000000000000"; --TESTING IF WRITING WORKS (LOC = 15)
    wait for 2*period;    
    
    WD3 <= "00000000000000000000000000000010";    
    Instr <= "00000000000000001110000000000000"; --TESTING IF WRITING WORKS (LOC = 14)
    wait for 2*period;

    WD3 <= "00000000000000000000000000000011";        
    Instr <= "00000000000000001101000000000000"; --TESTING IF WRITING WORKS (LOC = 13)
    wait for 2*period;
    
    WD3 <= "00000000000000000000000000000100";        
    Instr <= "00000000000000001100000000000000"; --TESTING IF WRITING WORKS (LOC = 12)
    wait for 2*period;
    
    WD3 <= "00000000000000000000000000000101";        
    Instr <= "00000000000000001011000000000000"; --TESTING IF WRITING WORKS (LOC = 11)
    wait for 3*period;
   
    RegWrite <= '0'; -- RegSrc (originally)
    WD3 <= "00000000000000000000000000000000";
    RegSrc <= '1'; --Testing if RA1, RA2, RD1 and RD2 work -- RegWrite (originally)
    Instr <= "00000000000000001011000000000000"; -- LOCATION 11
    wait for 3*period;
    
    RegSrc <= '0'; --Testing if RA1, RA2, RD1 and RD2 work -- RegWrite (originally)
    Instr <= "00000000000011100000000000001100"; -- LOCATION 14 for RA1 & LOCATION 12 for RA2
    wait for 2*period;
     
    RST <= '1'; --TESTING RESET
    wait;
end process;
end Behavioral;