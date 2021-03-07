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

entity CounterMOD6 is
    Port(clk: in bit;
        output: out bit_vector(2 downto 0));
end CounterMOD6;

architecture Behavioral of CounterMOD6 is
    component FFJK
        Port(J, K, resetN, setN, clk: in bit;
            Q: out bit
        );
    end component;
    
signal setN, resetN,q1, q2, q3, inq3: bit;
begin
setN <= '1';
resetN <= '0' when q3 & q2 & q1 = "110" else '1';
inq3 <= q1 and q2;
output <= q3 & q2 & q1;

FFJK1: FFJK port map('1', '1', resetN, setN, clk, q1);
FFJK2: FFJK port map(q1, q1, resetN, setN, clk, q2);
FFJK3: FFJK port map(inq3, inq3, resetN, setN, clk, q3);

end Behavioral;