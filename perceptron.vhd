library IEEE;
use IEEE.NUMERIC_STD.ALL;

-- 0 is the threshold weight
-- 1 to 7 are the display weights

entity perceptron is
port (in1, in2, in3, in4, in5, in6, in7, tr_out: in bit;
		output: out bit);
end entity perceptron;

architecture behaviour of perceptron is
type arrayw is array(0 to 7) of integer;
shared variable weights: arrayw;
begin
	
	forward: process(in1, in2, in3, in4, in5, in6, in7) is
	variable tempsum: integer;
	begin
		tempsum := 0;
		
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
				output <= '1' after 10 ns;
			else
				output <= '0' after 10 ns;
			end if;
	end process forward;
	
	bp: process(in1, in2, in3, in4, in5, in6, in7, tr_out) is
	variable tempsum: integer;
	variable t_out: bit;
	begin
		tempsum := 0;
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
	end process bp;
end architecture behaviour;

entity test_perceptron is
end entity test_perceptron;

entity skeleton is
port (inp1, inp2, inp3, inp4, inp5, inp6, inp7: in bit,
		digit: in integer,
		d_output: out integer);
end entity skeleton;

architecture muscle of skeleton is
type layer is array(0 to 9) of work.perceptron;
variable layer0: layer;
variable tr_out: bit;
begin
	
	layer0(0) : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out);
	layer0(1) : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out);
	layer0(2) : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out);
	layer0(3) : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out);
	layer0(4) : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out);
	layer0(5) : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out);
	layer0(6) : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out);
	layer0(7) : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out);
	layer0(8) : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out);
	layer0(9) : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out);
	
	train: process() is
	begin
		
	end process train;
	
	test: process(inp1, inp2, inp3, inp4, inp5, inp6, inp7) is
	begin
		out0 := layer0(0)'forward(inp1, inp2, inp3, inp4, inp5, inp6, inp7);
		out1 := layer0(1)'forward(inp1, inp2, inp3, inp4, inp5, inp6, inp7);
		out2 := layer0(2)'forward(inp1, inp2, inp3, inp4, inp5, inp6, inp7);
		out3 := layer0(3)'forward(inp1, inp2, inp3, inp4, inp5, inp6, inp7);
		out4 := layer0(4)'forward(inp1, inp2, inp3, inp4, inp5, inp6, inp7);
		out5 := layer0(5)'forward(inp1, inp2, inp3, inp4, inp5, inp6, inp7);
		out6 := layer0(6)'forward(inp1, inp2, inp3, inp4, inp5, inp6, inp7);
		out7 := layer0(7)'forward(inp1, inp2, inp3, inp4, inp5, inp6, inp7);
		out8 := layer0(8)'forward(inp1, inp2, inp3, inp4, inp5, inp6, inp7);
		out9 := layer0(9)'forward(inp1, inp2, inp3, inp4, inp5, inp6, inp7);
	end process test;
	
end architecture muscle;