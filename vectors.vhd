library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vectors is
    Port (
        switches : in std_logic_vector(15 downto 0);
        LEDs : out std_logic_vector(15 downto 0)
    );
end vectors;

architecture Behavioral of vectors is

begin
LEDs(1 downto 0) <= (others => '0');
LEDs(3 downto 2) <= (others => '1');
LEDs(7 downto 4) <= switches(3 downto 0);
-- LEDs(15 downto 8) <= "00000011" when switches(4) = '1';
LEDs(15 downto 8) <= switches(15) & switches(15) & switches(14) & switches(14) & switches(13) & switches(13) & switches(12) & switches(12);

end Behavioral;
