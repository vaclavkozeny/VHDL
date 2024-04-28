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
signal reg : std_logic_vector(15 downto 0);
signal feedback : std_logic;
begin
	process(clock)
	begin
	if rising_edge(clock) then
		if load = '1' then
			reg <= SW;
		else
			reg <= '0' & reg(15 downto 1); 
		
			feedback <= reg(0);
			for i in 1 to 15 loop
				feedback <= feedback xor reg(i);
			end loop;
		
			reg(15) <= reg(0);
		end if;
	end if;
	LED <= reg;
	end process;

end Behavioral;