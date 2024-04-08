library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplexor_tb is
end multiplexor_tb;

architecture testbench of multiplexor_tb is
    
    signal mux_d : std_logic_vector(3 downto 0);
    signal mux_s : std_logic_vector(1 downto 0);
    signal mux_q : std_logic;
    
begin

    mux1 : entity work.multiplexor
        port map(
            d => mux_d,
            s => mux_s,
            q => mux_q
        );
    
    process
    begin
        mux_s <= "00";
        mux_d <= "0000";
        wait for 10 ns; 
        mux_d <= "0001";
        wait for 10 ns;
        /*---------------*/
        mux_s <= "01";
        mux_d <= "0001";
        wait for 10 ns; 
        mux_d <= "0010";
        wait for 10 ns;
        /*--------------*/
        mux_s <= "10";
        mux_d <= "0010";
        wait for 10 ns;
        mux_d <= "0100";
        wait for 10 ns;
        /*--------------------*/
        mux_s <= "11";
        mux_d <= "0100";
        wait for 10 ns;
        mux_d <= "1000";
        wait for 10 ns;

        
    end process;
    

end testbench;
