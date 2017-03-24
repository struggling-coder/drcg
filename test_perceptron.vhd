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
	
--	process(counter) is
--	begin
--		if counter = '50000' then
--			ctrl <= 20; --end it prematurely
--		end if;
--	end process;

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
	ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 
	
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
	ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 

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
	ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 

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
	ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 

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
	ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 

	when 4 =>
	-- digit 5
	in1 <= '1';
	in2 <= '1';
	in3 <= '0';
	in4 <= '1';
	in5 <= '0';
	in6 <= '1';
	in7 <= '1';
	mode <= '1';
	tr_out <= '1';
	ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 

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
	ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 

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
	tr_out <= '0';
	ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 

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
	ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 
	
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
	ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 
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
	ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 
	
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
		ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 
	end if;

	when 11 =>
	-- digit 2

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
		ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 
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
		ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 
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
		ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 
	end if;


	when 14 =>
	-- digit 5
	in1 <= '1';
	in2 <= '1';
	in3 <= '0';
	in4 <= '1';
	in5 <= '0';
	in6 <= '1';
	in7 <= '1';
	mode <= '0';
	if output = '1' then 
		ctrl <= 3 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 
	end if;

	when 15 =>
	-- digit 6
	in1 <= '1';
	in2 <= '1';
	in3 <= '0';
	in4 <= '1';
	in5 <= '1';
	in6 <= '1';
	in7 <= '1';
	mode <= '0';
	if output = '0' then 
		ctrl <= 4 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 
	end if;

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
		ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 
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
	if output = '1' then 
		ctrl <= 6 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 
	end if;

	
	when 18 =>
	-- digit 9
	if output = '1' then 
		ctrl <= 7 after 1 ns;
	else 
		ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 
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
		ctrl <= ctrl + 1 after 1 ns; -- counter <= counter + 1 after 1 ns; 
	end if;
	
	when 20 =>
	-- train phase reached
	ct <= 1;
	
	end case;
	end process;
		
end architecture tb;