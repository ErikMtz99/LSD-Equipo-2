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
component MOD6 is
port(
    clk: in std_logic;
    S: out std_logic_vector(3 downto 0));
end component;

signal qaux : std_logic_vector(3 downto 0);

begin
Contador : MOD6 port map(clk => clk , S => qaux);
S <= qaux;

end estructural;