library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumadorcompleto is
Port(x,y,cin: in std_logic;
     cout,suma: out std_logic);
end sumadorcompleto;

architecture ecuaciones of sumadorcompleto is
begin
sum <= x xor y xor cin;
cout <= (x and y) or (x and cin) or (y and cin);
end ecuaciones;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumaresta is
Port(A,B: in std_logic_vector(7 downto 0);
     cin: in std_logic;
     S: out std_logic_vector(7 downto 0);
     cout: out std_logic);
end sumaresta;

architecture estructural of sumaresta is
component sumadorcompleto is
Port(x,y,cin: in std_logic;
     cout,suma: out std_logic);
end component;

