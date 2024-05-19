library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
    generic(
        COUNTER_WIDTH : integer := 4
    );
    port(
        clock        : in  std_logic;   -- 100 MHz clock
        cnt          : out unsigned(COUNTER_WIDTH - 1 downto 0); -- counter output
        -- 
        reset        : in  std_logic;   -- positive reset
        clock_enable : in  std_logic;   -- clock enable
        limit        : in  std_logic_vector(COUNTER_WIDTH - 1 downto 0);
        repeat       : in  std_logic;   -- repeat when finished
        done         : out std_logic    -- counter reached limit
    );
end counter;

architecture Behavioral of counter is

    signal counter_reg : unsigned(COUNTER_WIDTH - 1 downto 0);

begin

    process(clock)
    begin
        if rising_edge(clock) then
            if reset = '1' then
                counter_reg <= (others => '0');
            elsif clock_enable ='1' then
                --counter_reg <= counter_reg + 1;
                if (counter_reg >= unsigned(limit)) then
                    if repeat = '1' then
                       counter_reg <= (others => '0');
                    end if;
                else
                    counter_reg <= counter_reg + 1;
                end if;
            end if;
        end if;
    end process;
    
    process(counter_reg)
    begin
        if (unsigned(counter_reg) >= unsigned(limit)) then
            done <= '1';
        else
            done <= '0';
        end if;
    end process;
    cnt <= counter_reg;

end Behavioral;