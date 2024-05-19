-- Title       : fifo
-- Design      : fifo
-- Author      : vaclav.kozeny@tul.cz
-- Company     : Technical University in Liberec




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FIFO is
    generic(
        C_FIFO_DEPTH_WIDTH : integer := 4;
        C_FIFO_DATA_WIDTH  : integer := 8
    );
    port(
        clk   : in  std_logic;
        rst   : in  std_logic;
        din   : in  std_logic_vector(C_FIFO_DATA_WIDTH - 1 downto 0);
        dout  : out std_logic_vector(C_FIFO_DATA_WIDTH - 1 downto 0);
        wr    : in  std_logic;
        rd    : in  std_logic;
        empty : out std_logic;
        full  : out std_logic;
        count : out std_logic_vector(C_FIFO_DEPTH_WIDTH downto 0)
    );
end FIFO;

architecture Behavioral of FIFO is

    signal head    : unsigned(C_FIFO_DEPTH_WIDTH - 1 downto 0);
    signal tail    : unsigned(C_FIFO_DEPTH_WIDTH - 1 downto 0);
    signal reg_count : unsigned(C_FIFO_DEPTH_WIDTH downto 0);

begin

    
 -- Connect DPRAM with enitity ports and counters to create FIFO
 -- Use typing functions to convert head and tail to std_logic_vector
 -- To make port open use open keyword
 -- To tie to logic 0 use '0' or (others => '0') agregate on port mapping

     
    DPRAM_inst : entity work.DPRAM
        generic map(
            C_ADDR_WIDTH => C_FIFO_DEPTH_WIDTH,
            C_DATA_WIDTH => C_FIFO_DATA_WIDTH
        )
        port map(
            clka  => clk,
            wea   => wr,
            addra => std_logic_vector(head),
            dina  => din,
            douta => open,
            clkb  => clk,
           	web   => '0',
            addrb => std_logic_vector(tail),
            dinb  => (others => '0'),
            doutb => dout
        );



-- Implement head, tail and reg_count counters here:
    -- Instantiate the counter for head
    head_counter : entity work.Counter
        generic map(
            COUNTER_WIDTH => C_FIFO_DEPTH_WIDTH
        )
        port map(
            clock        => clk,
            cnt          => head,
            reset        => rst,
            clock_enable => wr,
            limit        => (others => '1'), -- Set limit to maximum value
            repeat       => '1',
            done         => open
        );

    -- Instantiate the counter for tail
    tail_counter : entity work.Counter
        generic map(
            COUNTER_WIDTH => C_FIFO_DEPTH_WIDTH
        )
        port map(
            clock        => clk,
            cnt          => tail,
            reset        => rst,
            clock_enable => rd,
            limit        => (others => '1'), -- Set limit to maximum value
            repeat       => '1',
            done         => open
        );

    process(clk)
    begin
        if rising_edge(clk) then
			if rst = '1' then
                head <= (others => '0');
                tail <= (others => '0');
                reg_count <= (others => '0');
            else
                -- Write operation
                if wr = '1' and reg_count /= 2**C_FIFO_DEPTH_WIDTH then
                    reg_count <= reg_count + 1;
                end if;

                -- Read operation
                if rd = '1' and reg_count /= 0 then
                    reg_count <= reg_count - 1;
                end if;
            end if;
        end if;
    end process;



-- drive count, empty and full ports

    -- Drive count, empty, and full ports
    count <= std_logic_vector(reg_count);
    empty <= '1' when reg_count = 0 else '0';
    full  <= '1' when reg_count = 2**C_FIFO_DEPTH_WIDTH else '0';
		
end Behavioral;

