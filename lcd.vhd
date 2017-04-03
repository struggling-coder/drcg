library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity lcd is
    Port (clk : in STD_LOGIC; 
          reset : in STD_LOGIC;
          input1 : in STD_LOGIC_VECTOR (7 downto 0);
          lcd_data : out STD_LOGIC_VECTOR (7 downto 0);
          e : out STD_LOGIC;
          rs : out STD_LOGIC;
          rw : out STD_LOGIC;
					lcd_state : out STD_LOGIC_VECTOR(0 to 1) := "00" --status bits
					);
end lcd;

architecture Behavioral of lcd is
      constant upper_limit:integer:=50000;
		  constant upper_limit_write:integer:=500000;
      type state_type is (idle,command,ready,write_lcd);
      signal state,state_next:state_type:=idle;
      type command_type is array (0 to 3) of std_logic_vector (7 downto 0);
      constant commando: command_type:=(x"38",x"01",x"06",x"0F"); --LCD commands
      signal n,n_next:integer:=0;
      signal counter,counter_next:integer:=0;
    begin
      
       
      rw<='0'; --only writing to the LCD, no read operations to be done

      process(clk,reset)
          begin
            if reset='1' then --reset is active low (1=>off,0=>on)
                state<=idle;
                n<=0;
                counter<=0;
            elsif clk='1' and clk'event then --update iterating variables at every clock edge
                state<=state_next;
                n<=n_next;
                counter<=counter_next; 
            end if;
          end process;

      process(state,n,counter)
        begin
        -- avoid latch
          state_next<=state; --default updation (?)
          counter_next<=counter;
          n_next<=n;
          rs<='1'; --data input
          e<='1'; 
          case state is 
            when idle => 
    						lcd_state <= "00"; --!!!!--------need to check interface code--------!!!
                state_next<=command;
            when command=> 
				        lcd_state <= "00";
                rs<='0'; --instruction input
                lcd_data<=commando(n); 
                if counter =upper_limit then --this scales down the frequency of sending commands to lcd
                  e<='0';
                  counter_next<=0;
                  n_next<=n+1;
                  if n = commando'high then --all commands done
                    n_next<=0;
                    state_next<=ready;
                  end if;
                else
                  counter_next<=counter+1;
                end if;
            when ready => 
                if input1 /= "00000000" then
    						  lcd_state <= "10";
    						  if counter = upper_limit_write then
    									e<='1';
    									state_next<=write_lcd; 
    									counter_next<=0;
    						  else
    								  counter_next<=counter+1; 
    						  end if; 
    						else --no input available to write
    							lcd_state <= "01";
                end if;
            when write_lcd=>
    					  lcd_state <="10";
                lcd_data <= input1;
                if counter = upper_limit_write then --scaling down the frequency of write
                  e<='0';
                  counter_next<=0;
                  state_next<=ready;
  							  lcd_state <="11";
                else
                  counter_next<=counter+1; 
                end if;
            end case;
      end process; 
end Behavioral;