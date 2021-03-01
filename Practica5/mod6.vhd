----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2021 04:33:49 PM
-- Design Name: 
-- Module Name: mod6 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
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
F1: FlipflopJK port map(J => '1',K => '1', Reset => seis, Clock_enable => '1', Clock => clk, Output => q1);
F2: FlipflopJK port map(J => '1', K => '1', Reset => seis, Clock_enable => '1', Clock => clk, Output => q2);
F3: FlipflopJK port map(J => andff3, K => andff3, Reset => seis, Clock_enable => '1', Clock => clk, Output => q3);

andff3 <= q1 and q2;
seis <= q2 and q3;
S(0) <= q1;
S(1) <= q2;
S(2) <= q3;
end estructural;
