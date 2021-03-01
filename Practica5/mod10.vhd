library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity MOD10 is
Port( clk: in std_logic;
      S: out std_logic_vector(3 downto 0));
end MOD10;

architecture estructural of MOD6 is
component FlipflopJK is
   port( J,K: in  std_logic;
         Reset: in std_logic;
         Clock_enable: in std_logic;
         Clock: in std_logic;
         Output: out std_logic);
end component;
signal q1,q2,q3,q4,diez,andff3, andff4: std_logic;

begin
F1: FlipflopJK port map('1','1',diez,'1',clk,q1);
F2: FlipflopJK port map('1','1',diez,'1',clk,q2);
F3: FlipflopJK port map(andff3,andff3,diez,'1',clk,q3);
F4: FlipflopJK port map(andff4,andff4,diez,'1',clk,q4);

andff3 <= q1 and q2;
andff4 <= andff3 and q3;
diez <= q1 and q2 and q4;
S(0) <= q1;
S(1) <= q2;
S(2) <= q3;
S(3) <= q4;
end estructural;
