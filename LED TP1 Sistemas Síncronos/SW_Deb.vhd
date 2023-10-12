----------------------------------------------------------------------------------
-- UNRN - Electronic Engeniery
-- Student: Cusa Tadeo, Sandoval Alexis
-- Digital Electronic Laboratory
-- 2023
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SW_Deb is

  GENERIC(
    clk_freq    : INTEGER := 100_000_000;  --frecuencia en  Hz
    stable_time : INTEGER := 10);         --time button must remain stable in ms
    
  Port ( 
    clk_in     : IN  STD_LOGIC;
    rst_in     : IN  STD_LOGIC;
    sw_in      : in  STD_LOGIC;
    sw_out     : out  STD_LOGIC)  
end SW_Deb;

architecture Behavioral of SW_Deb is

    signal flipflops   : STD_LOGIC_VECTOR(1 downto 0);
    signal counter_set : STD_LOGIC;
    signal debounced_switches : STD_LOGIC;
    
begin

    counter_set <= flipflops(0) xor flipflops(1);  --determine when to start/reset counter

    process(clk_in, rst_in)
        variable count :  INTEGER range 0 to clk_freq*stable_time/1000;  --counter for timing
        
    begin
        if(rst_in = '0') then                               --reset
          flipflops(1 downto 0) <= "00";                 --limpiar entrada de flipflops
          sw_out <= '0';                                 --clear result register
        elsif(clk_in'event and clk_in = '1') then              --flanco ascente clock 
          flipflops(0) <= sw_in;                        --store button value in 1st flipflop
          flipflops(1) <= flipflops(0);                  --store 1st flipflop value in 2nd flipflop
          If(counter_set = '1') then                     --resetear contador porque input cambio
            count := 0;                                    --limpiar contadores
          elsif(count < clk_freq*stable_time/1000) then  --stable input time is not yet met
            count := count + 1;                            --Incrementar contadores
          else                                           --stable input time is met
            debounced_switches <= flipflops(1);                        --output the stable value
          end if;    
        end if;
      end process;

    sw_out <= debounced_switches;

end Behavioral;
