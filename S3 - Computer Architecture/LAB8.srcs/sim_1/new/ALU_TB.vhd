library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_TB is
end ALU_TB;

architecture Behavioral of ALU_TB is

    component ALU is
        Port (
        ALUSrc : in std_logic;
        ALUControl : in std_logic_vector(1 downto 0);
        RD1, RD2, ExtImm : in std_logic_vector(31 downto 0);
        Flags : out std_logic_vector(1 downto 0);
        ALUResult : out std_logic_vector(31 downto 0)
        );
    end component;

        signal ALUSrc : std_logic;
        signal ALUControl : std_logic_vector(1 downto 0);
        signal RD1, RD2, ExtImm : std_logic_vector(31 downto 0);
        signal Flags : std_logic_vector(1 downto 0);
        signal ALUResult : std_logic_vector(31 downto 0);

begin

    DUT : ALU port map(ALUSrc => ALUSrc, ALUControl => ALUControl, RD1 => RD1, RD2 => RD2, ExtImm => ExtImm, Flags => Flags, ALUResult => ALUResult);

    stimproc: process
    begin
        RD1 <= "00000000000000000000000000000100";
        RD2 <= "00000000000000000000000000000110";
        ExtImm <= "00000000000000000000000000000100";
        ALUSrc <= '0';
        
        ALUControl <= "00";
        wait for 10ns;
        
        ALUControl <= "01";
        wait for 10ns;
        
        ALUControl <= "10";
        wait for 10ns;
        
        ALUControl <= "11";
        wait for 10ns;
        
        ALUSrc <= '1';
        ALUControl <= "00";
        wait for 10ns;
        
        ALUControl <= "01";
        wait for 10ns;
        
        ALUControl <= "10";
        wait for 10ns;
        
        ALUControl <= "11";
        wait for 10ns;
        
        ALUSrc <= '0';
        ALUControl <= "00";
        wait for 10ns;
        wait;       
    end process;

end Behavioral;