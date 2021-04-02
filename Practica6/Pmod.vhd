library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PmodK is
    Port ( 
		   clk : in  STD_LOGIC;
		   JA : inout  STD_LOGIC_VECTOR (7 downto 0); -- PmodK is designed to be connected to JA
           an7 : out  STD_LOGIC_VECTOR (7 downto 0);   -- Controls which position of the seven segment display to display
           seg7 : out  STD_LOGIC_VECTOR (7 downto 0)    -- digit to display on the seven segment display 
           );
end PmodK;

architecture Behavioral of PmodK is
component decoderk is
	Port (
		  clk : in  STD_LOGIC;
          Row : in  STD_LOGIC_VECTOR (3 downto 0);
		  Col : out  STD_LOGIC_VECTOR (3 downto 0);
          DecodeOut : out  STD_LOGIC_VECTOR (3 downto 0);
          contador: out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
component decoder7 is
    Port(
            Clk: in std_logic;
            N1: in std_logic_vector(3 downto 0);
            S82: out std_logic_vector(7 downto 0)
    );
    end component;
    
component segm7 is
        Port(ck : in std_logic;                          -- 100MHz system clock
                number : in  std_logic_vector (63 downto 0); -- eight digit number to be displayed
                seg : out  std_logic_vector (7 downto 0);    -- display cathodes
                an : out  std_logic_vector (7 downto 0));    -- display anodes (active-low, due to transistor complementing)
    end component;  
      
signal Decode, Decode2, Decode3, Decode4: STD_LOGIC_VECTOR (3 downto 0);
signal suma, resta, mult: std_logic_vector(3 downto 0);
signal operacion: std_logic_vector(7 downto 0);
signal operacion4bits: std_logic_vector(3 downto 0);

signal numero: std_logic_vector(63 downto 0);
signal disp2, disp4, disp8: std_logic_vector(3 downto 0);
signal bandera: integer:= 0;
signal operando: integer:= 0;
signal signo: integer:= 0;
signal x: integer:= 0;
signal cont: std_logic_vector(3 downto 0):= "0000";
signal digito1, digito2: std_logic_vector(3 downto 0);

begin

Picar: process(clk, Decode, cont, bandera, operando)
begin
case cont is 
   when "0001" => 
        case(Decode) is
            when "1110" => bandera <= 1;
            when others => bandera <= 0; digito1 <= Decode;
        end case;
        
    when "0010" =>
        if (bandera = 0) then
            if (Decode = "1010") then
                operando <= 1; -- suma
            elsif (Decode = "1011") then
                operando <= 2; -- resta
            elsif (Decode = "1100") then
                operando <= 3; -- multiplicacion
            end if;
        else 
            digito1 <= NOT(Decode) + 1 ;
        end if;
        
    when "0011" =>
        if (bandera = 0) then
                digito2 <= Decode;
            else 
               if (Decode = "1010") then
                    operando <= 1; -- suma
               elsif (Decode = "1011") then
                    operando <= 2; -- resta
               elsif (Decode = "1100") then
                    operando <= 3; -- multiplicacion
               end if;
            end if;
    when "0100" =>
        if (bandera = 0) then
                   if (Decode = "1101") then
                        cont  <= "0000";
                        if (operando = 1) then 
                            operacion(3 downto 0) <= signed(digito1)  + signed(digito2);
                        elsif(operando = 2) then
                            operacion(3 downto 0) <= signed(digito1) - signed(digito2);
                        elsif(operando = 3) then
                            operacion <= signed(digito1) * signed(digito2);
                        end if; 
                  end if; 
       else
            digito2 <= Decode;
       end if;
       
     when "0101" =>  
        if (bandera = 1) then
            if (Decode = "1101") then
                                cont  <= "0000";
                                if (operando = 1) then 
                                    operacion(3 downto 0) <= signed(digito1)  + signed(digito2);
                                elsif(operando = 2) then
                                    operacion(3 downto 0) <= signed(digito1) - signed(digito2);
                                elsif(operando = 3) then
                                    operacion <= signed(digito1) * signed(digito2);
                                end if; 
           end if;
        end if;
     when others => x <= 1; 
     
end case;
end process;

numero(63 downto 56) <= "10111111" when bandera <= 1 else "11111111"; -- Primer display de izq a derecha

disp2 <= digito1 when bandera <= 0 else NOT(digito1) + 1;
Decoder2: decoder7 port map (clk, disp2, numero(55 downto 48)); -- Primer digito

numero(47 downto 40) <= "10000110" when operando <= 1 -- Suma (E)
                   else "10111111" when operando <= 2 -- Resta
                   else "10001110" when operando <= 3; -- Mult (F) 
disp4 <= digito2;
Decoder4: decoder7 port map (clk, disp4, numero(39 downto 32));  -- Segundo digito

operacion4bits <= operacion(3 downto 0);

numero(31 downto 24) <= "10110111"; -- Signo de igual

numero(23 downto 16) <= "10111111" when (operacion < "00000000") else "11111111"; -- Signo del resultado
signo <= 0 when (operacion < "00000000") else 1;

numero(15 downto 8) <= "11111001" when (operacion > "00001010") else "11111111"; -- Decenas del resultado


disp8 <= operacion4bits - "1010" when (operacion > "00001010") and (signo <= 1) 
    else operacion4bits when (operacion < "00001010") and (signo <= 1)
    else operacion4bits - "1010" when ((NOT(operacion) + 1) > "00001010") and (signo <= 0)
    else operacion4bits when ((NOT(operacion) + 1) < "00001010") and (signo <= 0);
    
Decoder8: decoder7 port map (clk, disp8, numero(7 downto 0));    

C0: decoderk port map (clk=>clk, Row =>JA(7 downto 4), Col=>JA(3 downto 0), DecodeOut=> Decode, contador=> cont);
fpga: segm7 port map (ck=>clk, Number =>numero, seg => seg7, an  =>an7);

end Behavioral;
