library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity delicka is
    port(
        clock        : in  std_logic       
    );
end delicka;

architecture Behavioral of delicka is
    
    -- change values to create 100 Hz pulses.
    constant DIV100HZ_WIDTH : integer := 14;
    constant DIV100HZ_LIMIT : integer := 9999;
    
    signal div10kHz_done : std_logic;


begin
    
    clock_div : entity work.counter
        generic map(
            COUNTER_WIDTH => DIV100HZ_WIDTH
        )
        port map(
            clock        => clock,
            cnt          => open,
            reset        => '0',
            clock_enable => '1',
            limit        => std_logic_vector(to_unsigned(DIV100HZ_LIMIT, DIV100HZ_WIDTH)),
            repeat       => '1',
            done         => div10kHz_done
        );
        

end Behavioral;