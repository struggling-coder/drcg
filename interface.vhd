library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity interface is
    Port ( 
    		char:in string(1 to 10);
			clk : in STD_LOGIC; 
               start : in STD_LOGIC;
               lcd_write : in STD_LOGIC;
               reset : in STD_LOGIC;
--               input1 : in STD_LOGIC_VECTOR (7 downto 0);
               lcd_data : out STD_LOGIC_VECTOR (7 downto 0);
               e : out STD_LOGIC;
               rs : out STD_LOGIC;
               rw : out STD_LOGIC;
               p, p_next:inout integer;
               lcd_state :inout STD_LOGIC_VECTOR (0 to 1)
			--button : in STd_LOGIC
);
end interface;

architecture Behavioral of interface is

	--type data_type is array(0 to 6) of character;
	--constant char : data_type:= ('3','.','1','4','1','5','9');
	--constant char : data_type:= ('A','B','C','D','E','F','G');
--	 constant char : STRING:="HELLO WORLD";
	--signal p, p_next:integer :=1;--0;
	signal input1 : STD_LOGIC_VECTOR (7 downto 0):="00000000";
	signal data : STD_LOGIC_VECTOR (7 downto 0):="00000000";--"01010000";
	--signal lcd_state : STD_LOGIC_VECTOR (0 to 1);
	--signal char : character:= '1' ;

component lcd Port(
					clk : in STD_LOGIC; 
               start : in STD_LOGIC;
               lcd_write : in STD_LOGIC;
               reset : in STD_LOGIC;
               input1 : in STD_LOGIC_VECTOR (7 downto 0);
               lcd_data : out STD_LOGIC_VECTOR (7 downto 0);
               e : out STD_LOGIC;
               rs : out STD_LOGIC;
               rw : out STD_LOGIC;
					lcd_state : out STD_LOGIC_VECTOR (0 to 1) := "00"
--					button : in STd_LOGIC
);
end component;

begin

Init_lcd : lcd PORT MAP (
			clk=>clk,
			start=>start, 
			lcd_write=>lcd_write,
			reset=>reset, 
			input1=>input1, 
			lcd_data=>lcd_data, 
			e=>e, 
			rs=>rs, 
			rw=>rw, 
			lcd_state=>lcd_state
			);

process(clk)
 begin
		if clk='1' and clk'event then
			p<=p_next;			
	  end if;
end process;
							

chartoBIN: process(lcd_state) --char will be changed to string
	begin	
		if lcd_state = "10" then
		    if char(p) = '0' then 
				data <= "00110000";
			elsif char(p) = '1' then 
				data <= "00110001";
			elsif char(p) = '2' then
				data <= "00110010";
			elsif char(p) = '3' then
				data <= "00110011";
			elsif char(p) = '4' then
				data <= "00110100";
			elsif char(p) = '5' then
				data <= "00110101";
			elsif char(p) = '6' then
				data <= "00110110";
			elsif char(p) = '7' then
				data <= "00110111";
			elsif char(p) = '8' then
				data <= "00111000";
			elsif char(p) = '9' then
				data <= "00111001";
			elsif char(p) = ':' then
				data <= "00111010";
			elsif char(p) = '.' then
				data <= "00101110";
			elsif char(p) = '#' then
				data <= "00000000";
			elsif char(p) = 'A' then 
				data <= "01000001";
			elsif char(p) = 'B' then
				data <= "01000010";
			elsif char(p) = 'C' then
				data <= "01000011";
			elsif char(p) = 'D' then
				data <= "01000100";
			elsif char(p) = 'E' then
				data <= "01000101";
			elsif char(p) = 'F' then
				data <= "01000110";
			elsif char(p) = 'G' then
				data <= "01000111";
			elsif char(p) = 'H' then
				data <= "01001000";
			elsif char(p) = 'I' then
				data <= "01001001";
			elsif char(p) = 'J' then
				data <= "01001010";
			elsif char(p) = 'K' then
				data <= "01001011";
			elsif char(p) = 'L' then 
				data <= "01001100";
			elsif char(p) = 'M' then
				data <= "01001101";
			elsif char(p) = 'N' then
				data <= "01001110";
			elsif char(p) = 'O' then
				data <= "01001111";
			elsif char(p) = 'P' then
				data <= "01010000";
			elsif char(p) = 'Q' then
				data <= "01010001";
			elsif char(p) = 'R' then
				data <= "01010010";
			elsif char(p) = 'S' then
				data <= "01010011";
			elsif char(p) = 'T' then
				data <= "01010100";
			elsif char(p) = 'U' then
				data <= "01010101";
			elsif char(p) = 'V' then
				data <= "01010110";
			elsif char(p) = 'W' then
				data <= "01010111";
			elsif char(p) = 'X' then
				data <= "01011000";
			elsif char(p) = 'Y' then
				data <= "01011001";
			elsif char(p) = 'Z' then
				data <= "01011010";
			elsif char(p) = ' ' then
				data <= "00100000";
			end if;
		end if;	
	end process;
								
communicate: process(lcd_state)
begin
p_next<=p;
	if lcd_state = "00" then
		input1 <= "00000000";
	elsif lcd_state = "01" then
		--if p<7 then
		if p<(char'LENGTH+1) then	
			input1 <= data;
		else
			input1 <= "00000000";
		end if;
	elsif lcd_state = "10" then
		--if p<7 then
		if p<(char'LENGTH+1) then	
			input1 <= data;
		else
			input1 <= "00000000";
		end if;
	elsif lcd_state = "11" then
		p_next <= p+1;
	end if;

end process;
		  
end Behavioral;