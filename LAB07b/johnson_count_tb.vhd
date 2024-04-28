library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity  johnson_count_tb is
end  johnson_count_tb;

architecture Behavioral of  johnson_count_tb is

    signal clock   : std_logic := '0';
    constant CLK_P : time      := 10 ns;
	
	signal reset     :  std_logic;
	signal q_johnson :  std_logic_vector(3 downto 0); 
	signal q_binary  :  std_logic_vector(2 downto 0);

begin    
    dec1 : entity work. johnson_count
    port map(
		clock => clock,
	  	reset => reset,
		q_johnson => q_johnson,
		q_binary => q_binary
    );
    tb: process
    begin
	wait for 100 ns;
	reset <= '1';
	end process;


end Behavioral;
