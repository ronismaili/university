library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        ALUSrc : in std_logic;
        ALUControl : in std_logic_vector(1 downto 0);
        RD1, RD2, ExtImm : in std_logic_vector(31 downto 0);
        Flags : out std_logic_vector(1 downto 0);
        ALUResult : out std_logic_vector(31 downto 0)
        );
end ALU;

architecture Behavioral of ALU is

signal SrcA, SrcB, Result : std_logic_vector(31 downto 0);

begin

process(RD1, RD2, ExtImm, ALUSrc)
begin
    if (ALUSrc = '0') then
        SrcB <= RD2;
        SrcA <= RD1;
    else
        SrcB <= ExtImm;
        SrcA <= RD1;
    end if;
end process;

process(SrcA, SrcB, ALUControl) 
begin

case ALUControl is
    when "00" => -- "00" means ADDITION
        Result <= std_logic_vector(signed(SrcA) + signed(SrcB));
        
    when "01" => -- "01" means SUBTRACTION
        Result <= std_logic_vector(signed(SrcA) - signed(SrcB));
        
    when "10" => -- "10" means AND
        Result <= SrcA AND SrcB;    
    
    when others => -- "11" means OR
        Result <= SrcA OR SrcB;
end case;
end process;

process(result) --UPDATE THE ALU FLAGS
begin
ALUResult <= Result;

if (to_integer(signed(Result)) < 0) then -- SET FLAG TO "00" WHEN NEGATIVE
        Flags <= "00";
    elsif(Result = 0) then -- SET FLAG TO "01" WHEN ZERO
        Flags <= "01";
    else
        Flags <= "11"; -- SET FLAG TO "11" WHEN OTHERS
    end if;

end process;
end Behavioral;