library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ShiftRegister is 
Port ( 
    clear, S0, S1, clk, SL, SR, A, B, C, D: in STD_LOGIC; 
    Qa, Qb, Qc, Qd : out STD_LOGIC
    ); 
end ShiftRegister;

architecture Schematic of ShiftRegister is 
signal Qas, Qbs, Qcs, Qds: STD_LOGIC;
begin 
FFA: process (clear, clk, S1, S0) begin 
if clear = '1' then 
    Qas <= '0'; 
    Qbs <= '0'; 
    Qcs <= '0'; 
    Qds <= '0'; 
elsif rising_edge (clk) then 
    if (S1 = '1' and S0 = '1') then 
        Qas <= A; 
        Qbs <= B; 
        Qcs <= C; 
        Qds <= D; 
    elsif ((not S1) = '1' and S0 = '1') then 
        Qas <= Qbs; 
        Qbs <= Qcs; 
        Qcs <= Qds; 
        Qds <= SR; 
    elsif (S1 = '1' and (not S0) = '1' )then 
        Qas <= SL; 
        Qbs <= Qas; 
        Qcs <= Qbs; 
        Qds <= Qcs; 
    elsif ((not S1) = '1' and (not S0) = '1') then 
        Qas <= Qas; 
        Qbs <= Qbs; 
        Qcs <= Qcs; 
        Qds <= Qds; 
    end if; 
    end if; 
end process;
 
    Qa <= Qas; 
    Qb <= Qbs; 
    Qc <= Qcs; 
    Qd <= Qds; 
end Schematic;
