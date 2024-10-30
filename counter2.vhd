library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter2 is
   port(
      clk, reset: in std_logic;
      tick, rt: in std_logic;
      dout: out std_logic_vector(4 downto 0)
    );
end counter2;

architecture rtl_arch of counter2 is
   signal state: unsigned(4 downto 0);
begin
	process(clk, rt, tick)
	begin
		if(reset = '1') then
			state <= "00001";
		else
		    if(tick' event and tick = '1') then
				if (rt = '1') then
					state <= rotate_right(unsigned(state), 1);
				else
					state <= rotate_left(unsigned(state), 1);
				end if;
		    end if;
		end if;
	end process;
dout <= std_logic_vector(state);
end rtl_arch;
