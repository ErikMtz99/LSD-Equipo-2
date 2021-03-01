library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity MOD60BCD is
Port( clk: in std_logic;
      min_dec: out std_logic_vector(2 downto 0)
      min_uni: out std_logic_vector(3 downto 0));
end MOD60BCD;

architecture estructural of MOD60BCD is
component MOD10 is
Port( clk: in std_logic;
      S: out std_logic_vector(3 downto 0));
end component;

component MOD6 is
Port( clk: in std_logic;
      S: out std_logic_vector(2 downto 0));
end component;

signal reset1: std_logic;
signal Sa1: std_logic_vector(3 downto 0);
signal Sa2: std_logic_vector(2 downto 0);

begin
MIN_U: MOD10 port map(clk,Sa1);
MIN_D: MOD6 port map(reset1,Sa2);
reset1 <= Sa1(0) and Sa1(1) and Sa1(3);

min_dec <= Sa2;
min_uni <= Sa1;
end estructural;