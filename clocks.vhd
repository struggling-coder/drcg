-------------------Slow clock----------------

library ieee;
use ieee.std_logic_1164.all;

entity sclock is
  port (
	clk: in std_logic;
	sclk: out std_logic
  ) ;
end entity ; -- sclock

architecture behaviour of sclock is
signal count, ncount: integer:= 0;
constant lim: integer:= 250000000; --period=5s
begin

	process(clk) is
	begin
	count <= ncount;
	if(clk'event and clk='1') then
		ncount <= count + 1;   --increment counter.
	end if;
	if(count = lim) then 
		ncount <= 0;
		sclk <='1';
	else
		sclk <='0';
	end if;
	end process;

end architecture ;

-------------------Super slow clock----------------

library ieee;
use ieee.std_logic_1164.all;

entity ssclock is
  port (
	clk: in std_logic;
	ssclk: out std_logic
  ) ;
end entity ; -- ssclock

architecture behaviour of ssclock is
signal count, ncount: integer:= 0;
constant lim: integer:= 750000000; --period=5s
begin

	process(clk) is
	begin
	count <= ncount;
	if(clk'event and clk='1') then
		ncount <= count + 1;   --increment counter.
	end if;
	if(count = lim) then 
		ncount <= 0;
		ssclk <='1';
	else
		ssclk <='0';
	end if;
	end process;

end architecture;

