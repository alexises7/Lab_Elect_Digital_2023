----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2023 08:34:19 PM
-- Design Name: 
-- Module Name: tb_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is
signal clock:   std_logic;
signal sw_0:    std_logic;
signal sw_1:    std_logic;
signal salida:  std_logic;
component pul_gen is
    port(
        i_clock :           in      std_logic;
        i_switch_0:         in      std_logic;
        i_switch_1:         in      std_logic;
        o_led_driver :      out     std_logic
    );
end component;
constant clk_period: time := 10 ns;
begin
DUT_1: pul_gen port map (i_clock => clock, i_switch_0 => sw_0 , i_switch_1 => sw_1, o_led_driver => salida);
clk_process: process
    begin
        clock <= '0';
        wait for clk_period/2;
        clock <= '1';
        wait for clk_period/2;
end process;
stimuli: process
	begin
		sw_0 <= '0'; -- Initial conditions.
		sw_1 <= '0';
		wait for 100 ns;
		sw_0 <= '1'; -- Down to work!
		sw_1 <= '1';
		wait for 100 ns;
		sw_0 <= '0'; -- Down to work!
		sw_1 <= '1';
		wait for 100 ns;
		sw_0 <= '1'; -- Down to work!
		sw_1 <= '0';
		wait for 100 ns;
		sw_0 <= '0'; -- Down to work!
		sw_1 <= '0';
        wait;
	end process;
end Behavioral;
