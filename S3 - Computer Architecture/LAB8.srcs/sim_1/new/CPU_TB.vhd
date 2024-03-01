library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU_TB is
end CPU_TB;

architecture Behavioral of CPU_TB is

    component CPU is
        Port(
            CLK_TOP, RST_TOP : in std_logic 
        );
    end component;

    signal CLK_TOP, RST_TOP : std_logic;

    Constant period : TIME := 10ns;

begin

DUT : CPU port map(CLK_TOP => CLK_TOP, RST_TOP => RST_TOP);

clk_proc: process 
begin

        CLK_TOP <= '0';
        wait for period;
        CLK_TOP <= '1';
        wait for period;
end process;

rst_proc: process
begin

    RST_TOP <= '1';
    wait for period;
    
    RST_TOP <= '0';
    wait for 8*(2*period)+2*period; --NUMBER BEFORE PARANTHESIS MEANS NUMBER OF INSTRUCTIONS TO WAIT BEFORE RESETTING
    
    --RST_TOP <= '1';
    wait;

end process;

end Behavioral;