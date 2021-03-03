----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2021 04:33:49 PM
-- Design Name: 
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

entity MOD12 is
port(
    clk: in std_logic;
    S: out std_logic_vector(3 downto 0));
end MOD12;

architecture estructural of MOD12 is
component FlipFlop is
port  ( 
    J,K: in  std_logic;
    Reset: in std_logic;
    Clock_enable: in std_logic;
    Clock: in std_logic;
    Output: out std_logic);
end component;

signal q1, q2, q3, q4 : std_logic_vector(3 downto 0);

begin
F1: FlipFlop port map (J => '1', K => '1', Reset => doce, Clock_enable => '1', Clock => clk, Output=> q1);
F2: FlipFlop port map (J => '1', K => '1', Reset => doce, Clock_enable => '1', Clock => clk, Output=> q2);
F3: FlipFlop port map (J => and1, K => and1, Reset => doce, Clock_enable => '1', Clock => clk, Output=> q3);
F4: FlipFlop port map (J => and2 , K => and2 , Reset => doce, Clock_enable => '1', Clock => clk, Output=> q4);

and1 <= q1 and q2;
and2 <= and1 and and2;

doce <= q4 and q3;
S(0) <= q1;
S(1) <= q2;
S(2) <= q3;
S(3) <= q4;


end estructural;