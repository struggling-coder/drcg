
library ieee;
use ieee.std_logic_1164.all;

entity controller is
port(
	ipin1, ipin2, ipin3, ipin4, ipin5, ipin6, ipin7: in bit;
	led : out std_logic_vector ( 7 downto 0):= "00000000";
	clk: in std_logic;
	lcd_data : out std_logic_vector (7 downto 0);
	e, rs, rw: out std_logic);
end entity;

architecture behaviour of controller is
signal disp, display: string (1 to 10);
signal reset, sclk: std_logic;
shared variable delay, count: integer:=0;
signal dpin1, dpin2, dpin3, dpin4, dpin5, dpin6, dpin7: bit;
signal lcd_state: std_logic_vector(0 to 1);
signal parity, parity2, pz: std_logic:= '0';

component layer port(
sclk, clk: in std_logic;
dpin1, dpin2, dpin3, dpin4, dpin5, dpin6, dpin7: in bit; 
--ctrl:integer range -1 to 300;
disp: out string(1 to 10));
end component;

component LCD is
port( Clk      	 : IN  STD_LOGIC := '0';
      LCD_RS   	 : OUT STD_LOGIC;
      LCD_E     	: OUT STD_LOGIC;	
      toprint: in string(1 to 10);
      LCD_DataOut : OUT STD_LOGIC_VECTOR(7 downto 0));
end component;

component sclock port( 
clk: in std_logic;
sclk: out std_logic;
led: out std_logic);
end component;

begin

net: layer port map(sclk, clk, dpin1, dpin2, dpin3, dpin4, dpin5, dpin6, dpin7, disp);
lcdctrl: LCD port map(clk, rs, e, display, lcd_data);
slow: sclock port map(clk, sclk, led(0));

led(1) <= '1';
rw <= '0';

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

--testLCD: process(sclk)
--begin 
--	if rising_edge(sclk) then
--		disp <= "CAPTURE 0 ";
--	end if;
--end process;

p2Update: process(parity) 
	begin
	if (parity='1') then
		parity2 <= not parity2;
	end if;
end process;

--pipeDISP: process(sclk) is
	--begin
	--	if rising_edge(sclk) then
	--		reset <= '0';
	--		display <= disp;
	--	end if;
	--end process; 

pzUpdate: process(sclk) 
	begin
		pz <= not pz;
	end process;

pUpdate: process(sclk) 
	begin
		parity <= not parity;
	end process;

--timepass: process(clk)
	--begin
	--	if count = 0 then 
	--		count := count + 1;
	--		reset <= '0';
	--	else
	--		reset <= '1';
	--	end if;
	--end process;

pipeDISP: process(disp)
begin
		display <= disp;
end process;

end architecture;

 -- behaviour

--library ieee;
--use ieee.std_logic_1164.all;

--entity sclock is
--port( clk : in std_logic;
--		sclk : out std_logic);
--end;

--architecture behavioral of sclock is

--signal clock_temp : std_logic:='0';
--constant upper_limit_refresh:integer:=50;
--signal ctr,ctr_next:integer range 0 to upper_limit_refresh:=0;


--begin

--sclk <= clock_temp;

--process(clk)
--begin
--	if clk='1' and clk'event then
--		ctr<=ctr_next;
--	end if;
--end process;

--process(ctr)
--begin
--	ctr_next<=ctr;
--	if ctr=upper_limit_refresh then
--		ctr_next<=0;
--		clock_temp<=not(clock_temp);
--	else
--		ctr_next<=ctr+1;
--	end if;
--end process;

--end behavioral;