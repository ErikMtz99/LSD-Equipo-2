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

entity CounterMinMOD60 is
    Port (clk: in bit;
            min_uni: out bit_vector(3 downto 0);
            min_dec: out bit_vector(2 downto 0));
end CounterMinMOD60;

architecture Behavioral of CounterMinMOD60 is

-- COMPONENTS
    component CounterSecMOD60
        Port( clk: in bit;
             seg_uni: out bit_vector(3 downto 0);
             seg_dec: out bit_vector(2 downto 0));
    end component;
    
    component CounterMOD10
        Port( clk: in bit;
            output: out bit_vector(3 downto 0));
    end component;

    component CounterMOD6
        Port( clk: in bit;
            output: out bit_vector(2 downto 0));
    end component;

--SIGNALS
signal inputM6, inputM10: bit;
signal setN, resetN: bit := '1';
signal Qout6, seg_dec: bit_vector(2 downto 0);
signal Qout10, seg_uni: bit_vector(3 downto 0);

--START BEHAVIORAL
begin
    min_dec    <= Qout6;
    min_uni    <= Qout10;
    inputM6    <= Qout10(3) and Qout10(1);
    process(clk)
    begin
        if CLK'event and clk = '1' then
            inputM10<= seg_dec(2) and seg_dec(0) and seg_uni(3) and seg_uni(0); 
        end if;
    end process;
    CSM60: CounterSecMOD60 port map(clk, seg_uni, seg_dec);
    CM10:  CounterMOD10 port map(inputM10, Qout10);
    CM6:   CounterMOD6  port map(inputM6, Qout6);
end Behavioral;