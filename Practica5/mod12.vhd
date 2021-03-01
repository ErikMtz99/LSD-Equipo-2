library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mod12 is
port(
    clk: in std_logic;
    q12: out std_logic_vector(3 downto 0));
end mod12;


architecture arch of mod12 is
component mods is
port(
    clk, rst: in std_logic;
    qq: out std_logic_vector(3 downto 0));
end component;

signal reset: std_logic;
signal qaux : std_logic_vector(3 downto 0);

begin
process(qaux)
begin
if (qaux(3) = '1' and qaux(2)='1' ) then
    reset <= '1';
else  
    reset <= '0';
end if;
end process;

Contador : mod port map(clk ,reset, qaux);
q12 <= qaux;

end arch;