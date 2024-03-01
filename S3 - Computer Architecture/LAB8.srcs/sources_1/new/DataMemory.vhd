library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity DataMemory is
Port(
CLK, RST, MemWrite, MemToReg : in std_logic;
ALUResult, WriteData : in std_logic_vector(31 downto 0);
Result : out std_logic_vector(31 downto 0) --WE ALSO IMPLEMENT THE MULTIPLEXOR INTO THIS DESIGN
);
end DataMemory;

architecture Behavioral of DataMemory is

signal ReadData : std_logic_vector(31 downto 0);

type RAM_TYPE is array (31 downto 0) of std_logic_vector (31 downto 0);
signal RAM : RAM_TYPE := (others=>(others=>'0'));

begin

process(CLK)
begin

if(rising_edge(CLK)) then 

if(RST = '1') then
    RAM <= (others=>(others=>'0'));
else
    RAM(0) <= RAM(0);
end if;

--if (to_integer(signed(ALUResult)) >= 0) then
--    ReadData <= RAM(to_integer(unsigned(ALUResult)));
--else
--    ReadData <= "00000000000000000000000000000000";
--end if;

if(MemWrite = '1') then
    RAM(to_integer(unsigned(ALUResult))) <= WriteData;
else
    RAM(0) <= RAM(0);
end if;

end if;
end process;

process(MemToReg, ReadData, ALUResult)
begin
    if (to_integer(signed(ALUResult)) >= 0) then
        ReadData <= RAM(to_integer(unsigned(ALUResult)));
    else
        ReadData <= "00000000000000000000000000000000";
    end if;
    
    if(MemToReg = '1') then
        Result <= ReadData;
    else
        Result <= ALUResult;
    end if;
end process;

end Behavioral;