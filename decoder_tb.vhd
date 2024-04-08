library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_tb is
end decoder_tb;

architecture Behavioral of decoder_tb is

    signal dec_d : std_logic_vector(1 downto 0);
    signal dec_q : std_logic_vector(3 downto 0)

begin    
    dec1 : entity work.decoder
    port map(
        d => dec_d;
        q => dec_q;
    );
    -- insert decoder instance here
    -- best way to do is to copy entity declaration and modify it
    
    -- insert testbench control process here


end Behavioral;
