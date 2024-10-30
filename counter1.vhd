library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter1 is
    port(
       clk, reset: in std_logic;
       pause, fast: in std_logic;
       tick: out std_logic  
    );
end counter1;

architecture rtl_arch of counter1 is
	signal faster, slower: std_logic;			--signals that determine whether fast is 2 clock cycles or 4 clock cycles
	signal counter: std_logic_vector(1 downto 0):= "00";			--counter signal for clock cycles
begin
	process(clk, reset, pause, fast, faster, slower, counter)
	begin
		faster <= '0';					--initialize 2 clock cycles var
		slower <= '0';					--initialize 4 clock cycles var
		counter <= "00";					--initialize counter var
		if(reset = '1') then				--if reset = 0, nothing will be done
			if(clk'event and clk = '1') then		--during the rising edge of the clock
				if(fast = '1') then
					faster <= NOT faster; 			--if fast = 1 aka we want the pulse to be 'faster', change the signal 'faster' to 1 
				else						--if fast = 0 then we need to modify the 'slower' var
					if(counter = "01") then
						slower <= NOT slower;		--if fast = 0 aka we want the pulse to be 'slower', change the signal 'slower' to 1
						counter <= "00";	--increase counter var
					else					--if counter = 0
						slower <= slower;				
						counter <= counter + "01";
					end if;
				end if;
			end if;
		end if;
	end process;
tick <= fast when pause = '1' else slower when pause = '1';			
end architecture rtl_arch;