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
        D7A : out STD_LOGIC_VECTOR (7 downto 0);
        D71 : out STD_LOGIC_VECTOR (7 downto 0)
        
        );
end Reloj;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_1164;


entity decoder7 is
Port(
        Clk: in bit;
        N1: in bit_vector(3 downto 0);
        S82: out bit_vector(7 downto 0)
);
end decoder7;

architecture Behavioral of decoder7 is

begin
Process(Clk)
begin
 
-- pasa valor de 4 bits a su equivalente para display de 7 segmentos
case (N1) is
                    when "0000" => S82 <= "11000000";
                    when "0001" => S82 <= "11111001";
                    when "0010" => S82 <= "10100100";
                    when "0011" => S82 <= "10110000";
                    when "0100" => S82 <= "10011001";
                    when "0101" => S82 <= "10010010";
                    when "0110" => S82 <= "10000010";
                    when "0111" => S82 <= "11111000";
                    when "1000" => S82 <= "10000000";
                    when "1001" => S82 <= "10010000";
                    when others => S82 <= "11111111";
                    end case;
end process;
end Behavioral;


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
    
    component seg7m
        Port(ck : in  std_logic;                          -- 100MHz system clock
             number : in  std_logic_vector (63 downto 0); -- eight digit number to be displayed
             seg : out  std_logic_vector (7 downto 0);    -- display cathodes
             an : out  std_logic_vector (7 downto 0));    -- display anodes (active-low, due to transistor complementing));
    end component;

signal startHrsCounter: bit;
signal internal_min_dec, internal_sec_dec: bit_vector(2 downto 0);
signal internal_min_uni, internal_sec_uni: bit_vector(3 downto 0);
signal min_dec_disp, min_uni_disp, hrs_uni_disp, hrs_dec_disp: bit_vector (7 downto 0);
signal horas, minutos: bit_vector(3 downto 0);
signal contador: integer:= 0;
signal clk1hz: bit:='0';
signal hrs_dec: bit;
signal hrs_uni : bit_vector(3 downto 0); 
signal min_uni, seg_uni: bit_vector(3 downto 0);
signal min_dec, seg_dec: bit_vector(2 downto 0);

--------
-- signal watch: std_logic;
-- signal d7s : STD_LOGIC_VECTOR (63 downto 0) := "1111111111111111111111111111111100000000000000000000000000000000";


begin
    process(clk_in)
    begin
        if CLK_IN'event and clk_in = '1' then
        if(contador = 49999999) then 
               contador <= 0;
               clk1hz <= not clk1hz; -- para que fluctue la señal
           else
               contador <= contador + 1;
           end if;
           
            startHrsCounter<=   internal_min_dec(2) and internal_min_dec(0) and internal_min_uni(3) and internal_min_uni(0) and 
                                internal_sec_dec(2) and internal_sec_dec(0) and internal_sec_uni(3) and internal_sec_uni(0); 
        end if;
    end process;    
    seg_uni <= internal_sec_uni;
    seg_dec <= internal_sec_dec;
    min_uni <= internal_min_uni;
    min_dec <= internal_min_dec;
    CSM60: CounterSecMOD60 port map (clk1hz, internal_sec_uni, internal_sec_dec);
    CMM60: CounterMinMOD60 port map (clk1hz, internal_min_uni, internal_min_dec);
    CHM12: CounterMOD12 port map (startHrsCounter, hrs_uni, hrs_dec);
    
    horas <= "000" & hrs_dec;
    minutos <=  '0' & internal_min_dec;
 
    DISP: decoder7 port map (clk1hz, minutos, min_dec_disp);
    DISP2: decoder7 port map (clk1hz, internal_min_uni, min_uni_disp);
    DISP3: decoder7 port map (clk1hz, hrs_uni, hrs_uni_disp);
    DISP4: decoder7 port map (clk1hz, horas, hrs_dec_disp);
   
   -- watch <= to_std_logic(clk_in);
   --d7s(7 downto 0) <= to_std_logic(min_uni_disp);
    --d7s(15 downto 8) <= min_dec_disp;
   -- d7s(23 downto 16) <= hrs_uni_disp
   -- d7s(31 downto 24) <= hrs_dec_disp
   -- Prueba: seg7m port map(watch, d7s, D7A, D71)
   
end Behavioral;

