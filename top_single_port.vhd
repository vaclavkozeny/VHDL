library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_single_port is
    port(
        clk                               : in  std_logic;
        rstn                              : in  std_logic;
        btn_u, btn_r, btn_d, btn_l, btn_c : in  std_logic;
        SW                                : in  std_logic_vector(15 downto 0);
        LED                               : out std_logic_vector(15 downto 0);
        displays                          : out std_logic_vector(7 downto 0);
        segments                          : out std_logic_vector(7 downto 0)
    );
end top_single_port;

architecture Structural of top_single_port is
    signal we : std_logic;
    signal dout : std_logic_vector(7 downto 0);
    signal display_value : std_logic_vector(31 downto 0);

begin

    /*
     * TASK 1:
     * add SPRAM entity inst.
     * 8bit ADDR, 4bit DIN
     * Feed ADDR, DIN from SWitches
     * connect port WE from debouncer
     */


    SPRAM_inst : entity work.SPRAM
        generic map(
            C_ADDR_WIDTH => 8,
            C_DATA_WIDTH => 8
        )
        port map(
            clk  => clk,
            we   => we,
            addr => SW(15 downto 8),
            din  => SW(7 downto 0),
            dout => dout
        );

    debounce_we : entity work.debounce
        port map(
            clock   => clk,
            button  => btn_u,           -- connect to any button of choice
            pressed => we            -- conenct to we port of SPRAM
        );

    -- connect ADDR, DIN, DOUT to 7segment displays. Each display is fed with 4bit value.
    --display_value <= X"DEADBEEF";
    display_value <= SW(15 downto 8) & SW(7 downto 0) & dout & X"00";


    display_driver_inst : entity work.display_driver
        port map(
            clock    => clk,
            reset    => not rstn,
            din      => display_value,
            segments => segments,
            displays => displays
        );

end Structural;
