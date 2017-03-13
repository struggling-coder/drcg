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
port (input: in bit_vector(1 to 7);
		tr_out, mode: in bit;
		output: out bit
		);
end entity perceptron;

architecture behaviour of perceptron is
type arrayw is array(0 to 7) of integer;
shared variable weights: arrayw:= (others => 0);
shared variable tempsum: integer:= 0;
signal t_out: bit;

begin
basic: process(input, mode, tr_out) is
begin
		tempsum:= 0;
		if mode = '0' then
		
			tempsum := tempsum + weights(0);
			for iter1 in 1 to 7 loop
				if input(iter1) = '1' then
					tempsum := tempsum + weights(iter1);
				end if;
			end loop;
			
			if tempsum > 0 then
				output <= '1';
			else 
				output <= '0';
			end if;
			
		elsif mode = '1' then 
		
			tempsum := tempsum + weights(0);
			for iter2 in 1 to 7 loop
				if input(iter2) = '1' then
						tempsum := tempsum + weights(iter2);
				end if;
			end loop;
			
			if tempsum > 0 then
				t_out <= '1';
			else 	
				t_out <= '0';
			end if;

		if t_out = '0' and tr_out = '1' then

			weights(0) := weights(0) + 1;
			for iter3 in 1 to 7 loop
				if input(iter3) = '1' then
					weights(iter3) := weights(iter3) + 1;
				end if;
			end loop;
			
		elsif t_out = '1' and tr_out = '0' then
			
			weights(0) := weights(0) - 1;
			for iter4 in 1 to 7 loop
				if input(iter4) = '1' then
					weights(iter4) := weights(iter4) - 1;
				end if;
			end loop;
						
		end if;
	end if;
end process basic;

--asynch_status: process(async) is
--	status <= async;
--end process asynch_status;

--wchange: process(in1, in2, in3, in4, in5, in6, in7, t_out, tr_out) is
--end process wchange;

end architecture behaviour;

entity skeleton is
port (mode: in bit;
		input: in bit_vector(1 to 7);
		digit: in integer;	
		d_output: out integer
		);
end entity skeleton;

architecture muscle of skeleton is
signal out_array: bit_vector(0 to 9);
signal tr_array: bit_vector(0 to 9);
begin

	layer00 : entity work.perceptron(behaviour)
		 port map (input, tr_array(0), mode, out_array(0));
	layer01 : entity work.perceptron(behaviour)
		 port map (input, tr_array(1), mode, out_array(1));
	layer02 : entity work.perceptron(behaviour)
		 port map (input, tr_array(2), mode, out_array(2));
	layer03 : entity work.perceptron(behaviour)
		 port map (input, tr_array(3), mode, out_array(3));
	layer04 : entity work.perceptron(behaviour)
		 port map (input, tr_array(4), mode, out_array(4));
	layer05 : entity work.perceptron(behaviour)
		 port map (input, tr_array(5), mode, out_array(5));
	layer06 : entity work.perceptron(behaviour)
		 port map (input, tr_array(6), mode, out_array(6));
	layer07 : entity work.perceptron(behaviour)
		 port map (input, tr_array(7), mode, out_array(7));
	layer08 : entity work.perceptron(behaviour)
		 port map (input, tr_array(8), mode, out_array(8));
	layer09 : entity work.perceptron(behaviour)
		 port map (input, tr_array(9), mode, out_array(9));

	do: process(input, mode, tr_array) is
	begin
		if mode = '0' then
--			wait on status0, status1, status2, status3, status4, status5, status6, status7, status8, status9;
				if out_array(0) = '1' then 
					d_output <= 0;
				end if;
				if out_array(1) = '1' then 
					d_output <= 1;
				end if;
				if out_array(2) = '1' then 
					d_output <= 2;
				end if;
				if out_array(3) = '1' then 
					d_output <= 3;
				end if;
				if out_array(4) = '1' then 
					d_output <= 4;
				end if;
				if out_array(5) = '1' then 
					d_output <= 5;
				end if;
				if out_array(6) = '1' then 
					d_output <= 6;
				end if;
				if out_array(7) = '1' then 
					d_output <= 7;
				end if;
				if out_array(8) = '1' then 
					d_output <= 8;
				end if;
				if out_array(9) = '1' then 
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
signal input: bit_vector(1 to 7);
signal tr_out, mode, output: bit;
signal ctrl: integer range -1 to 20 := -1;
component perceptron is
port (input: in bit_vector(1 to 7);
		tr_out, mode: in bit;
		output: out bit);
end component;
begin
	-- I have to do this at least once :'(
	
	tp: perceptron port map(input, tr_out, mode, output);
	
	process(ctrl) is
	begin
	ct <= 0;
	case ctrl is 

	when -1 =>
	-- digit 0
	input <= "1110111";
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns;
	
	when 0 =>
	-- digit 1
	input <= "0010010";
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns;

	when 1 =>
	-- digit 2
	input <= "1011101";
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns;

	when 2 =>
	-- digit 3
	
	input <= "1011011";
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns;

	when 3 =>
	-- digit 4
	input <= "0111010";
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns;

	when 4 =>
	-- digit 5
	input <= "1101011";
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns;

	when 5 =>
	-- digit 6
	input <= "1101111";
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns;

	when 6 =>
	-- digit 7
	input <= "1010010";
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns;

	when 7 =>
	-- digit 8
	input <= "1111111";
	mode <= '1';
	tr_out <= '1';
	ctrl <= ctrl + 1 after 1 ns;
	
	when 8 =>
	-- digit 9
	input <= "1111011";
	mode <= '1';
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns;
	--cycle complete
	
	when 9 =>
	mode <= '0';
	input <= "1110111";
	ctrl <= ctrl + 1 after 1 ns;
	
	when 10 =>
	-- digit 1
	input <= "0010010";
	mode <= '0';
	if output = '1' then 
		ctrl <= -1 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns;
	end if;

	when 11 =>
	-- digit 2
	input <= "1011101";
	mode <= '0';
	if output = '1' then 
		ctrl <= 0 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns;
	end if;

	when 12 =>
	-- digit 3
	input <= "1011011";
	mode <= '0';
	if output = '1' then 
		ctrl <= 1 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns;
	end if;

	when 13 =>
	-- digit 4
	input <= "0111010";
	mode <= '0';
	if output = '1' then 
		ctrl <= 2 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns;
	end if;

	when 14 =>
	-- digit 5
	input <= "1101011";
	mode <= '0';
	if output = '1' then 
		ctrl <= 3 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns;
	end if;

	when 15 =>
	-- digit 6	
	input <= "1101111";
	mode <= '0';
	if output = '1' then 
		ctrl <= 4 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns;
	end if;

	when 16 =>
	-- digit 7
	input <= "1010010";
	mode <= '0';
	if output = '1' then 
		ctrl <= 5 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns;
	end if;

	when 17 =>
	-- digit 8
	input <= "1111111";
	mode <= '0';
	if output = '1' then 
		ctrl <= 6 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns;
	end if;
	
	when 18 =>
	-- digit 9
	input <= "1111011";
	mode <= '0';
	if output = '0' then 
		ctrl <= 7 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns;
	end if;
	
	when 19 =>
	if output = '1' then 
		ctrl <= 8 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns;
	end if;
	
	when 20 =>
	-- test phase reached
	ct <= 1;
	input <= "1111111";
	
	end case;
	end process;
		
end architecture tb;

