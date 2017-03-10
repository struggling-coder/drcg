library IEEE;
use IEEE.NUMERIC_STD.ALL;

entity perceptron is
port (in0, in1, in2, in3, in4, in5, in6, tr_out: in bit;
		output: out bit);
end entity perceptron;

architecture behaviour of perceptron is
type arrayw is array(0 to 6) of integer;
shared variable weights: arrayw;
begin
	
	forward: process(in0, in1, in2, in3, in4, in5, in6) is
	variable tempsum: integer;
	begin
		tempsum := 0;
			if in0 = '1' then
				tempsum := tempsum + weights(0);
			end if;
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
			if tempsum > 0 then
				output <= '1' after 10 ns;
			else
				output <= '0' after 10 ns;
			end if;
	end process forward;
	
	bp: process(in0, in1, in2, in3, in4, in5, in6, tr_out) is
	variable tempsum: integer;
	variable t_out: bit;
	begin
		tempsum := 0;
		if in0 = '1' then
			tempsum := tempsum + weights(0);
		end if;
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
		
		if tempsum > 0 then
			t_out := '1';
		else
			t_out := '0';
		end if;
		
		if t_out = '0' and tr_out = '1' then
			if in0 = '1' then
				weights(0) := weights(0) + 1;
			end if;
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
			
		elsif t_out = '1' and tr_out = '0' then
			if in0 = '1' then
				weights(0) := weights(0) - 1;
			end if;
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
		end if;
	end process bp;
end architecture behaviour;

entity test_perceptron is
end entity test_perceptron;

entity skeleton is
end entity skeleton;

architecture muscle of skeleton is
begin

end architecture muscle;