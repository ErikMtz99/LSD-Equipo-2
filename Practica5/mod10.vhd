----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2021 04:33:49 PM
-- Design Name: 
-- Module Name: mod10 - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;

entity MOD10 is
Port( clk: in std_logic;
      S: out std_logic_vector(3 downto 0));
end MOD10;

architecture estructural of MOD10 is
component FlipflopJK is
   port( J,K: in  std_logic;
         Reset: in std_logic;
         Clock_enable: in std_logic;
         Clock: in std_logic;
         Output: out std_logic);
end component;
signal q1,q2,q3,q4, diez,andff3, andff4: std_logic;

begin
F1: FlipflopJK port map(J => '1', K => '1',Reset => diez, Clock_enable => '1', Clock => clk, Output=> q1);
F2: FlipflopJK port map(J =>'1', K => '1', Reset => diez, Clock_enable => '1', Clock => clk, Output=> q2);
F3: FlipflopJK port map(J => andff3, K => andff3, Reset => diez, Clock_enable =>  '1', Clock => clk, Output=> q3);
F4: FlipflopJK port map(J =>andff4, K => andff4, Reset => diez, Clock_enable =>  '1', Clock => clk, Output=> q4);

andff3 <= q1 and q2;
andff4 <= andff3 and q3;
diez <= q1 and q2 and q4;
S(0) <= q1;
S(1) <= q2;
S(2) <= q3;
S(3) <= q4;
end estructural;
