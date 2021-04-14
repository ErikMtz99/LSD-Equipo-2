library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity leds is
port ( clear, S0, S1, clk, SL, SR, A, B, C, D, E, F, G, H: in STD_LOGIC; 
    Qa, Qb, Qc, Qd, Qe, Qf, Qg, Qh : out STD_LOGIC
);
end leds;

architecture behavioral of leds is
signal Qas, Qbs, Qcs, Qds, Qes, Qfs, Qgs, Qhs: STD_LOGIC:='0';
begin 
FFA: process (clear, clk, S1, S0) begin 
if clear = '1' then 
    Qas <= '0'; 
    Qbs <= '0'; 
    Qcs <= '0'; 
    Qds <= '0'; 
    Qes <= '0'; 
    Qfs <= '0'; 
    Qgs <= '0'; 
    Qhs <= '0'; 
elsif rising_edge (clk) then
    if (S1 = '1' and S0 = '1') then 
        Qas <= A; 
        Qbs <= B; 
        Qcs <= C; 
        Qds <= D;
        Qes <= E; 
        Qfs <= F; 
        Qgs <= G; 
        Qhs <= H; 
    elsif ((not S1) = '1' and S0 = '1') then 
        Qas <= Qbs; 
        Qbs <= Qcs; 
        Qcs <= Qds; 
        Qds <= Qes;
        Qes <= Qfs; 
        Qfs <= Qgs; 
        Qgs <= Qhs; 
        Qhs <= SL; 
    elsif (S1 = '1' and (not S0) = '1' )then 
        Qas <= SR; 
        Qbs <= Qas; 
        Qcs <= Qbs; 
        Qds <= Qcs;
        Qes <= Qds;
        Qfs <= Qes;
        Qgs <= Qfs;
        Qhs <= Qgs; 
    elsif ((not S1) = '1' and (not S0) = '1') then 
        Qas <= Qas; 
        Qbs <= Qbs; 
        Qcs <= Qcs; 
        Qds <= Qds;
        Qes <= Qes; 
        Qfs <= Qfs; 
        Qgs <= Qgs; 
        Qhs <= Qhs;  
    end if; 
    end if; 
end process;
    Qa <= Qas; 
    Qb <= Qbs; 
    Qc <= Qcs; 
    Qd <= Qds;
    Qe <= Qes; 
    Qf <= Qfs; 
    Qg <= Qgs; 
    Qh <= Qhs;
end behavioral; 

library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ShiftRegister is 
Port ( 
    clear, S0, S1, clk, SL, SR, A, B, C, D, E, F, G, H: in STD_LOGIC; 
    Qa, Qb, Qc, Qd, Qe, Qf, Qg, Qh : out STD_LOGIC
    ); 
end ShiftRegister;

architecture Schematic of ShiftRegister is
component leds is 
Port ( 
    clear, S0, S1, clk, SL, SR, A, B, C, D, E, F, G, H: in STD_LOGIC; 
    Qa, Qb, Qc, Qd, Qe, Qf, Qg, Qh : out STD_LOGIC
    ); 
end component; 
signal contador: integer:= 0;
signal clk1hz: std_logic:='0';
begin
process(clk)
begin
if (clk ='1') and (clk'event) then
   if(contador = 9999999) then 
       contador <= 0;
       clk1hz <= not clk1hz; -- para que fluctue la señal
   else
       contador <= contador + 1;
   end if;
else null;
end if;
end process;

LED: leds port map (clear, S0, S1, clk1hz, SL, SR, A, B, C, D, E, F, G, H, Qa, Qb, Qc, Qd, Qe, Qf, Qg, Qh);
 
end Schematic;

