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
use IEEE.STD_LOGIC_1164;

entity Reloj is
        Port(clk_in: in bit;
        --
        seg7d, an7d : out bit_vector(7 downto 0)
        );
end Reloj;


architecture Behavioral of Reloj is
    component CounterMOD12
        Port(clk: in bit;
            hrs_uni: out bit_vector(3 downto 0);
            hrs_dec: out bit);
    end component;
    
    component CounterMinMOD60
        Port(clk: in bit;
             min_uni: out bit_vector(3 downto 0);
             min_dec: out bit_vector(2 downto 0));
    end component;
    
    component CounterSecMOD60
        Port(clk: in bit;
            seg_uni: out bit_vector(3 downto 0);
            seg_dec: out bit_vector(2 downto 0));
    end component;
    
    component decoder7
        Port( Clk: in bit;
              N1: in bit_vector(3 downto 0);
              S82: out bit_vector(7 downto 0)
        );
end component;
    
    component segm7
        Port(ck : in  bit;                          -- 100MHz system clock
             number : in  bit_vector (63 downto 0); -- eight digit number to be displayed
             seg : out  bit_vector (7 downto 0);    -- display cathodes
             an : out  bit_vector (7 downto 0));    -- display anodes (active-low, due to transistor complementing));
    end component;

signal startHrsCounter: bit;
signal clk_divisor: integer := 0;
-- signal clk_in2: bit  
signal internal_min_dec, internal_sec_dec: bit_vector(2 downto 0);
signal internal_min_uni, internal_sec_uni: bit_vector(3 downto 0);
signal min_dec_disp, min_uni_disp, hrs_uni_disp, hrs_dec_disp: bit_vector (7 downto 0);
signal horas, minutos: bit_vector(3 downto 0);
signal contador: integer:= 0;
signal clk1hz: bit:='0';
signal hrs_dec: bit;
signal hrs_uni : bit_vector(3 downto 0); 
signal D7A : BIT_VECTOR (7 downto 0);
signal D71 : BIT_VECTOR (7 downto 0);
--------

signal d7s : bit_VECTOR (63 downto 0):= "0000100101000000010001110000100000000000000000000000000000000000";
-- signal d7s : bit_VECTOR (63 downto 0):= "0000001100000011000000110000001100000000000000000000000000000000";
-- signal d7s : bit_VECTOR (63 downto 0):= "1111111111111111111111111111111100000000000000000000000000000000";


begin
    process(clk_in)
    begin
        if clk_in'event and clk_in = '1' then
         if(contador = 99999999) then 
               contador <= 0;
               clk1hz <= not clk1hz; -- para que fluctue la señal
           else
                contador <= contador + 1;
            end if;
            else null;
        -- divisor: if clk_divisor <= 50000000 then
        --wait until clk_input'event and clk_input = '1';
       -- clk_divisor <= clk_divisor + 1;
        -- if clk_divisor = 100000000 then
        --    clk_in <= '1';
        --    clk_divisor <= 0;
        -- else
        --    clk_in <= '0';
        -- end if;   
        end if;
        
         startHrsCounter<=   internal_min_dec(2) and internal_min_dec(0) and internal_min_uni(3) and internal_min_uni(0) and 
                                       internal_sec_dec(2) and internal_sec_dec(0) and internal_sec_uni(3) and internal_sec_uni(0); 
   
    end process;

    CSM60: CounterSecMOD60 port map (clk1hz, internal_sec_uni, internal_sec_dec);
    CMM60: CounterMinMOD60 port map (clk1hz, internal_min_uni, internal_min_dec);
    CHM12: CounterMOD12 port map (startHrsCounter, hrs_uni, hrs_dec);
    
    horas <= "000" & hrs_dec;
    minutos <=  '0' & internal_min_dec;
 
-- DISP: decoder7 port map (clk1hz, minutos, min_dec_disp);
-- DISP2: decoder7 port map (clk1hz, internal_min_uni, min_uni_disp);
-- DISP3: decoder7 port map (clk1hz, hrs_uni, hrs_uni_disp);
-- DISP4: decoder7 port map (clk1hz, horas, hrs_dec_disp);

DISP1: decoder7 port map (clk1hz, internal_min_uni, d7s(7 downto 0));
DISP2: decoder7 port map (clk1hz, minutos, d7s(15 downto 8));
DISP3: decoder7 port map (clk1hz, hrs_uni, d7s(23 downto 16));
DISP4: decoder7 port map (clk1hz, horas, d7s(31 downto 24));

SEGMENTOS : segm7 port map (ck => clk_in, number => d7s, seg => seg7d, an => an7d); 
   -- d7s(7 downto 0) <= min_uni_disp;
   -- d7s(15 downto 8) <= min_dec_disp;
   -- d7s(23 downto 16) <= hrs_uni_disp;
   -- d7s(31 downto 24) <= hrs_dec_disp;
--   Prueba: segm7 port map(clk1hz, d7s, D7A, D71);
   
end Behavioral;

