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

entity CounterMOD12 is
    Port (clk: in bit;
          hrs_uni: out bit_vector(3 downto 0);
          hrs_dec: out bit);
end CounterMOD12;

architecture Behavioral of CounterMOD12 is
    component FFJK
        Port(J, K, resetN, setN, clk: in bit;
            Q: out bit);
    end component;
    
signal setFF3, setFF4, setFF5, q_dec: bit;
signal set_uni, reset_uni, set_dec, reset_dec: bit:='1';
signal q_uni: bit_vector(3 downto 0);

begin
    hrs_dec <= q_dec;
    hrs_uni <= q_uni;
    setFF3  <= q_uni(0) and q_uni(1);
    setFF4  <= setFF3 and q_uni(2);
    setFF5  <= q_uni(0) and q_uni(3);
    reset_uni <= '0' when q_uni = "1010" or q_dec & q_uni = "10010" else '1';
    reset_dec <= '0' when q_dec & q_uni = "10010" else '1';
    
    FFJK1: FFJK port map('1', '1', reset_uni, set_uni, clk,  q_uni(0));
    FFJK2: FFJK port map(q_uni(0), q_uni(0), reset_uni, set_uni, clk,  q_uni(1));
    FFJK3: FFJK port map(setFF3, setFF3, reset_uni, set_uni, clk,  q_uni(2));
    FFJK4: FFJK port map(setFF4, setFF4, reset_uni, set_uni, clk,  q_uni(3));
    FFJK5: FFJK port map(setFF5, setFF5, reset_dec, set_dec, clk, q_dec);
    
end Behavioral;