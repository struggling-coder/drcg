
library ieee;
use ieee.std_logic_1164.all;

entity controller is
port(ipin1, ipin2, ipin3, ipin4, ipin5, ipin6, ipin7: in bit;
	led : out std_logic_vector ( 7 downto 0):= "00000000";
	clk: in std_logic;
	lcd_data : out std_logic_vector (7 downto 0);
	e, rs, rw: out std_logic);
end entity;

architecture behaviour of controller is
signal ctr_refresh,ctr_refresh_next: integer:=0;
signal p, p_next:integer;
signal disp, display: string (1 to 10);
signal start, reset, sclk: std_logic;
shared variable delay, count: integer:=0;
signal dpin1, dpin2, dpin3, dpin4, dpin5, dpin6, dpin7: bit;
signal lcd_state: std_logic_vector(0 to 1);

--constant lim: integer:= 750000000;

component interface Port(
		clk : in std_logic; 
		start : in std_logic;
		reset : in std_logic;
		char : in STRING;
		lcd_data : out std_logic_vector (7 downto 0);
		e : out std_logic;
		rs : out std_logic;
		rw : out std_logic;
		p, p_next: inout integer:= 1;
		lcd_state: inout std_logic_vector(0 to 1));
end component;

component layer port(
sclk, clk: in std_logic;
dpin1, dpin2, dpin3, dpin4, dpin5, dpin6, dpin7: in bit; 
--ctrl:integer range -1 to 300;
disp: out string(1 to 10));
end component;

component sclock port( 
clk: in std_logic;
sclk: out std_logic);
end component;

begin
net: layer port map(sclk, clk, dpin1, dpin2, dpin3, dpin4, dpin5, dpin6, dpin7, disp);
LCD: interface port map(clk, start, reset, display, lcd_data, e, rs, rw);
slow: sclock port map(clk, sclk);

capture: process(sclk) is
begin
		dpin1 <= ipin1;
		dpin2 <= ipin2;
		dpin3 <= ipin3;
		dpin4 <= ipin4;
		dpin5 <= ipin5;
		dpin6 <= ipin6;
		dpin7 <= ipin7;
end process;

pipeDISP: process(sclk) is
begin
	display <= disp;
end process; 

resetLCDHead: process(display) is
begin
	p <= 1; p_next <= 1;
	lcd_state <= "00";
end process;

end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity sclock is
  port (
	clk: in std_logic;
	sclk: out std_logic
  ) ;
end entity ; -- sclock

architecture behaviour of sclock is
signal count: integer:=0;
constant lim: integer:= 50000000;
begin
	
	process(clk) is
	begin
	if(clk'event and clk='1') then
		count <= count +1;   --increment counter.
	end if;
	if(count = lim) then 
		count <= 0;
		sclk <='1';
	else
		sclk <='0';
	end if;
	end process;

end architecture ; -- behaviour