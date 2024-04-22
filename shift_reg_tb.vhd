library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg_tb is
end shift_reg_tb;

architecture Behavioral of shift_reg_tb is
    signal clock   : std_logic := '0';
    constant CLK_P : time      := 10 ns;

    signal shift_not_load : std_logic                    := '1';
    signal data_in        : std_logic_vector(7 downto 0) := (others => '0');
    signal serial_in      : std_logic                    := '0';

    signal data_out   : std_logic_vector(7 downto 0);
    signal serial_out : std_logic;

begin

    -- free running clock with CLK_P period
    clock <= not clock after CLK_P / 2;

    DUT : entity work.shift_reg
        port map(
            clock          => clock,
            shift_not_load => shift_not_load,
            data_in        => data_in,
            data_out       => data_out,
            serial_in      => serial_in,
            serial_out     => serial_out
        );

    data : process
    begin
        shift_not_load <= '0';
        data_in <= (others => '0');
        wait for 10 ns;

        shift_not_load <= '1';
        wait for 10 ns;
        serial_in <= '1';
        wait for 10 ns;
        serial_in <= '0';
        wait for 10 ns;
        serial_in <= '0';
        wait for 10 ns;
        serial_in <= '0';
        wait for 10 ns;
        serial_in <= '0';
        wait for 10 ns;
        serial_in <= '0';
        wait for 10 ns;
        serial_in <= '0';
        wait for 10 ns;
        serial_in <= '0';
        wait for 10 ns;
    end process;
end Behavioral;
