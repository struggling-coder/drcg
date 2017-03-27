
library ieee;
use ieee.std_logic_1164.all;

entity controller is
port(dpin1, dpin2, dpin3, dpin4, dpin5, dpin6, dpin7: in bit;
	led : out std_logic_vector ( 7 downto 0);
	clk: in std_logic;
	lcd_data : out std_logic_vector (7 downto 0);
	e, rs, rw: out std_logic);
end entity;

architecture behaviour of controller is
signal ctr_refresh,ctr_refresh_next: integer:=0;
constant per: integer:=50000000;
signal reset,reset_next: STD_LOGIC:='1'; 
signal disp: string (1 to 10);
signal start: std_logic;

component interface Port(
		clk : in std_logic; 
		start : in std_logic;
		reset : in std_logic;
		char : in STRING;
		lcd_data : out std_logic_vector (7 downto 0);
		e : out std_logic;
		rs : out std_logic;
		rw : out std_logic
);
end component;

component layer port(
clk: in std_logic;
dpin1, dpin2, dpin3, dpin4, dpin5, dpin6, dpin7: in bit; 
disp: out string(1 to 10)
);
end component;

begin

net: layer port map(clk, dpin1, dpin2, dpin3, dpin4, dpin5, dpin6, dpin7, disp);
LCD: interface port map(clk, start, reset, disp, lcd_data, e, rs, rw);

process(clk,reset)
begin
	if reset='1' then
		ctr_refresh<=0;
	elsif clk='1' and clk'event then
		ctr_refresh<=ctr_refresh_next;
		reset<=reset_next;
	end if;
end process;

process(ctr_refresh,reset)
begin
	ctr_refresh_next<=ctr_refresh;
	reset_next<=reset;
	if ctr_refresh=per then
		ctr_refresh_next<=0;
		reset_next<=reset;
	else
		ctr_refresh_next<=ctr_refresh+1;
	end if;
end process;

end architecture;
