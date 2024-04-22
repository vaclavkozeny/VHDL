library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg is
    port(
        clock          : in  std_logic;
        shift_not_load : in  std_logic;
        data_in        : in  std_logic_vector(7 downto 0);
        data_out       : out std_logic_vector(7 downto 0);
        serial_in      : in  std_logic;
        serial_out     : out std_logic
    );
end shift_reg;

architecture Behavioral of shift_reg is

begin
    process(clock) 
    begin
        if rising_edge(clock) then
            if shift_not_load = '0' then
                data_out <= data_in;
            else
                data_out <= serial_in & data_out(7 downto 1);
            end if;
        end if;
    end process;
    serial_out <= data_out(0);
end Behavioral;
