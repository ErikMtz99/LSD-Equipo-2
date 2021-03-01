library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity mod60 is 
	port(CLK: in STD_LOGIC;
	     F60 : OUT STD_LOGIC;
	     q60: out STD_LOGIC_VECTOR (5 downto 0));
end mod60;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity mod12 is
port(
    clk: in std_logic;
    q12: out std_logic_vector(3 downto 0));
end mod12;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity reloj is 
	port(CLKH: in STD_LOGIC;
	     UM: out STD_LOGIC_VECTOR (2 downto 0);
         DM: out STD_LOGIC_VECTOR (2 downto 0);
	     UH: out STD_LOGIC_VECTOR (1 downto 0);
         DH: out STD_LOGIC_VECTOR (1 downto 0));
end reloj;

architecture behavioral of reloj is
	component mod12 is
		port(clk: in STD_LOGIC;
	   	     q12: out STD_LOGIC_VECTOR (3 downto 0));
	end component;


	component mod60 is
		port(clk: in STD_LOGIC;
		F60 : OUT STD_LOGIC;
		q60: out STD_LOGIC_VECTOR (5 downto 0));
	end component;
			

signal Seg0, Seg1, Seg2, Seg3, Seg4, Seg5, Flag_StoM, Clock : STD_LOGIC;
signal Min0, Min1, Min2, Min3, Min4, Min5, Flag_MtoH: STD_LOGIC;
signal Hour0,Hour1,Hour2,Hour3 : STD_LOGIC;
begin


MOD60_S : mod60 port map(CLKH, Flag_StoM, Seg5, Seg4, Seg3, Seg2, Seg1, Seg0);


MOD60_M : mod60
	port map(CLK => Flag_StoM, F60 =>Flag_MtoH, q60(5)=>Min5,q60(4)=>Min4,q60(3)=>Min3,q60(2)=>Min2,q60(1)=>Min1,q60(0)=>Min0);


MOD12_H : mod12
	port map(clk => Flag_MtoH, q12(3) => Hour3, q12(2) => Hour2, q12(1) =>Hour1 , q12(0) =>Hour0);



UM(0) <= Min0;
UM(1) <= Min1;
UM(2) <= Min2;

DM(0) <= Min3;
DM(1) <= Min4;
DM(2) <= Min5;

UH(0) <= Hour0;
UH(1) <= Hour1;

DH(0) <= Hour2;
DH(1) <= Hour3;

end behavioral;