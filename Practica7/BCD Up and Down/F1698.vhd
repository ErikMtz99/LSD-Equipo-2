entity f1698 is
Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
    CEP : in STD_LOGIC;
    CET : in STD_LOGIC;
    PE : in STD_LOGIC;
    CP : in STD_LOGIC;
    UD : in STD_LOGIC;
    TC : out STD_LOGIC;
    Q1 : out STD_LOGIC_VECTOR (7 downto 0));
end f1698;

architecture Behavioral of f1698 is
component f169 is
Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
    CEP : in STD_LOGIC;
    CET : in STD_LOGIC;
    CP : in STD_LOGIC;
    UD : in STD_LOGIC;
    PE : in STD_LOGIC;
    TC : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;
signal S1,S2: std_logic_vector(3 downto 0);
signal T, T1, T2, SCEP, SCET, SUD, MUX: std_logic;
begin
Process(CP)
begin
if CP'event and CP = '1' then
if PE = '0' then
S1 <= D(3 downto 0);
S2 <= D(7 downto 4);
else
if T = '0' and UD = '1' then
T1 <= '1';
if S1 = "1001" and S2 /= "1001" then
S1 <= "0000";
elsif S1 = "1001" and S2 = "1001" then
S1 <= "0000";
S2 <= "0000";
end if;
elsif T = '0' and UD = '0' then
T1 <= '1';
if S1 = "0000" and S2 /= "0000" then
S1 <= "1001";
elsif S1 = "0000" and S2 = "0000" then
S1 <= "1001";
S2 <= "1001";
end if;
else
T1 <= '0';
end if;
end if;
end if;
end process;
s1691: f169 port map(S1,CEP,CET,CP,UD,PE,T,S1);
s1692: f169 port map(S1,CEP,CET,T1,UD,PE,TC,S2);

Process(CP)
begin
if(MUX = '0') then
case (S1) is
when "0000" => Q1 <= "11000000";
when "0001" => Q1 <= "11111001";
when "0010" => Q1 <= "10100100";
when "0011" => Q1 <= "10110000";
when "0100" => Q1 <= "10011001";
when "0101" => Q1 <= "10010010";
when "0110" => Q1 <= "10000010";
when "0111" => Q1 <= "11111000";
when "1000" => Q1 <= "10000000";
when "1001" => Q1 <= "10010000";
when others => Q1 <= "11111111";
end case;
MUX <= '1';
elsif (MUX = '1') then
case (S2) is
when "0000" => Q1 <= "11000000";
when "0001" => Q1 <= "11111001";
when "0010" => Q1 <= "10100100";
when "0011" => Q1 <= "10110000";
when "0100" => Q1 <= "10011001";
when "0101" => Q1 <= "10010010";
when "0110" => Q1 <= "10000010";
when "0111" => Q1 <= "11111000";
when "1000" => Q1 <= "10000000";
when "1001" => Q1 <= "10010000";
when others => Q1 <= "11111111";
end case;
MUX <= '0';
end if;
end process;
end Behavioral;