entity ls194 is
Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
    DSR : in STD_LOGIC;
    DSL : in STD_LOGIC;
    CLK : in STD_LOGIC;
    CLR : in STD_LOGIC;
    S1 : in STD_LOGIC;
    S0 : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR (3 downto 0));
end ls194;

architecture Behavioral of ls194 is
signal S: std_logic_vector(3 downto 0);
begin
process(CLK,CLR)
begin
if CLR = '0' then
    Q <= "0000";
elsif CLK'event and CLK = '1' then
    if S1 = '1' and S0 = '1' then
        S <= D;
        Q <= D;
elsif S1 = '1' and S0 = '0' then
    S(0) <= DSR;
    S(2 downto 0) <= S(3 downto 1);
    Q <= S;
elsif S(1) = '0' and S(0) = '1' then
    S(3) <= DSL;
    Q <= S;
    S(3 downto 1) <= S(2 downto 0);
end if;
end if;
end process;
end Behavioral;