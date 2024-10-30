library ieee;
use ieee.std_logic_1164.all;

entity rotate_led_tb is
end rotate_led_tb;

architecture arch of rotate_led_tb is
   constant T   : time    := 20 ns; -- clk period
   signal clk   : std_logic;
   signal reset : std_logic;
   signal pause, rt, fast : std_logic;
   signal dout : std_logic_vector(4 downto 0);
begin
   --*****************************************************************
   -- instantiation
   --*****************************************************************
   -- instantiate the unit under test
   led_unit : entity work.rotate_led(rtl_arch)
      port map(
         clk   => clk,
         reset => reset,
         fast => fast,
         rt    => rt,
         pause => pause,
         dout  => dout
      );
   --*****************************************************************
   -- clock
   --*****************************************************************
   -- clock running forever
   process
   begin
      clk <= '0';
      wait for T / 2;
      clk <= '1';
      wait for T / 2;
   end process;
   
   --*****************************************************************
   -- reset
   --*****************************************************************
   -- reset asserted for T/2
   reset <= '1', '0' after T / 2;
   
   --*****************************************************************
   -- stimulus
   --*****************************************************************
   process
   begin
      -- fast rotate right
      rt <= '1';
      fast <= '1';
      pause <= '0'; 
      wait until falling_edge(clk);
      for i in 1 to 12 loop             
         wait until falling_edge(clk);
      end loop;
      -- pause
      pause <= '1';
      for i in 1 to 2 loop            
         wait until falling_edge(clk);
      end loop;
      -- resume
      pause <= '0';
      for i in 1 to 8 loop             
         wait until falling_edge(clk);
      end loop;
      -- fast rotate left
      rt <= '0';
      fast <= '1';
      for i in 1 to 20 loop             --
         wait until falling_edge(clk);
      end loop;
      -- slow rotate right
      rt <= '1';
      fast <= '0';
      for i in 1 to 35 loop             --
         wait until falling_edge(clk);
      end loop;
      -- slow rotate left
      rt <= '0';
      for i in 1 to 35 loop             --
         wait until falling_edge(clk);
      end loop;
       --**************************************************************
      -- terminate simulation
      --**************************************************************
      assert false
         report "Simulation Completed"
         severity failure;
   end process;
end arch;
