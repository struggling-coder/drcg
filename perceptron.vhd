-- 0 is the threshold weight
-- 1 to 7 are the display weights
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
--

entity perceptron is
port (in1, in2, in3, in4, in5, in6, in7, tr_out, mode: in bit;
		output: out bit;
		trainstat: out integer
		);
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
				output <= '1'  ;
			else 
				output <= '0'  ;
			end if;
			
		elsif mode = '1' then 
		output <= '0';
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
				
		if tempsum > 0 and placeholder = 8 then
			t_out <= '1';
		elsif tempsum <= 0 and placeholder = 8 then	
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

begin
	layer00 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out0, mode, out0);
	layer01 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out1, mode, out1);
	layer02 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out2, mode, out2);
	layer03 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out3, mode, out3);
	layer04 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out4, mode, out4);
	layer05 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out5, mode, out5);
	layer06 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out6, mode, out6);
	layer07 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out7, mode, out7);
	layer08 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out8, mode, out8);
	layer09 : entity work.perceptron(behaviour)
		port map (inp1, inp2, inp3, inp4, inp5, inp6, inp7, tr_out9, mode, out9);

--	train: process() is
--	begin
		
--	end process train;

	do: process(inp1, inp2, inp3, inp4, inp5, inp6, inp7, mode, tr_out1, tr_out2, tr_out3, tr_out4, tr_out5, tr_out6, tr_out7, tr_out8, tr_out9, tr_out0) is
	begin
		if mode = '0' then
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
	end process do;
	
end architecture muscle;

entity skin is
end entity skin;

entity test_perceptron is
port (ct: out integer);
end entity test_perceptron;

architecture tb of test_perceptron is
signal in1, in2, in3, in4, in5, in6, in7, tr_out, mode, output, done: bit;
signal ctrl: integer range -1 to 20 := -1;
signal counter: integer:= 0;
component perceptron is
port (in1, in2, in3, in4, in5, in6, in7, tr_out, mode: in bit;
		output: out bit);
