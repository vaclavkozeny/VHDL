library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rxtx is
    port(
        clock          : in  std_logic;
        shift_not_load : in  std_logic;
        SW             : in  std_logic_vector(15 downto 0);
        LED            : out std_logic_vector(15 downto 0);
        tx             : out std_logic_vector(1 downto 0);
        rx             : in  std_logic_vector(1 downto 0)
    );
end rxtx;

    architecture Behavioral of rxtx is

begin
    DUT : entity work.shift_reg
        port map(
            clock          => clock,
            shift_not_load => shift_not_load,
            data_in        => SW(7 downto 0),
            data_out       => LED(7 downto 0),
            serial_in      => rx(0),
            serial_out     => tx(0)
        );
        DUT2 : entity work.shift_reg
        port map(
            clock          => clock,
            shift_not_load => shift_not_load,
            data_in        => SW(15 downto 8),
            data_out       => LED(15 downto 8),
            serial_in      => rx(1),
            serial_out     => tx(1)
        );
end Behavioral;
