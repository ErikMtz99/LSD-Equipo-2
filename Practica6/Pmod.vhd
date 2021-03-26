library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PmodK is
    Port ( 
		   clk : in  STD_LOGIC;
		   JA : inout  STD_LOGIC_VECTOR (7 downto 0) -- PmodK is designed to be connected to JA
           -- an : out  STD_LOGIC_VECTOR (3 downto 0);   -- Controls which position of the seven segment display to display
           -- seg : out  STD_LOGIC_VECTOR (6 downto 0)    -- digit to display on the seven segment display 
           );
end PmodK;

architecture Behavioral of PmodK is
component decoderk is
	Port (
		  clk : in  STD_LOGIC;
          Row : in  STD_LOGIC_VECTOR (3 downto 0);
		  Col : out  STD_LOGIC_VECTOR (3 downto 0);
          DecodeOut : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
component decoder7 is
    Port(
            Clk: in std_logic;
            N1: in std_logic_vector(3 downto 0);
            S82: out std_logic_vector(7 downto 0)
    );
    end component;
    
signal Decode, Decode2, Decode3, Decode4: STD_LOGIC_VECTOR (3 downto 0);
signal suma, resta: std_logic_vector(3 downto 0);
signal mult : std_logic_vector(7 downto 0);

signal numero: std_logic_vector(64 downto 0);
signal valor1, valor2, valor3, valor4, valor5: std_logic_vector(3 downto 0);
signal x: std_logic;
begin

Picar1: process(Decode)
begin
if(Decode = "1110") or (Decode = "1010") then
valor1 <= Decode;
x <= '0';
elsif (Decode = "1100") or (Decode = "1101") then
valor1 <= "0000";
x <= '1';
else
valor1 <= "0000";
valor2 <= Decode;
x <= '1';
end if;
end process;

Picar2: process(Decode2)
begin
if (x <= '0') then
valor2 <= Decode2;
valor3 <= Decode3;
valor4 <= Decode4;
elsif (x <='1') then
valor3 <= Decode2;
valor4 <= Decode3;
valor5 <= Decode4;
end if;
end process;

Operacion: process(Decode3)
begin
--if (Decode3 = "1010") then 
--suma <= std_logic_vector(signed(Decode) + signed(Decode));
--elsif(Decode3 = "1011") then
--resta <= std_logic_vector(signed(opA) - signed(opB));
--elsif(Decode3 = "1100") then
--mult <= std_logic_vector(signed(opA) * signed(opB));
--end if;  
end process;

valor5 <= "1101"; --Valor del signo de igual

Decoder1: decoder7 port map (clk, valor1, numero(64 downto 57));
Decoder2: decoder7 port map (clk, valor2, numero(57 downto 49));
Decoder3: decoder7 port map (clk, valor3, numero(49 downto 41));
Decoder4: decoder7 port map (clk, valor4, numero(49 downto 41));

Decoder5: decoder7 port map (clk, valor5, numero(49 downto 41));
    
C0: decoderk port map (clk=>clk, Row =>JA(7 downto 4), Col=>JA(3 downto 0), DecodeOut=> Decode);
C1: decoderk port map (clk=>clk, Row =>JA(7 downto 4), Col=>JA(3 downto 0), DecodeOut=> Decode2);
C2: decoderk port map (clk=>clk, Row =>JA(7 downto 4), Col=>JA(3 downto 0), DecodeOut=> Decode3);

	-- C1: DisplayController port map (DispVal=>Decode, anode=>an, segOut=>seg ); 



end Behavioral;
