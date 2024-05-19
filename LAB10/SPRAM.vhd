----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.05.2024 08:05:58
-- Design Name: 
-- Module Name: SPRAM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SPRAM is
    generic(
        C_ADDR_WIDTH : integer := 8;
        C_DATA_WIDTH : integer := 8
    );
    port(
        clk  : in  std_logic;
        we   : in  std_logic;
        addr : in  std_logic_vector(C_ADDR_WIDTH - 1 downto 0);
        din  : in  std_logic_vector(C_DATA_WIDTH - 1 downto 0);
        dout : out std_logic_vector(C_DATA_WIDTH - 1 downto 0)
    );
end SPRAM;

architecture Behavioral of SPRAM is

    type spram_t is array (0 to (2 ** C_ADDR_WIDTH) - 1) of std_logic_vector(C_DATA_WIDTH - 1 downto 0);
    signal SinglePortRAM : spram_t := (others => (others => '0'));

begin

    process(clk)
    begin
        if rising_edge(clk) then
            -- read SinglePortRAM(addr) to dout
            dout <= SinglePortRAM(to_integer(unsigned(addr)));
            -- write din to SinglePortRAM(addr) when we
            if we then
                SinglePortRAM(to_integer(unsigned(addr))) <= din;
            end if;
            -- address (index) must be integer, perform necessary conversions
        end if;
    end process;
    

end Behavioral;
