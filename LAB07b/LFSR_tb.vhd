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
	
	
    tb: process
    begin
		SW <= "1110000000000000";
		wait for 10 ns;
		load <= '1';
		wait for 100 ns;
		load <= '0';
		wait for 1000 ns;
	end process;


end Behavioral;