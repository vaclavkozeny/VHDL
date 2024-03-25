library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder is
    port (
        d : in std_logic_vector(1 downto 0);
        q : out std_logic_vector(3 downto 0)        
    );
end decoder;

architecture Behavioral of decoder is

begin
    with d select q <=
    "0001" when "00",
    "0010" when "01",
    "0100" when "10",
    "1000" when others;
end Behavioral;
