--  0 is the threshold weight
--  1 to 7 are the display weights
--  
--  The display is:
--
--  |---- 1 ----|
--  |           |
--  2           3
--  |           |
--  |---- 4 ----|
--  |           |
--  5           6
--  |           |
--  |---- 7 ----|
--  
--  For the perceptron, mode 0 is test and mode 1 is train

library ieee;
use ieee.std_logic_1164.all;

entity perceptron is
port (in1, in2, in3, in4, in5, in6, in7, tr_out, mode: in std_logic;
		output: out std_logic);
end entity perceptron;

architecture behaviour of perceptron is
type arrayw is array(0 to 7) of integer;
shared variable weights: arrayw:= (others => 0);
shared variable tempsum: integer := 0;
shared variable t_out: std_logic;

begin
basic: process(in1, in2, in3, in4, in5, in6, in7, mode, tr_out) is
begin
		tempsum:= 0;
		if mode = '0' then
			tempsum := tempsum + weights(0);
			if in1 = '1' then
				tempsum := tempsum + weights(1);
			end if;
			if in2 = '1' then
				tempsum := tempsum + weights(2);
			end if;
			if in3 = '1' then
				tempsum := tempsum + weights(3);
			end if;
			if in4 = '1' then
				tempsum := tempsum + weights(4);
			end if;
			if in5 = '1' then
				tempsum := tempsum + weights(5);
			end if;
			if in6 = '1' then
				tempsum := tempsum + weights(6);
			end if;
			if in7 = '1' then
				tempsum := tempsum + weights(7);
			end if;
			
			if tempsum > 0 then
				output <= '1';
			else 
				output <= '0';
			end if;
			
		elsif mode = '1' then 
		
			tempsum := tempsum + weights(0);
			if in1 = '1' then				 
				tempsum := tempsum + weights(1);
			end if;
			if in2 = '1' then
				tempsum := tempsum + weights(2);
			end if;
			if in3 = '1' then
				tempsum := tempsum + weights(3);
			end if;
			if in4 = '1' then
				tempsum := tempsum + weights(4);
			end if;
			if in5 = '1' then
				tempsum := tempsum + weights(5);
			end if;
			if in6 = '1' then
				tempsum := tempsum + weights(6);
			end if;
			if in7 = '1' then
				tempsum := tempsum + weights(7);
			end if;
				
		if tempsum > 0 then
			t_out := '1';
		else 	
			t_out := '0';
		end if;

		if t_out = '0' and tr_out = '1' then

			weights(0) := weights(0) + 1;
			if in1 = '1' then
				weights(1) := weights(1) + 1;
			end if;
			if in2 = '1' then
				weights(2) := weights(2) + 1;
			end if;
			if in3 = '1' then
				weights(3) := weights(3) + 1;
			end if;
			if in4 = '1' then
				weights(4) := weights(4) + 1;
			end if;
			if in5 = '1' then
				weights(5) := weights(5) + 1;
			end if;
			if in6 = '1' then
				weights(6) := weights(6) + 1;
			end if;
			if in7 = '1' then
				weights(7) := weights(7) + 1;
			end if;
			
		elsif t_out = '1' and tr_out = '0' then
			
			weights(0) := weights(0) - 1;
			if in1 = '1' then
				weights(1) := weights(1) - 1;
			end if;
			if in2 = '1' then
				weights(2) := weights(2) - 1;
			end if;
			if in3 = '1' then
				weights(3) := weights(3) - 1;
			end if;
			if in4 = '1' then
				weights(4) := weights(4) - 1;
			end if;
			if in5 = '1' then
				weights(5) := weights(5) - 1;
			end if;
			if in6 = '1' then
				weights(6) := weights(6) - 1;
			end if;
			if in7 = '1' then
				weights(7) := weights(7) - 1;
			end if;			
		end if;
	end if;
end process basic;

end architecture behaviour;