end component;
begin
	-- I have to do this at least once :'(
	
	tp: perceptron port map(in1 , in2, in3, in4, in5 , in6, in7, tr_out, mode, output);
	
	process(counter) is
	begin
		if counter = '50000' then
			ctrl <= 20; --end it prematurely
		end if;
	end process;

	process(ctrl) is
	begin
	
	ct <= 0;
	
	case ctrl is 

	when -1 =>
	-- digit 0
	in1 <= '1';
	in2 <= '1';
	in3 <= '1';
	in4 <= '0';
	in5 <= '1';
	in6 <= '1';
	in7 <= '1';
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;
	
	when 0 =>
	-- digit 1
	in1 <= '0';
	in2 <= '0';
	in3 <= '1';
	in4 <= '0';
	in5 <= '0';
	in6 <= '1';
	in7 <= '0';
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;

	when 1 =>
	-- digit 2
	in1 <= '1';
	in2 <= '0';
	in3 <= '1';
	in4 <= '1';
	in5 <= '1';
	in6 <= '0';
	in7 <= '1';
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;

	when 2 =>
	-- digit 3
	in1 <= '1';
	in2 <= '0';
	in3 <= '1';
	in4 <= '1';
	in5 <= '0';
	in6 <= '1';
	in7 <= '1';
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;

	when 3 =>
	-- digit 4
	in1 <= '0';
	in2 <= '1';
	in3 <= '1';
	in4 <= '1';
	in5 <= '0';
	in6 <= '1';
	in7 <= '0';
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;

	when 4 =>
	-- digit 5
	in1 <= '1';
	in2 <= '0';
	in3 <= '1';
	in4 <= '1';
	in5 <= '1';
	in6 <= '0';
	in7 <= '1';
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;

	when 5 =>
	-- digit 6
	in1 <= '1';
	in2 <= '1';
	in3 <= '0';
	in4 <= '1';
	in5 <= '1';
	in6 <= '1';
	in7 <= '1';
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;

	when 6 =>
	-- digit 7
	in1 <= '1';
	in2 <= '0';
	in3 <= '1';
	in4 <= '0';
	in5 <= '0';
	in6 <= '1';
	in7 <= '0';
	mode <= '1';
	tr_out <= '1';
	ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;

	when 7 =>
	-- digit 8
	in1 <= '1';
	in2 <= '1';
	in3 <= '1';
	in4 <= '1';
	in5 <= '1';
	in6 <= '1';
	in7 <= '1';
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;
	
	when 8 =>
	-- digit 9
	in1 <= '1';
	in2 <= '1';
	in3 <= '1';
	in4 <= '1';
	in5 <= '0';
	in6 <= '1';
	in7 <= '1';
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;
	--cycle complete
	
	when 9 =>
	--digit 0
	mode <= '0';
	in1 <= '1';
	in2 <= '1';
	in3 <= '1';
	in4 <= '0';
	in5 <= '1';
	in6 <= '1';
	in7 <= '1';
	ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;
	
	when 10 =>
	-- digit 1
	
	in1 <= '0';
	in2 <= '0';
	in3 <= '1';
	in4 <= '0';
	in5 <= '0';
	in6 <= '1';
	in7 <= '0';
	mode <= '0';

	if output = '1' then 
		ctrl <= -1 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;
	end if;

	when 11 =>
	-- digit 2
	if output = '1' then 
		ct <= 2;
	end if;
	
	in1 <= '1';
	in2 <= '0';
	in3 <= '1';
	in4 <= '1';
	in5 <= '1';
	in6 <= '0';
	in7 <= '1';
	mode <= '0';
	if output = '1' then 
		ctrl <= 0 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;
	end if;

	when 12 =>
	-- digit 3
	in1 <= '1';
	in2 <= '0';
	in3 <= '1';
	in4 <= '1';
	in5 <= '0';
	in6 <= '1';
	in7 <= '1';
	mode <= '0';
	if output = '1' then 
		ctrl <= 1 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;
	end if;


	when 13 =>
	-- digit 4
	in1 <= '0';
	in2 <= '1';
	in3 <= '1';
	in4 <= '1';
	in5 <= '0';
	in6 <= '1';
	in7 <= '0';
	mode <= '0';
	if output = '1' then 
		ctrl <= 2 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;
	end if;


	when 14 =>
	-- digit 5
	in1 <= '1';
	in2 <= '0';
	in3 <= '1';
	in4 <= '1';
	in5 <= '1';
	in6 <= '0';
	in7 <= '1';
	mode <= '0';
	if output = '1' then 
		ctrl <= 3 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;
	end if;

	when 15 =>
	-- digit 6

	if output = '1' then 
		ctrl <= 4 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;
	end if;

	in1 <= '1';
	in2 <= '1';
	in3 <= '0';
	in4 <= '1';
	in5 <= '1';
	in6 <= '1';
	in7 <= '1';
	mode <= '0';



	when 16 =>
	-- digit 7
	in1 <= '1';
	in2 <= '0';
	in3 <= '1';
	in4 <= '0';
	in5 <= '0';
	in6 <= '1';
	in7 <= '0';
	mode <= '0';
	if output = '1' then 
		ctrl <= 5 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;
	end if;


	when 17 =>
	-- digit 8
	in1 <= '1';
	in2 <= '1';
	in3 <= '1';
	in4 <= '1';
	in5 <= '1';
	in6 <= '1';
	in7 <= '1';
	mode <= '0';
	if output = '0' then 
		ctrl <= 6 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;
	end if;

	
	when 18 =>
	-- digit 9
	if output = '1' then 
		ctrl <= 7 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;
	end if;
	in1 <= '1';
	in2 <= '1';
	in3 <= '1';
	in4 <= '1';
	in5 <= '0';
	in6 <= '1';
	in7 <= '1';
	mode <= '0';

	
	when 19 =>
	if output = '1' then 
		ctrl <= 8 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns; counter <= counter + 1 after 1 ns;
	end if;
	
	when 20 =>
	-- train phase reached
	ct <= 1;
	
	end case;
	end process;
		
end architecture tb;

