library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LFSR is
    port (
        clock : in  std_logic;
        load  : in  std_logic;
        SW    : in  std_logic_vector(15 downto 0);
        LED   : out std_logic_vector(15 downto 0)
    );
end LFSR;

architecture Behavioral of LFSR is
signal reg : std_logic_vector(15 downto 0) := (others => '0');
begin
    process(clock)
        variable feedback : std_logic;
    begin
        if rising_edge(clock) then
            if load = '1' then
                reg <= SW;
            else
                feedback := reg(14) xor reg(13) xor reg(12) xor reg(11) xor reg(10) xor reg(9) xor reg(8) xor reg(7) xor reg(6) xor reg(5) xor reg(4) xor reg(3) xor reg(2) xor reg(1) xor reg(0);
                reg <= feedback & reg(15 downto 1);
            end if;
						LED <= reg;
        end if;
    end process;
end Behavioral;