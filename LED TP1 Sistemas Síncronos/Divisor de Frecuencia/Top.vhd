----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/16/2023 02:43:24 PM
-- Design Name: 
-- Module Name: Top - Behavioral
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top is
    Port ( 
    clock:      in      std_logic;
    sw_0:       in      std_logic;
    sw_1:       in      std_logic;
    salida:     out     std_logic
    );
end Top;

architecture rtl of Top is

component pul_gen is
    port(
        i_clock :           in      std_logic;
        i_switch_0:         in      std_logic;
        i_switch_1:         in      std_logic;
        o_led_driver :      out     std_logic
    );
end component;

begin
c1: pul_gen port map (i_clock => clock, i_switch_0 => sw_0 , i_switch_1 => sw_1, o_led_driver => salida);

end rtl;
