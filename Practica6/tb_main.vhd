library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;


entity tb_source02 is
    --Port ( );
    end tb_source02;
    
    --Conexión del testbench al diseño deseado. En este caso "source02"
architecture Behavioral of tb_source02 is
component main is
Port ( clock : in std_logic; 
       opA, opB : in std_logic_vector(3 downto 0);
       opselect : in std_logic_vector(2 downto 0);
       sign : out std_logic;
       seg7d, an7d : out std_logic_vector(7 downto 0));
end component;
    
    
    --Creación de señales de estimulación y monitoreo
signal clock_s : in std_logic; 
signal opA_s, opB_s : in std_logic_vector(3 downto 0);
signal opselect_s : in std_logic_vector(2 downto 0);
signal sign_s : out std_logic;
signal seg7d_s, an7d_s : out std_logic_vector(7 downto 0)
    
begin
--Mapeo de entradas y salidas a señales del testbench
DUT: main port map(
            clock => clock_s,
            opA => opA_s,
            opB => opB_s,
            opselect => opselect_s,
            sign => sign_s,
            seg7d => seg7d_s,
            an7d => an7d_s);
    
    --Estimulación de entradas mediante señales de testbench
    process
    begin
            clock_s <= '1';
            opA_s <= "0101";
            opB_s <= "0011";
            opselect_s <= "001";
            wait for 10 ns;
            
            clock_s <= '1';
            opA_s <= "1001";
            opB_s <= "0100";
            opselect_s <= "010";
            wait for 10 ns;

            clock_s <= '1';
            opA_s <= "0101";
            opB_s <= "0011";
            opselect_s <= "100";
            wait for 10 ns;
        
            clock_s <= '1';
            opA_s <= "1000";
            opB_s <= "1011";
            opselect_s <= "001";
            wait for 10 ns;

            clock_s <= '1';
            opA_s <= "0110";
            opB_s <= "1110";
            opselect_s <= "100";
            wait;
    
    end process;
    end Behavioral;