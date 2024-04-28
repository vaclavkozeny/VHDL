library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity  LFSR_tb is
end  LFSR_tb;

architecture Behavioral of  LFSR_tb is

    signal clock   : std_logic := '0';
    constant CLK_P : time      := 10 ns;
	
	signal load  :  std_logic;
	signal SW    : std_logic_vector(15 downto 0);
	signal LED   : std_logic_vector(15 downto 0);

begin    
    dec1 : entity work.LFSR
    port map(
		clock => clock,
	  	load => load,
		SW => SW,
		LED => LED
    ); 
	clk : process
	begin
		clock <= '1';
		wait for CLK_P;
		clock <= '0';
		wait for CLK_P;
	end process;
	
	
    -- Proces pro øízení naèítání hodnoty SW
    stimulus_process: process
    begin
        wait for 10 ns; -- Èekání 10 ns pøed prvním naètením hodnoty SW
        load <= '1'; -- Aktivace signálu load
        SW <= "1000100000100001"; -- Nastavení hodnoty SW
        wait for 20 ns; -- Èekání 20 ns
        load <= '0'; -- Deaktivace signálu load
        wait; -- Konec simulace
    end process;


end Behavioral;