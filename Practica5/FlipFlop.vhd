----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: 
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

entity FFJK is
    Port ( J : in bit;
           K : in bit;
           resetN : in bit;
           setN : in bit;
           clk : in bit;
           Q : out bit);
end FFJK;

architecture Behavioral of FFJK is
signal q_i: bit;
begin
    Q <= q_i;
    process(clk, resetN, setN)
    begin
        if resetN = '0' then q_i <= '0';
        elsif setN = '0' then q_i <= '1';
        elsif clk'event and clk = '1' then 
            q_i  <= (J and not q_i) or (not K and q_i);
        end if;
    end process;
end Behavioral;