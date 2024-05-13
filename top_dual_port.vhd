library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_dual_port is
    port(
        clk                               : in  std_logic;
        rstn                              : in  std_logic;
        btn_u, btn_r, btn_d, btn_l, btn_c : in  std_logic;
        SW                                : in  std_logic_vector(15 downto 0);
        LED                               : out std_logic_vector(15 downto 0);
        displays                          : out std_logic_vector(7 downto 0);
        segments                          : out std_logic_vector(7 downto 0)
    );
end top_dual_port;

architecture Structural of top_dual_port is
    signal wea, web : std_logic;
    signal douta, doutb : std_logic_vector(3 downto 0);
    signal display_value : std_logic_vector(31 downto 0);

begin

    /*
     * Uncoment to insert dual port entity inst
     * Create 4bit DPRAM with 4bit address
     * connect clocks to clk
     * connect addra, dina, addrb and dinb to switches
     * connect addra, dina, douta, addrb, dinb and doutb to 7seg displays
     * connect wea and web to debouncers 
     */
    dpram_inst : entity work.DPRAM
        generic map(
            C_ADDR_WIDTH => 4,
            C_DATA_WIDTH => 4
        )
        port map(
            clka  => clk,
            wea   => wea,
            addra => SW(15 downto 12),
            dina  => SW(7 downto 4),
            douta => douta,
            clkb  => clk,
            web   => web,
            addrb => SW(11 downto 8),
            dinb  => SW(3 downto 0),
            doutb => doutb
        );
    

    deba : entity work.debounce
        port map(
            clock   => clk,
            button  => btn_r,
            pressed => wea
        );
        debb : entity work.debounce
        port map(
            clock   => clk,
            button  => btn_l,
            pressed => web
        );

    -- display addra, dina, douta, addrb, dinb and doutb

    display_value <= SW(15 downto 12) & SW(7 downto 4) & douta & SW(11 downto 8) & SW(3 downto 0) & doutb & X"00";
    --display_value <= X"DEADBEEF";

    display_driver_inst : entity work.display_driver
        port map(
            clock    => clk,
            reset    => not rstn,
            din      => display_value,
            segments => segments,
            displays => displays
        );

end Structural;
