library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pul_gen is
    port(
        i_clock : in std_logic;
        i_enable: in std_logic;
        i_switch_1: in std_logic;
        i_switch_2: in std_logic;
        o_drive: out std_logic
    );
end pul_gen;

architecture rtl of pul_gen is
    -- Constantes para generar las diferentes frecuencias 
    --  “00” 1 s  - > 100000000 / 1Hz = 100000000*0.5= 50000000
    --  “01” 750 ms -> 100000000/(4/3)*.5= 37500000
    --  “10” 500 ms ->100000000/(2)*0.5= 25000000
    --  “11” 250 ms = 100000000/(4)*.5= 12500000
    constant c_CNT_1s:    natural   := 50000000; 
    constant c_CNT_750ms: natural   := 37500000;
    constant c_CNT_500ms: natural   := 25000000;
    constant c_CNT_250ms: natural   := 12500000;
    -- Contadores:
    signal r_CNT_1s    : natural range 0 to c_CNT_1s;
    signal r_CNT_750ms : natural range 0 to c_CNT_750ms;
    signal r_CNT_500ms : natural range 0 to c_CNT_500ms;
    signal r_CNT_250ms : natural range 0 to c_CNT_250ms;
    
    -- Cambio de señal
    signal r_TOGGLE_1s :    std_logic := '0';
    signal r_TOGGLE_750ms : std_logic := '0';
    signal r_TOGGLE_500ms : std_logic := '0';
    signal r_TOGGLE_250ms : std_logic := '0';
    
    -- Seleccion de 1 bit
    signal w_SELECT : std_logic;
begin

p_1_s : process (i_clock) is
 begin
    if rising_edge(i_clock) then
        if r_CNT_1s = c_CNT_1s-1 then -- -1, since counter starts at 0
            r_TOGGLE_1s <= not r_TOGGLE_1s;
            r_CNT_1s <= 0;
        else
            r_CNT_1s <= r_CNT_1s + 1;
        end if;
    end if;
end process p_1_s;

p_750_ms : process (i_clock) is
 begin
    if rising_edge(i_clock) then
        if r_CNT_750ms = c_CNT_750ms-1 then -- -1, since counter starts at 0
            r_TOGGLE_750ms <= not r_TOGGLE_750ms;
            r_CNT_750ms <= 0;
        else
            r_CNT_1s <= r_CNT_1s + 1;
        end if;
    end if;
end process p_750_ms;

p_500_ms : process (i_clock) is
 begin
    if rising_edge(i_clock) then
        if r_CNT_500ms = c_CNT_500ms-1 then -- -1, since counter starts at 0
            r_TOGGLE_500ms <= not r_TOGGLE_500ms;
            r_CNT_500ms <= 0;
        else
            r_CNT_500ms <= r_CNT_500ms + 1;
        end if;
    end if;
end process p_500_ms;

p_250_ms : process (i_clock) is
 begin
    if rising_edge(i_clock) then
        if r_CNT_250ms = c_CNT_250ms-1 then -- -1, since counter starts at 0
            r_TOGGLE_250ms <= not r_TOGGLE_250ms;
            r_CNT_250ms <= 0;
        else
            r_CNT_250ms <= r_CNT_250ms + 1;
        end if;
    end if;
 end process p_250_ms;

-- Multiplexor
 w_SELECT <= r_TOGGLE_1s when (i_switch_1 = '0' and i_switch_2 = '0') else
 r_TOGGLE_750ms when (i_switch_1 = '0' and i_switch_2 = '1') else
 r_TOGGLE_500ms when (i_switch_1 = '1' and i_switch_2 = '0') else
 r_TOGGLE_250ms;
 
 -- Permitir que o_drive pueda funcionar solo cuando i_enable esté en alto (mediante una puerta AND)"
 o_drive <= w_SELECT and i_enable;
end rtl;

