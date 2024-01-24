
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity op_mode is
    port(
          clock:                in std_logic;
          reset_1:                in std_logic;
          input_1:              in std_logic;
          input_2:              in std_logic;
          input_3:              in std_logic;
          input_4:              in std_logic;
          output:               out std_logic_vector(3 downto 0)
    );
end op_mode;

architecture Behavioral of op_mode is
signal contador:         std_logic_vector(3 downto 0)    := "0001";
signal direccion:        BOOLEAN := true;
begin

process(clock, reset_1, input_1, input_2,input_3, input_4)
variable comb_input:     std_logic_vector(1 downto 0);
variable comb_input_2:   std_logic_vector(1 downto 0);
begin
comb_input := input_1 & input_2;
comb_input_2 := input_3 & input_4;
      if ( reset_1 = '1') then
         output <= "0001";
         direccion <= true;
      elsif rising_edge(clock) then
        case comb_input_2 is
            when "00" =>
                if comb_input = "01" then
                    -- when "01" =>
                        if contador = "0001" then
                            contador <= "0010";
                        else 
                            if contador = "1000" then
                                contador <= "0001";
                            else
                                contador <= contador(2 downto 0) & '0'; -- hacia la izquierda 
                            end if;
                        end if;
                elsif comb_input = "10" then
                --when "10" =>
                        if contador = "1000" then
                            contador <= "0100";
                        else
                            if contador = "0001" then
                                contador <= "1000";
                            else
                                contador <= '0' & contador(3 downto 1); -- hacia la derecha 
                            end if;                 
                        end if;
                 else
                    --when "00" => NULL;
                    NULL;
                 end if;
                 output <= contador;
                --end case;
            when others =>
                if direccion and contador /= "0001" then
                    if contador = "1000" then
                        contador <= "0100";
                        direccion <= false;
                    else
                        contador <= contador (2 downto 0) & '0';
                    end if;
                else
                    if contador = "0001" then
                        contador <= "0010";
                        direccion <= true;
                    else
                        contador <= '0' & contador(3 downto 1);
                    end if;
                end if;
               output <= contador;
        end case;
        
      end if;
end process;
end Behavioral;
