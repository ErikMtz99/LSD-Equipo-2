library IEEE; 
use IEEE.NUMERIC_STD.ALL; 
USE ieee.std_logic_1164.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Contador is 
Port ( CP, PE, UD, CET, CEP, D1, D2, D3, D4, U1, U2, U3, U4 : in STD_LOGIC; 
       TC : out STD_LOGIC; 
       QUnidades, QDecenas: out STD_LOGIC_VECTOR(3 downto 0)); 
end Contador; 

architecture Schematic of Contador is 
signal D1s, D2s, D3s, D4s, U1s, U2s, U3s, U4s,Enable, PEs, Test, Test2 : STD_LOGIC; signal UnidadesEntrada, DecenasEntrada, DecenasBin, UnidadesBin: STD_LOGIC_VECTOR(3 downto 0); 
signal UnidadesEntradaInt: integer :=0; 
signal DecenasEntradaInt: integer :=0; 
signal CounterUni: integer :=0; 
signal CounterDec: integer :=0; 
signal counter: integer :=0; 
signal SalidaUnidadesBin: STD_LOGIC_VECTOR(3 downto 0); 
signal SalidaDecenasBin: STD_LOGIC_VECTOR(3 downto 0);
begin 
DecenasEntrada <= D1 & D2 & D3 & D4; 
UnidadesEntrada <= U1 & U2 & U3 & U4; 
DecenasEntradaInt <= to_integer(unsigned(DecenasEntrada)); 
UnidadesEntradaInt <= to_integer(unsigned(UnidadesEntrada)); 
Enable <= CET and CEP; 

process(CP) 
begin 
if ( Enable and not(PE) )='1' then 
    PEs<='1'; 
elsif rising_edge(CP) then 
    PEs<='0'; 
if (counter = 0) then 
    CounterUni<=DecenasEntradaInt; 
    CounterDec<= DecenasEntradaInt; 
    counter<=counter+1; 
end if; 

if (Enable AND UD)='1' then 
    CounterUni <= CounterUni + 1; 
if(CounterUni>=9) then
    CounterUni <= 0; 
    CounterDec <= CounterDec + 1; 
if(CounterDec >=9) then 
    CounterDec <=0; 
end if; 
end if; 
elsif (Enable AND not(UD))='1' then 
    CounterUni <= CounterUni - 1; 
if(CounterUni<=0) then
    CounterUni <= 9; 
    CounterDec <= CounterDec - 1; 
if(CounterDec <=0) then 
    CounterDec <=9; 
end if; 
end if; 
end if; 
end if; 
end process;

SalidaDecenasBin <= 
x"9" when (DecenasEntradaInt >= 9 and PEs='1') else  x"8" when (DecenasEntradaInt >= 8 and PEs='1') else 
x"7" when (DecenasEntradaInt >= 7 and PEs='1') else 
x"6" when (DecenasEntradaInt >= 6 and PEs='1') else 
x"5" when (DecenasEntradaInt >= 5 and PEs='1') else 
x"4" when (DecenasEntradaInt >= 4 and PEs='1') else 
 x"3" when (DecenasEntradaInt >= 3 and PEs='1') else x"2" when (DecenasEntradaInt >= 2 and PEs='1') else 
x"1" when (DecenasEntradaInt >= 1 and PEs='1') else 
x"0" when (DecenasEntradaInt = 0 and PEs='1') else 
x"9" when (CounterDec >= 9 and PEs='0') else  
x"8" when (CounterDec >= 8 and PEs='0') else 
x"7" when (CounterDec >= 7 and PEs='0') else 
x"6" when (CounterDec >= 6 and PEs='0') else 
x"5" when (CounterDec >= 5 and PEs='0') else 
x"4" when (CounterDec >= 4 and PEs='0') else 
 x"3" when (CounterDec >= 3 and PEs='0') else x"2" when (CounterDec >= 2 and PEs='0') else 
x"1" when (CounterDec >= 1 and PEs='0') else 
x"0" when (CounterDec = 0 and PEs='0'); 

SalidaUnidadesBin <= 
x"9" when (UnidadesEntradaInt >= 9 and PEs='1') else  x"8" when (UnidadesEntradaInt >= 8 and PEs='1') else x"7" when (UnidadesEntradaInt >= 7 and PEs='1') else x"6" when (UnidadesEntradaInt >= 6 and PEs='1') else x"5" when (UnidadesEntradaInt >= 5 and PEs='1') else x"4" when (UnidadesEntradaInt >= 4 and PEs='1') else 
 x"3" when (UnidadesEntradaInt >= 3 and PEs='1') else x"2" when (UnidadesEntradaInt >= 2 and PEs='1') else x"1" when (UnidadesEntradaInt >= 1 and PEs='1') else x"0" when (UnidadesEntradaInt = 0 and PEs='1') else 
x"9" when (CounterUni >= 9 and PEs='0') else  
x"8" when (CounterUni >= 8 and PEs='0') else 
x"7" when (CounterUni >= 7 and PEs='0') else 
x"6" when (CounterUni >= 6 and PEs='0') else 
x"5" when (CounterUni >= 5 and PEs='0') else 
x"4" when (CounterUni >= 4 and PEs='0') else 
 x"3" when (CounterUni >= 3 and PEs='0') else x"2" when (CounterUni >= 2 and PEs='0') else 
x"1" when (CounterUni >= 1 and PEs='0') else 
x"0" when (CounterUni = 0 and PEs='0'); 

QUnidades<=SalidaUnidadesBin;  
QDecenas<=SalidaDecenasBin; 
Test<= '1' when SalidaUnidadesBin="1001";
QUnidades<=SalidaUnidadesBin;  
QDecenas<=SalidaDecenasBin; 
Test<= '1' when SalidaUnidadesBin="1001"; 
Test2<= '1' when SalidaUnidadesBin="0000"; 
TC<='0' when ((not (CET)) and UD and Test) = '1' else 
'0' when ((not (CET)) and not(UD) and Test2) = '1' else 
'1'; 
end Schematic;
