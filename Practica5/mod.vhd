----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2021 04:33:49 PM
-- Design Name: 
-- Module Name: mod - Behavioral
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

A1: FlipFlopJK port map(J => '1', K => '1', Reset => rst, Clock_enable => '1', Clock => clk, Output => q(0));
A2: FlipFlopJK port map(J => k, K => k, Reset => rst, Clock_enable => '1', Clock => clk, Output => q(1));
A3: FlipFlopJK port map(J => l, K => l, Reset => rst, Clock_enable => '1', Clock => clk, Output => q(2));
A4: FlipFlopJK port map(J => m, K => m, Reset => rst, Clock_enable => '1', Clock => clk, Output => q(3));

qq <= q;
end estructural;