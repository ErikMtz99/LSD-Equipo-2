entity rdb8 is
Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
    DSR : in STD_LOGIC;
    DSL : in STD_LOGIC;
    CLK : in STD_LOGIC;
    CLR : in STD_LOGIC;
    S1 : in STD_LOGIC;
    S0 : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR (7 downto 0));
end rdb8;

architecture Behavioral of rdb8 is
component ls194 is
Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
    DSR : in STD_LOGIC;
    DSL : in STD_LOGIC;
    CLK : in STD_LOGIC;
    CLR : in STD_LOGIC;
    S1 : in STD_LOGIC;
    S0 : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;
signal Si: std_logic_vector(7 downto 0);
begin
d741: ls194 port map (D(3 downto 0), Si(4), DSL, CLK, CLR, S1, S0, Si(3 downto 0));
d742: ls194 port map (D(7 downto 4), DSR, Si(3), CLK, CLR, S1, S0, Si(7 downto 4));
Q <= Si;
end Behavioral;