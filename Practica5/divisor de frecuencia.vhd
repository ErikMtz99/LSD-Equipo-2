------------------- De 100MHz a 1 Hz ------------------------
-- 100MHz/1MHz = 100,000,000 
-- 100,000,000/2 = 50,000,000 
-- 50,000,000 - 1 = 49,999,999

signal contador: integer:= 0;
signal clk1hz: std_logic:='0';
begin
process(clk)
begin
if (clk ='1') and (clk'event) then
   if(contador = 49999999) then 
       contador <= 0;
       clk1hz <= not clk1hz; -- para que fluctue la señal
   else
       contador <= contador + 1;
   end if;
else null;
end if;
end process;
