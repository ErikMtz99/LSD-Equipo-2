library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main is  
port (
    clk : in std_logic;
    btn_in  : in std_logic;
    pwm_out : out std_logic
);
end main;

architecture Behavioral of main is
subtype u20 is unsigned(19 downto 0);
signal counter : u20 := x"00000";

constant clk_freq   : integer := 100_000_000;       -- Clock frequency in Hz (10 ns)
constant pwm_freq   : integer := 50;                -- PWM signal frequency in Hz (20 ms)
constant period     : integer := clk_freq/pwm_freq; -- Clock cycle count per PWM period
constant duty_cycle : integer := 50_000;            -- Clock cycle count per PWM duty cycle

signal pwm_counter  : std_logic := '0';
signal stateHigh    : std_logic := '1';

begin
process(clk) is
variable cur : u20 := counter;
begin
    if (rising_edge(clk) and btn_in = '1') then
        cur := cur + 1;  
        counter <= cur;
        if (cur <= duty_cycle) then
            pwm_counter <= '1'; 
        elsif (cur > duty_cycle) then
            pwm_counter <= '0';
        elsif (cur = period) then
            cur := x"00000";
        end if;  
    end if;
end process;
pwm_out <= pwm_counter;
end Behavioral;