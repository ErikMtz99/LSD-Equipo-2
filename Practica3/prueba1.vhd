----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2021 05:02:07 PM
-- Design Name: 
-- Module Name: 1 - Intro - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Intro is
    Port ( P1 : in STD_LOGIC;
           P2 : in STD_LOGIC;
           P3 : in STD_LOGIC;
           A : out STD_LOGIC;
           B : out STD_LOGIC;
           C : out STD_LOGIC;
           D : out STD_LOGIC);
end Intro;

architecture Behavioral of Intro is
begin
A <= (P1 AND P2 AND P3);
B <= (NOT P1 OR NOT P2 OR NOT P3);
C <= (P2 AND P3) OR (P1 AND P3) OR (P1 AND P2);
D <= (NOT P1 AND NOT P2) OR(NOT P1 AND NOT P3) OR (NOT P2 AND NOT P3);

end Behavioral;
