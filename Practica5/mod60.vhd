library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity MOD6 is
Port( clk: in std_logic;
      S1: out std_logic_vector(2 downto 0));
end MOD6;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity MOD10 is
Port( clk: in std_logic;
      S: out std_logic_vector(3 downto 0));
end MOD10;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity mod60 is 
	port(CLK: in STD_LOGIC;
	     F60 : OUT STD_LOGIC;
	     q60: out STD_LOGIC_VECTOR (5 downto 0));
end mod60;

architecture behavioral of mod60 is

	component MOD10 is
		port(clk: in STD_LOGIC;
	   	     S: out STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component MOD6 is 
		port(clk: in STD_LOGIC;
		     S1: out STD_LOGIC_VECTOR (3 downto 0));
	end component;

signal salida07, salida06, salida05 ,salida04 ,salida03, salida02, salida01, salida00 : STD_LOGIC;
signal trst : STD_LOGIC := '0';
signal vcc : STD_LOGIC := '1';
signal flag60 : STD_LOGIC := '0';

begin

MOD10_1 : MOD10 port map(clk => CLK, S(3) => salida03, S(2) => salida02, S(1) => salida01, S(0) => salida00);

MOD6_1 : MOD6 port map(clk => trst, S1(3) => salida07, S1(2) => salida06, S1(1) => salida05, S1(0) => salida04);

process(salida03)
	begin
		if (falling_edge(salida03)) then
			trst <= '1';
		else
			trst <= '0';
		end if;
end process;

process(salida06)
	begin
		if (falling_edge(salida06)) then
			flag60 <= '1';
		else
			flag60 <= '0';
		end if;
end process;

F60 <= FLAG60;
q60(0) <= salida00;
q60(1) <= salida01;
q60(2) <= salida02;
q60(3) <= salida03;
q60(4) <= salida04;
q60(5) <= salida05;

end behavioral;