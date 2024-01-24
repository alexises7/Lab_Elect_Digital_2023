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
    sw_2:       in      std_logic;
    sw_3:       in      std_logic;
    reset:      in      std_logic;
    salida:     out     std_logic_vector(3 downto 0)
    );
end Top;

architecture rtl of Top is

component pul_gen is
    port(
        i_clock :           in      std_logic;
        i_switch_0:         in      std_logic;
        i_switch_1:         in      std_logic;
        o_clock :           out     std_logic
    );
end component;

component op_mode is
    port (
        clock           : in  std_logic;
        reset_1         : in  std_logic;
        input_1         : in std_logic;
        input_2         : in std_logic;
        input_3         : in std_logic;
        input_4         : in std_logic;
        output          : out std_logic_vector(3 downto 0)
    );
end component;

component sync_rst is
port(
    sys_clk : in std_logic;
    sys_rst : in std_logic;
    sync_rst: out std_logic
 );
end component;

component sw_deb is
  generic(
    clk_freq    : INTEGER := 100_000_000;  --system clock frequency in Hz
    stable_time : INTEGER := 10);         --time button must remain stable in ms
  port(
    clk     : in  std_logic;  --input clock
    reset_n : in  std_logic;  --asynchronous active high reset
    button  : in  std_logic;  --input signal to be debounced
    result  : out std_logic); --debounced signal
end component;

signal x1 :         std_logic;
signal rst:         std_logic;
signal sw_0_deb:    std_logic;
signal sw_1_deb:    std_logic;
signal sw_2_deb:    std_logic;
signal sw_3_deb:    std_logic;

begin
c1: pul_gen     port map (i_clock => clock, i_switch_0 => sw_0_deb , i_switch_1 => sw_1_deb, o_clock => x1);
c2: op_mode     port map (clock => x1, reset_1 => rst , input_1 =>sw_2_deb, input_2 => sw_3_deb, input_3 =>sw_0_deb, input_4=> sw_1_deb, output => salida);
c3: sync_rst    port map(sys_clk =>clock, sys_rst =>reset, sync_rst=>rst);
c4: sw_deb      port map(clk => clock, reset_n => rst,button =>sw_0,result=>sw_0_deb);
c5: sw_deb      port map(clk => clock, reset_n => rst,button =>sw_1,result=>sw_1_deb);
c6: sw_deb      port map(clk => clock, reset_n => rst,button =>sw_2,result=>sw_2_deb);
c7: sw_deb      port map(clk => clock, reset_n => rst,button =>sw_3,result=>sw_3_deb);
end rtl;
