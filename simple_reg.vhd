library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity simple_reg is
    port(
        clock      : in  std_logic;     -- synchronous clock signal connected to push button
        reset      : in  std_logic;     -- reset signal
        data       : in  std_logic;     -- data signal
        enable     : in  std_logic;     -- enable signal
        q_ff_re    : out std_logic;     -- a flip flop 
        q_latch    : out std_logic;     -- latch output
        q_ff_re_sr : out std_logic;     -- a flip flop with synchronous reset output, rising edge
        q_ff_fe_ar : out std_logic      -- a flip flop with asynchronous reset output, falling edge
    );
end simple_reg;

architecture Behavioral of simple_reg is

    signal ff_re : std_logic := '0';
    signal latch_re : std_logic := '0';
    signal ff_re_sr : std_logic := '0';
    signal ff_re_ar : std_logic := '0';
begin

    -- Rising edge D flipflop
    process(clock)
    begin
        if rising_edge(clock) then
            ff_re <= data;
        end if;
    end process;
    q_ff_re <= ff_re;
    
    process(reset, clock)
    begin
        if(reset) then
            latch_re <= '0';
        elsif(clock = '1') then
            latch_re <= data;
        end if;
    end process;
    q_latch <= latch_re;
    process(clock) -- pravdepodobne process nemusi reagovate na reset a enable 
    begin
        if rising_edge (clock) then
            if(reset) then
                ff_re_sr <= '0';
            elsif(enable) then
                ff_re_sr <= data;
            end if;
        end if;
    end process;
    q_ff_re_sr <= ff_re_sr;
    
    process(reset, clock)
    begin
        if(reset) then
            ff_re_ar <= '0';
        elsif falling_edge  (clock) then
            if(enable) then
                ff_re_ar <= data;
            end if;
        end if;
    end process;
    q_ff_fe_ar <= ff_re_ar;
end Behavioral;
