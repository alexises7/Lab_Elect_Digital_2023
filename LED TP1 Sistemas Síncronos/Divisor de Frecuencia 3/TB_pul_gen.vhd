----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2023 10:30:21 PM
-- Design Name: 
-- Module Name: TB_pul_gen - Behavioral
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

entity TB_pul_gen is
--  Port ( );
end TB_pul_gen;

architecture Behavioral of TB_pul_gen is

component pul_gen is
    port(
        i_clock :           in      std_logic;
        i_switch_0:         in      std_logic;
        i_switch_1:         in      std_logic;
        o_clock :           out     std_logic
    );
end component;
signal i_clock:                          std_logic:= '0';
signal i_switch_0:                       std_logic; 
signal i_switch_1:                       std_logic; 
signal o_clock:                          std_logic;

constant clk_period: time := 100ms;
begin
DUT_1: pul_gen port map(i_clock=>i_clock ,i_switch_0 =>i_switch_0,i_switch_1=>i_switch_1,o_clock=>o_clock);
clk_process: process
    begin
        i_clock <= '0';
        wait for clk_period/2;
        i_clock <= '1';
        wait for clk_period/2;
end process;


stimuli: process
	begin
	    wait for 20000 ms;
		i_switch_0 <= '0';
		i_switch_1 <= '1';
		wait for 2000000 ms;
        i_switch_0 <= '1';
		i_switch_1 <= '1';
		wait for 60000000 ms;
		i_switch_0 <= '1';
		i_switch_1 <= '0';
		wait for 800000000 ms;
		i_switch_0 <= '0';
		i_switch_1 <= '0';
        wait;
	end process;


end Behavioral;
