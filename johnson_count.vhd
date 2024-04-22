library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity johnson_count is
    port (
        clock     : in  std_logic;
        reset     : in  std_logic;
        q_johnson : out std_logic_vector(3 downto 0);
         -- change 999 to correct value 
        q_binary  : out std_logic_vector(2 downto 0)
    );
end johnson_count;

architecture Behavioral of johnson_count is

begin

-- J.state  row     binary
-- 0000     0
process(clock)
begin
    if rising_edge(clock) then
        if reset = '1' then
            q_johnson <= (others => '0');
        else
            q_johnson <= not(q_johnson(0)) & q_johnson(3 downto 1);
        end if;
    end if;
end process;
process(q_johnson)
begin
    with q_johnson select q_binary <=
        "000" when "0000",
        "001" when "1000",
        "010" when "1100",
        "011" when "1110",
        "100" when "1111",
        "101" when "0111",
        "110" when "0011",
        "111" when "0001";
end process;          


end Behavioral;
