--------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2021 04:33:49 PM
-- Design Name: 
-- Module Name: reloj - Behavioral
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

entity reloj is 
	port(
	clk_in: in std_logic;
	hrs_dec: out std_logic;
	hrs_uni: out std_logic_vector(3 downto 0);
	min_dec: out std_logic_vector(2 downto 0);
	min_uni: out std_logic_vector(3 downto 0);
	seg_dec: out std_logic_vector(2 downto 0);
	seg_uni: out std_logic_vector(3 downto 0) );
end reloj;

architecture behavioral of reloj is
	component mod12 is
		port(clk: in STD_LOGIC;
	   	     q12: out STD_LOGIC_VECTOR (3 downto 0));
	end component;


	component mod60 is
		port(clk: in STD_LOGIC;
		F60 : OUT STD_LOGIC;
		q60: out STD_LOGIC_VECTOR (5 downto 0));
	end component;
			


begin

end behavioral;