library ieee;
use ieee.std_logic_1164.all;
entity sync_rst is
port(
    sys_clk : in std_logic;
    sys_rst : in std_logic;
    sync_rst: out std_logic
 );
end entity;
architecture Behavioral of sync_rst is
signal rst1: std_logic;
begin
sync_rst_proc: process(sys_clk)
begin
    if (rising_edge(sys_clk)) then
        rst1 <= sys_rst;
        sync_rst <= rst1;
    end if;
end process sync_rst_proc;
end Behavioral;
