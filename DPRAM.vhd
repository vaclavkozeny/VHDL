library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DPRAM is
    generic(
        C_ADDR_WIDTH : integer := 8;
        C_DATA_WIDTH : integer := 8
    );
    port(
        clka  : in  std_logic;
        wea   : in  std_logic;
        addra : in  std_logic_vector(C_ADDR_WIDTH - 1 downto 0);
        dina  : in  std_logic_vector(C_DATA_WIDTH - 1 downto 0);
        douta : out std_logic_vector(C_DATA_WIDTH - 1 downto 0);
        clkb  : in  std_logic;
        web   : in  std_logic;
        addrb : in  std_logic_vector(C_ADDR_WIDTH - 1 downto 0);
        dinb  : in  std_logic_vector(C_DATA_WIDTH - 1 downto 0);
        doutb : out std_logic_vector(C_DATA_WIDTH - 1 downto 0)
    );
end DPRAM;

architecture Behavioral of DPRAM is

    type spram_t is array (0 to (2 ** C_ADDR_WIDTH) - 1) of std_logic_vector(C_DATA_WIDTH - 1 downto 0);
    -- shared variable is VHDL dirty trick to implement dual port ram
    shared variable DualPortRAM : spram_t := (others => (others => '0'));

begin

    process(clka)
    begin
        if rising_edge(clka) then
            -- implement the first port (as you did in single port RAM example)
            douta <= DualPortRAM(to_integer(unsigned(addra)));
            -- use := instead of <=, since the DualPortRAM is variable
            if wea then
                DualPortRAM(to_integer(unsigned(addra))) := dina;
            end if;
        end if;
    end process;

    process(clkb)
    begin
        if rising_edge(clkb) then
            -- implement the first port (as you did in single port RAM example)
            doutb <= DualPortRAM(to_integer(unsigned(addrb)));
            -- use := instead of <=, since the DualPortRAM is variable
            if web then
                DualPortRAM(to_integer(unsigned(addrb))) := dinb;
            end if;
        end if;
    end process;

end Behavioral;
