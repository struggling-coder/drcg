library IEEE;
use IEEE.NUMERIC_STD.ALL;

-- 0 is the threshold weight
-- 1 to 7 are the display weights

entity perceptron is
port (in1, in2, in3, in4, in5, in6, in7, tr_out, mode: in bit;
		output, status: out bit);
end entity perceptron;

architecture behaviour of perceptron is
type arrayw is array(0 to 7) of integer;
shared variable weights: arrayw:= (others => 0);
shared variable tempsum: integer:= 0;

signal t_out: bit;
begin
basic: process(in1, in2, in3, in4, in5, in6, in7, mode, tr_out) is
variable placeholder: integer;
begin
		placeholder:= 0;
		tempsum:= 0;
		status <= '0';
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
				output <= '1' after 50 ns;
				status <= '1' after 50 ns;
			else 
				output <= '0' after 50 ns;
				status <= '1' after 50 ns;
			end if;
			
		elsif mode = '1' then 
		status <= '0';
		
			tempsum := tempsum + weights(0);
			placeholder := placeholder + 1;
			if in1 = '1' then
				placeholder := placeholder + 1;
				tempsum := tempsum + weights(1);
			end if;
			if in2 = '1' then
				placeholder := placeholder + 1;
				tempsum := tempsum + weights(2);
			end if;
			if in3 = '1' then
				placeholder := placeholder + 1;
				tempsum := tempsum + weights(3);
			end if;
			if in4 = '1' then
				placeholder := placeholder + 1;
				tempsum := tempsum + weights(4);
			end if;
			if in5 = '1' then
				placeholder := placeholder + 1;
				tempsum := tempsum + weights(5);
			end if;
			if in6 = '1' then
				placeholder := placeholder + 1;
				tempsum := tempsum + weights(6);
			end if;
			if in7 = '1' then
				placeholder := placeholder + 1;
				tempsum := tempsum + weights(7);
			end if;
				
		if tempsum > 0 and placeholder = 10 then
			t_out <= '1';
		elsif tempsum <0 and placeholder = 10 then	
			t_out <= '0';
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
		status <= '1' after 50 ns;
	end if;
end process basic;


--wchange: process(in1, in2, in3, in4, in5, in6, in7, t_out, tr_out) is

--end process wchange;


end architecture behaviour;

entity skeleton is
port (inp1, inp2, inp3, inp4, inp5, inp6, inp7, mode: in bit;
		digit: in integer;	
		d_output: out integer
		);
end entity skeleton;

architecture muscle of skeleton is
signal out0, out1, out2, out3, out4, out5, out6, out7, out8, out9: bit;
signal tr_out0, tr_out1, tr_out2, tr_out3, tr_out4, tr_out5, tr_out6, tr_out7, tr_out8, tr_out9: bit;
signal status0, status1, status2, status3, status4, status5, status6, status7, status8, status9: bit;

begin
	layer00 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out0, mode, out0, status0);
	layer01 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out1, mode, out1, status1);
	layer02 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out2, mode, out2, status2);
	layer03 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out3, mode, out3, status3);
	layer04 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out4, mode, out4, status4);
	layer05 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out5, mode, out5, status5);
	layer06 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out6, mode, out6, status6);
	layer07 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out7, mode, out7, status7);
	layer08 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out8, mode, out8, status8);
	layer09 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out9, mode, out9, status9);

--	train: process() is
--	begin
		
--	end process train;

	do: process(inp1, inp2, inp3, inp4, inp5, inp6, inp7, mode, tr_out1, tr_out2, tr_out3, tr_out4, tr_out5, tr_out6, tr_out7, tr_out8, tr_out9, tr_out0) is
	begin
		if mode = '0' then
			wait on status0, status1, status2, status3, status4, status5, status6, status7, status8, status9;
			if status0 = '1' and status1 = '1' and status2 = '1' and status3 = '1' and status4 = '1' and status5 = '1' and status6 = '1' and status7 = '1' and status8 = '1' and status9 = '1' then
				if out0 = '1' then 
					d_output <= 0;
				end if;
				if out1 = '1' then 
					d_output <= 1;
				end if;
				if out2 = '1' then 
					d_output <= 2;
				end if;
				if out3 = '1' then 
					d_output <= 3;
				end if;
				if out4 = '1' then 
					d_output <= 4;
				end if;
				if out5 = '1' then 
					d_output <= 5;
				end if;
				if out6 = '1' then 
					d_output <= 6;
				end if;
				if out7 = '1' then 
					d_output <= 7;
				end if;
				if out8 = '1' then 
					d_output <= 8;
				end if;
				if out9 = '1' then 
					d_output <= 9;
				end if;
			end if;
		end if;
	end process do;
	
end architecture muscle;

entity skin is
end entity skin;

entity test_perceptron is
end entity test_perceptron;

architecture tb of test_perceptron is
signal inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out, mode, output, status, done: bit;
begin
	tp: work.perceptron(behaviour) port map(inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out, mode, output, status);
	inp1 <= '1';
	inp2 <= '1';
	inp3 <= '1';
	inp4 <= '1';
	inp5 <= '1';
	inp6 <= '1';
	inp7 <= '1';
	mode <= '0';
	
	do: process(status)
	begin
		if status = '1' then
			done <= output;
		end if;
	end process do;
end architecture tb;
