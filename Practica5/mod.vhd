library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FlipflopJK is
   port( J,K: in  std_logic;
         Reset: in std_logic;
         Clock_enable: in std_logic;
         Clock: in std_logic;
         Output: out std_logic);
end FlipflopJK;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mods is
port(
    clk, rst: in std_logic;
    qq: out std_logic_vector(3 downto 0));
end mods;

architecture estructural of mods is
component FlipflopJK is
port(
    J,K: in  std_logic;
    Reset: in std_logic;
    Clock_enable: in std_logic;
    Clock: in std_logic;
    Output: out std_logic
    );
end component;

signal k,l,m:std_logic;
signal q: std_logic_vector(3 downto 0);
begin


k <= q(0);
l <= q(0) and q(1);
m <= q(0) and q(1) and q(2);

A1: FlipFlopJK port map('1', '1', rst, '1', clk, q(0));
A2: FlipFlopJK port map(k, k, rst, '1', clk, q(1));
A3: FlipFlopJK port map(l, l, rst, '1', clk, q(2));
A4: FlipFlopJK port map(m, m, rst, '1', clk, q(3));

qq <= q;
end estructural;