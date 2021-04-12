entity f169 is
Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
    CEP : in STD_LOGIC;
    CET : in STD_LOGIC;
    CP : in STD_LOGIC;
    UD : in STD_LOGIC;
    PE : in STD_LOGIC;
    TC : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR (3 downto 0));
end f169;

architecture Behavioral of f169 is
signal S: std_logic_vector(3 downto 0);
begin
Process(CP)
begin
if CP'event and CP = '1' then
if PE = '0' then
S <= D;
Q <= D;
end if;
if CET = '0' and CEP = '0' then
if UD = '1' then
S <= S + "0001";
Q <= S;
else
S <= S - "0001";
Q <= S;
end if;
end if;
if (CET = '0' and UD = '1' and S = "1001") or (CET = '0' and UD = '0' and S = "0000") then
TC <= '0';
else
TC <= '1';
end if;
end if;
end process;
end Behavioral