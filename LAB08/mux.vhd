library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    port (
        d : in std_logic_vector(31 downto 0);
        s : in std_logic_vector(2 downto 0);
        q : out std_logic_vector(3 downto 0)
    );
end mux;

architecture Behavioral of mux is

begin

    process(s,d)
    begin
        case s is
        when "000" =>
            q <= d(3 downto 0);
        when "001" =>
            q <= d(7 downto 4);
        when "010" =>
            q <= d(11 downto 8);
        when "011" =>
            q <= d(15 downto 12);
        when "100" =>
            q <= d(19 downto 16);
        when "101" =>
            q <= d(23 downto 20);
        when "110" =>
            q <= d(27 downto 24);
        when others =>
            q <= d(31 downto 28);
    end case;
    end process;

end Behavioral;