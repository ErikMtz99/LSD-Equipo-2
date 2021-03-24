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

signal Decode: STD_LOGIC_VECTOR (3 downto 0);
begin

	C0: decoderk port map (clk=>clk, Row =>JA(7 downto 4), Col=>JA(3 downto 0), DecodeOut=> Decode);
	-- C1: DisplayController port map (DispVal=>Decode, anode=>an, segOut=>seg ); 


end Behavioral;

