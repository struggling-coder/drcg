
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LCD is
port( Clk      	 : IN  STD_LOGIC := '0';
      LCD_RS   	 : OUT STD_LOGIC;
      LCD_E     	: OUT STD_LOGIC;	
      toprint: in string(1 to 10):="CAPTURE 0 ";
      LCD_DataOut : OUT STD_LOGIC_VECTOR(7 downto 0));
end entity;

architecture behave of LCD is

type atype is array(0 to 13) of std_logic_vector(7 downto 0); 
signal mem: atype;

begin

mem(0)  <= X"38";
mem(1)  <= X"0c";
mem(2)  <= X"06";
mem(3)  <= X"80";

with toprint(1) select
mem(4) <=

	x"30" when '0',
	x"31" when '1',
	x"32" when '2',
	x"33" when '3',
	x"34" when '4',
	x"35" when '5',
	x"36" when '6',
	x"37" when '7',
	x"38" when '8',
	x"39" when '9',
	"01000001" when 'A',
	"01000011" when 'C',
	"01000100" when 'D',
	"01000101" when 'E',
	"01001001" when 'I',
	"01001100" when 'L',
	"01001110" when 'N',
	"01001111" when 'O',
	"01010000" when 'P',
	"01010010" when 'R',
	"01010011" when 'S',
	"01010100" when 'T',
	"01010101" when 'U',
	"00100000" when ' ',
	"00000000" when others;

with toprint(2) select
mem(5) <=

	x"30" when '0',
	x"31" when '1',
	x"32" when '2',
	x"33" when '3',
	x"34" when '4',
	x"35" when '5',
	x"36" when '6',
	x"37" when '7',
	x"38" when '8',
	x"39" when '9',
	"01000001" when 'A',
	"01000011" when 'C',
	"01000100" when 'D',
	"01000101" when 'E',
	"01001001" when 'I',
	"01001100" when 'L',
	"01001110" when 'N',
	"01001111" when 'O',
	"01010000" when 'P',
	"01010010" when 'R',
	"01010011" when 'S',
	"01010100" when 'T',
	"01010101" when 'U',
	"00100000" when ' ',
	"00000000" when others;

with toprint(3) select
mem(6) <=

	x"30" when '0',
	x"31" when '1',
	x"32" when '2',
	x"33" when '3',
	x"34" when '4',
	x"35" when '5',
	x"36" when '6',
	x"37" when '7',
	x"38" when '8',
	x"39" when '9',
	"01000001" when 'A',
	"01000011" when 'C',
	"01000100" when 'D',
	"01000101" when 'E',
	"01001001" when 'I',
	"01001100" when 'L',
	"01001110" when 'N',
	"01001111" when 'O',
	"01010000" when 'P',
	"01010010" when 'R',
	"01010011" when 'S',
	"01010100" when 'T',
	"01010101" when 'U',
	"00100000" when ' ',
	"00000000" when others;

with toprint(4) select
mem(7) <=

	x"30" when '0',
	x"31" when '1',
	x"32" when '2',
	x"33" when '3',
	x"34" when '4',
	x"35" when '5',
	x"36" when '6',
	x"37" when '7',
	x"38" when '8',
	x"39" when '9',
	"01000001" when 'A',
	"01000011" when 'C',
	"01000100" when 'D',
	"01000101" when 'E',
	"01001001" when 'I',
	"01001100" when 'L',
	"01001110" when 'N',
	"01001111" when 'O',
	"01010000" when 'P',
	"01010010" when 'R',
	"01010011" when 'S',
	"01010100" when 'T',
	"01010101" when 'U',
	"00100000" when ' ',
	"00000000" when others;

with toprint(5) select
mem(8) <=

	x"30" when '0',
	x"31" when '1',
	x"32" when '2',
	x"33" when '3',
	x"34" when '4',
	x"35" when '5',
	x"36" when '6',
	x"37" when '7',
	x"38" when '8',
	x"39" when '9',
	"01000001" when 'A',
	"01000011" when 'C',
	"01000100" when 'D',
	"01000101" when 'E',
	"01001001" when 'I',
	"01001100" when 'L',
	"01001110" when 'N',
	"01001111" when 'O',
	"01010000" when 'P',
	"01010010" when 'R',
	"01010011" when 'S',
	"01010100" when 'T',
	"01010101" when 'U',
	"00100000" when ' ',
	"00000000" when others;

