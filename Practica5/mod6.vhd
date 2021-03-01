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

entity MOD6 is
Port( clk: in std_logic;
      S: out std_logic_vector(2 downto 0));
end MOD6;

architecture estructural of MOD6 is
component FlipflopJK is
   port( J,K: in  std_logic;
         Reset: in std_logic;
         Clock_enable: in std_logic;
         Clock: in std_logic;
         Output: out std_logic);
end component;
signal q1,q2,q3,seis,andff3: std_logic;

begin
F1: FlipflopJK port map('1','1',seis,'1',clk,q1);
F2: FlipflopJK port map('1','1',seis,'1',clk,q2);
F3: FlipflopJK port map(andff3,andff3,seis,'1',clk,q3);

andff3 <= q1 and q2;
seis <= q2 and q3;
S(0) <= q1;
S(1) <= q2;
S(2) <= q3;
end estructural;