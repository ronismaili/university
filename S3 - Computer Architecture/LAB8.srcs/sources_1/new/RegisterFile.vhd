library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
    Port (
        CLK, RST, RegSrc, ImmSrc, RegWrite : in std_logic;
        WD3, Instr : in std_logic_vector(31 downto 0);
        RD1, RD2, ExtImm : out std_logic_vector(31 downto 0)
    );
end RegisterFile;

architecture Behavioral of RegisterFile is

    signal RA1, RA2, A3 : std_logic_vector(3 downto 0);
    
    type RAM_TYPE is array (15 downto 0) of std_logic_vector (31 downto 0);
    signal RAM : RAM_TYPE := (others=>(others=>'0'));

begin

process(CLK) --REGISTER FILE CONTENTS
begin

if(rising_edge(CLK)) then
    if(RST = '1') then --RESET THE MEMORY BACK TO ITS INITIAL STATE
        RAM <= (others=>(others=>'0'));
    else
        if(RegWrite = '1') then --WRITE AT THE MEMORY ADDRESS IF ENABLED
            RAM(to_integer(unsigned(A3))) <= WD3;
        else
           RAM(to_integer(unsigned(A3))) <= RAM(to_integer(unsigned(A3)));
        end if;
--    RD1 <= RAM(to_integer(unsigned(RA1)));
--    RD2 <= RAM(to_integer(unsigned(RA2)));
    end if;
end if;
end process;

process(RA1, RA2)
begin
    RD1 <= RAM(to_integer(unsigned(RA1)));
    RD2 <= RAM(to_integer(unsigned(RA2)));
end process;

process(RegSrc, Instr) --MUXs CONTENTS
begin
if (RegSrc = '0') then
    RA2 <= Instr(3 downto 0);
else
    RA2 <= Instr(15 downto 12);
end if;
RA1 <= Instr(19 downto 16);
A3 <= Instr(15 downto 12);
end process;

process(ImmSrc, Instr) --EXTENSION CONTENTS
begin
if (ImmSrc = '0') then
    ExtImm <= "000000000000000000000000" & Instr(7 downto 0);
else
    ExtImm <= "00000000000000000000" & Instr(11 downto 0);
end if;
end process;
end Behavioral;