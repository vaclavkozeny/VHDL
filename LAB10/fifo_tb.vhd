library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FIFO_tb is
end FIFO_tb;

architecture Behavioral of FIFO_tb is

    constant C_FIFO_DEPTH_WIDTH : integer := 4;
    constant C_FIFO_DATA_WIDTH  : integer := 8;

    constant CLK_P : time      := 10 ns;
    signal clk     : std_logic := '0';
    
    -- inputs
    signal rst     : std_logic;
    signal din     : std_logic_vector(C_FIFO_DATA_WIDTH - 1 downto 0);
    signal wr      : std_logic;
    signal rd      : std_logic;

    -- outputs
    signal dout    : std_logic_vector(C_FIFO_DATA_WIDTH - 1 downto 0);
    signal empty   : std_logic;
    signal full    : std_logic;
    signal count   : std_logic_vector(C_FIFO_DEPTH_WIDTH downto 0);

begin

    clk <= not clk after CLK_P / 2;

    DUT : entity work.FIFO
        generic map(
            C_FIFO_DEPTH_WIDTH => C_FIFO_DEPTH_WIDTH,
            C_FIFO_DATA_WIDTH  => C_FIFO_DATA_WIDTH
        )
        port map(
            clk   => clk,
            rst   => rst,
            din   => din,
            dout  => dout,
            wr    => wr,
            rd    => rd,
            empty => empty,
            full  => full,
            count => count
        );
        
    -- TEST FIFO 
    tb: process
    begin
		din<="11111111"; 
		wait for 10 ns;
		wr<='1'; 
		wait for 10 ns;
		rd <= '1';
		wait for 10 ns;
		din<="10001111"; 
		wait for 10 ns;
		wr<='1'; 
		wait for 10 ns;
		rd <= '1';
		wait for 10 ns;
	end process;

end Behavioral;