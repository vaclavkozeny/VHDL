library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_fifo is
    port(
        clk                               : in  std_logic;
        rstn                              : in  std_logic;
        btn_u, btn_r, btn_d, btn_l, btn_c : in  std_logic;
        SW                                : in  std_logic_vector(15 downto 0);
        LED                               : out std_logic_vector(15 downto 0);
        displays                          : out std_logic_vector(7 downto 0);
        segments                          : out std_logic_vector(7 downto 0)
    );
end top_fifo;

architecture Structural of top_fifo is

    signal display_value : std_logic_vector(31 downto 0);
    signal wr, rd : std_logic;
    signal dout : std_logic_vector(7 downto 0);
    signal count : std_logic_vector(4 downto 0);
begin

    /*
     * Connect FIFO to top design
     * Set DEPTH_WIDTH to log2(desired depth==16)
     * Set DATA_WIDTH to 8 bit
     * Connect din to SW
     * Connect dout to display 7seg displays
     * Use debouncers to control rd and wr
     * Connect empty and full to LEDs
     * Connect FIFO_count to 7 seg displays
     */

    FIFO_inst : entity work.FIFO
        generic map(
            C_FIFO_DEPTH_WIDTH => 4,
            C_FIFO_DATA_WIDTH  => 8
        )
        port map(
            clk   => clk,
            rst   => not rstn,
            din   => SW(7 downto 0),
            dout  => dout,
            wr    => wr,
            rd    => rd,
            empty => LED(15),
            full  => LED(14),
            count => count
        );

    rd_deb : entity work.debounce
        port map(
            clock   => clk,
            button  => btn_l,
            pressed => rd
        );
        wr_deb : entity work.debounce
        port map(
            clock   => clk,
            button  => btn_r,
            pressed => wr
        );

    -- display DIN, DOUT and COUNT on 7segment displays
    display_value <= SW(7 downto 0) & dout  & "00000000000" & count;

    display_driver_inst : entity work.display_driver
        port map(
            clock    => clk,
            reset    => not rstn,
            din      => display_value,
            segments => segments,
            displays => displays
        );

end Structural;