with toprint(6) select
mem(9) <=

	x"30" when '0',
	x"31" when '1',
	x"32" when '2',
	x"33" when '3',
	x"34" when '4',
	x"35" when '5',
	x"36" when '6',
	x"37" when '7',
	x"38" when '8',
	x"39" when '9',
	"01000001" when 'A',
	"01000011" when 'C',
	"01000100" when 'D',
	"01000101" when 'E',
	"01001001" when 'I',
	"01001100" when 'L',
	"01001110" when 'N',
	"01001111" when 'O',
	"01010000" when 'P',
	"01010010" when 'R',
	"01010011" when 'S',
	"01010100" when 'T',
	"01010101" when 'U',
	"00100000" when ' ',
	"00000000" when others;

with toprint(7) select
mem(10) <=

	x"30" when '0',
	x"31" when '1',
	x"32" when '2',
	x"33" when '3',
	x"34" when '4',
	x"35" when '5',
	x"36" when '6',
	x"37" when '7',
	x"38" when '8',
	x"39" when '9',
	"01000001" when 'A',
	"01000011" when 'C',
	"01000100" when 'D',
	"01000101" when 'E',
	"01001001" when 'I',
	"01001100" when 'L',
	"01001110" when 'N',
	"01001111" when 'O',
	"01010000" when 'P',
	"01010010" when 'R',
	"01010011" when 'S',
	"01010100" when 'T',
	"01010101" when 'U',
	"00100000" when ' ',
	"00000000" when others;

with toprint(8) select
mem(11) <=

	x"30" when '0',
	x"31" when '1',
	x"32" when '2',
	x"33" when '3',
	x"34" when '4',
	x"35" when '5',
	x"36" when '6',
	x"37" when '7',
	x"38" when '8',
	x"39" when '9',
	"01000001" when 'A',
	"01000011" when 'C',
	"01000100" when 'D',
	"01000101" when 'E',
	"01001001" when 'I',
	"01001100" when 'L',
	"01001110" when 'N',
	"01001111" when 'O',
	"01010000" when 'P',
	"01010010" when 'R',
	"01010011" when 'S',
	"01010100" when 'T',
	"01010101" when 'U',
	"00100000" when ' ',
	"00000000" when others;

with toprint(9) select
mem(12) <=

	x"30" when '0',
	x"31" when '1',
	x"32" when '2',
	x"33" when '3',
	x"34" when '4',
	x"35" when '5',
	x"36" when '6',
	x"37" when '7',
	x"38" when '8',
	x"39" when '9',
	"01000001" when 'A',
	"01000011" when 'C',
	"01000100" when 'D',
	"01000101" when 'E',
	"01001001" when 'I',
	"01001100" when 'L',
	"01001110" when 'N',
	"01001111" when 'O',
	"01010000" when 'P',
	"01010010" when 'R',
	"01010011" when 'S',
	"01010100" when 'T',
	"01010101" when 'U',
	"00100000" when ' ',
	"00000000" when others;

with toprint(10) select
mem(13) <=

	x"30" when '0',
	x"31" when '1',
	x"32" when '2',
	x"33" when '3',
	x"34" when '4',
	x"35" when '5',
	x"36" when '6',
	x"37" when '7',
	x"38" when '8',
	x"39" when '9',
	"01000001" when 'A',
	"01000011" when 'C',
	"01000100" when 'D',
	"01000101" when 'E',
	"01001001" when 'I',
	"01001100" when 'L',
	"01001110" when 'N',
	"01001111" when 'O',
	"01010000" when 'P',
	"01010010" when 'R',
	"01010011" when 'S',
	"01010100" when 'T',
	"01010101" when 'U',
	"00100000" when ' ',
	"00000000" when others;

LCD_proc: process(Clk)
       
       variable i : integer := 0;
       variable j : integer := 0;
       variable k : integer := 0;
     
   begin
       if (Clk'event and Clk = '1') then
          if(i <= 85000) then i := i + 1; LCD_E <= '1'; LCD_DataOut <= mem(j)(7 downto 0);
          elsif(i > 85000 and i < 160000) then i := i + 1; lcd_e <= '0';
          elsif(i = 160000) then j := j + 1; i := 0;
          end if;

	  if(j < 4) then LCD_RS <= '0';  						  -- Command Signal --
          elsif (j >= 4 and j <= 13) then lcd_rs <= '1';   -- Data Signal -- 
	       end if;

	  if(j = 14) then j := 0;                -- Repeat Data Display Routine --
          end if;
       end if;
   end process LCD_proc;
end architecture;
   
