library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity rotate_led is
   port(
      clk, reset: in std_logic;
      pause, rt, fast: in std_logic;
      dout: out std_logic_vector(4 downto 0)
    );
end rotate_led;

architecture rtl_arch of rotate_led is
   signal tick: std_logic;
begin
   c1_unit : entity work.counter1(rtl_arch)
      port map(
         clk   => clk,
         reset => reset,
         fast => fast,
         pause => pause,
         tick  => tick
      ); 
   c2_unit : entity work.counter2(rtl_arch)
      port map(
         clk   => clk,
         reset => reset,
         tick => tick,
         rt => rt,
         dout  => dout
      ); 
end rtl_arch;
