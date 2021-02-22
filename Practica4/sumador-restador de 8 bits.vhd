library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SumRest is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);     
           B : in STD_LOGIC_VECTOR (7 downto 0);      
           Cin : in STD_LOGIC;                          
           Cout : out STD_LOGIC;                            
           OV: out STD_LOGIC;                           
           Suma : out STD_LOGIC_VECTOR (7 downto 0));     
end SumRest;

architecture Behavioral of SumRest is
component sumadorcompleto
    port(A3,B3,Cin3 : in std_logic;
        Cout3, Suma3 : out STD_lOGIC);
end component;

signal cout_s : STD_LOGIC_VECTOR (7 downto 0);
signal B2 : STD_LOGIC_VECTOR (7 downto 0);

begin


B2(0)<= (Cin xor B(0));

Suma1:sumadorcompleto
  port map(A(0),B2(0),Cin,cout_s(0),Suma(0));
    
    B2(1)<= (Cin xor B(1));
   
Suma2:sumadorcompleto
  port map(A(1),B2(1),cout_s(0),cout_s(1),Suma(1));
        
    B2(2)<= (Cin xor B(2));
           
Suma3:sumadorcompleto
  port map(A(2),B2(2),cout_s(1),cout_s(2),Suma(2));
        
        
    B2(3)<= (Cin xor B(3));
                   
Suma4:sumadorcompleto
  port map(A(3),B2(3),cout_s(2),cout_s(3),Suma(3));
                
    B2(4)<= (Cin xor B(4));
                                   
Suma5:sumadorcompleto
  port map(A(4),B2(4),cout_s(3),cout_s(4),Suma(4));
   
    B2(5)<= (Cin xor B(5));
    
Suma6:sumadorcompleto
  port map(A(5),B2(5),cout_s(4),cout_s(5),Suma(5));
                                           
    B2(6)<= (Cin xor B(6));
         
Suma7:sumadorcompleto
  port map(A(6),B2(6),cout_s(5),cout_s(6),Suma(6));
  
     B2(7)<= (Cin xor B(7));
     
Suma8:sumadorcompleto
  port map(A(7),B2(7),cout_s(6),cout_s(7),Suma(7));
       
    Cout<= cout_s(7);
    OV <= cout_s(7) xor cout_s(6);
  end Behavioral;                                    
                      