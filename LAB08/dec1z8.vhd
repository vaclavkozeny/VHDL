  library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec1z8 is
    Port(
        disp_sel : in  std_logic_vector(2 downto 0);
        displays : out std_logic_vector(7 downto 0)
    );
end dec1z8;

architecture Behavioral of dec1z8 is

begin
    with disp_sel select displays <=
    "11111110" when "000",
    "11111101" when "001",
    "11111011" when "010",
    "11110111" when "011",
    "11101111" when "100",
    "11011111" when "101",
    "10111111" when "110",
    "01111111" when others;
end Behavioral;
