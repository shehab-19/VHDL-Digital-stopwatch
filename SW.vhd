library ieee;
use ieee.std_logic_1164.all;                                   --library declaration

entity SW is
port(secs: buffer integer range 0 to 59:=51;                   --declaration of input of seconds
	  mins: buffer integer range 0 to 59:=33;                   --declaration of input of minutes
	  secs_out, mins_out: buffer integer range 0 to 59;         --declaration of output of seconds & minutes
	  clk, start_stop: in std_logic;                            --declaration of the clock and start_stop
	  finish: out std_logic);                                   --declaration of finish
end SW;

architecture op of SW is
begin
process(clk)                                      --making the process depending on the clock
	begin
	if (start_stop='0') then                       --condition if the start_stop is 0 the values don't change
		secs<= secs;
		mins<= mins;
		finish<='0';
	elsif (clk'event and clk='1') then                --when the clock makes rising_edge the seconds decrease
		secs<= secs;
		mins<= mins;
		finish<='0';
		if (secs=0) then                               --when the seconds reaches 0 the minutes decrease => (1)
			if (mins=0) then                            --when the minutes reaches 0 the process terminates
				secs<=0;
				finish<='1';
			else                                        --if the seconds are reaches 0 and the minutes are 
				mins<=mins-1;                            --greater than 0 the minutes decrease
				secs<=59;
				finish<='0';
			end if;
		else                                           --if the seconds are greater than 0 it decrease due to (1)
			secs<= secs-1;
		end if;
	end if;
end process;
secs_out<= secs;                                     --output of seconds every cycle
mins_out<= mins;                                     --output of minutes every cycle
end op;