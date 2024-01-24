LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity sw_deb is
  generic(
    clk_freq    : INTEGER := 100_000_000;  --system clock frequency in Hz
    stable_time : INTEGER := 10);         --time button must remain stable in ms
  port(
    clk     : in  std_logic;  --input clock
    reset_n : in  std_logic;  --asynchronous active high reset
    button  : in  std_logic;  --input signal to be debounced
    result  : out std_logic); --debounced signal
end sw_deb;

architecture Behavioral of sw_deb is
  signal flipflops   : std_logic_vector(1 downto 0); --input flip flops
  signal counter_set : std_logic;                    --sync reset to zero
begin

  counter_set <= flipflops(0) xor flipflops(1);  --determine when to start/reset counter
  
  process(clk, reset_n)
    variable count :  INTEGER range 0 to clk_freq*stable_time/1000;  --counter for timing
  begin
    if(reset_n = '1') then                              --reset
      flipflops(1 downto 0) <= "00";                    --clear input flipflops
      result <= '0';                                    --clear result register
    elsif(rising_edge(clk)) then                        --rising clock edge
        flipflops(0) <= button;                         --store button value in 1st flipflop
        flipflops(1) <= flipflops(0);                   --store 1st flipflop value in 2nd flipflop
        if(counter_set = '1') then                      --reset counter because input is changing
            count := 0;                                 --clear the counter
        elsif(count < clk_freq*stable_time/1000) then   --stable input time is not yet met
            count := count + 1;                         --increment counter
        else                                            --stable input time is met
            result <= flipflops(1);                     --output the stable value
        end if;    
    end if;
end process;
end Behavioral;

