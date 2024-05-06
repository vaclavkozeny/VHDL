-------------------------------------------------------------------------------
--
-- Title       : komplet
-- Design      : ukol
-- Author      : vaclav.kozeny@tul.cz
-- Company     : Technical University in Liberec
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;



entity komplet is  
	port(
	clock : in std_logic;
	din : in std_logic_vector(31 downto 0);
	rst : in std_logic;
	segments : out std_logic_vector(7 downto 0);
	displays : out std_logic_vector(7 downto 0)
	);
end komplet;



architecture Behavioral of komplet is 
signal sel : std_logic_vector(2 downto 0);
signal done : std_logic;
signal  div10kHz_done : std_logic;
signal done_7 : std_logic; 

signal zmux : std_logic_vector(3 downto 0);
signal zcnt : std_logic_vector(2 downto 0);

signal interseg : std_logic_vector(7 downto 0);
signal interdis : std_logic_vector(7 downto 0);

constant DIV10kHZ_WIDTH : integer := 14;
constant DIV10kHZ_LIMIT : integer := 9999;
constant DIV7_WIDTH : integer := 3;
constant DIV7_LIMIT : integer := 7;


begin

	clock_div : entity work.counter
        generic map(
            COUNTER_WIDTH => DIV10kHZ_WIDTH
        )
        port map(
            clock        => clock,
            cnt          => open,
            reset        => rst,
            clock_enable => '1',
            limit        => std_logic_vector(to_unsigned(DIV10kHZ_LIMIT, DIV10kHZ_WIDTH)),
            repeat       => '1',
            done         => div10kHz_done
        );
	citac07 : entity work.counter
		  generic map(
            COUNTER_WIDTH => 3
        )
        port map(
            clock        => clock,
            cnt          => zcnt,
            reset        => rst,
            clock_enable => div10kHz_done,
            limit        => std_logic_vector(to_unsigned(DIV7_WIDTH, DIV7_LIMIT)),
            repeat       => '1',
            done         =>  done_7
        );
	mux32 : entity work.mux
		port map(
		d => din,
		s => zcnt,
		q => zmux
		);
	decseg : entity work.dec7seg
		port map(
		char_in => zmux,
		seg_out	=> interseg
		);
	dec8 : entity work.dec1z8
		port map( 
		disp_sel => zcnt,
		displays => interdis
		); 
	process(clock)
	begin 
    if(rising_edge(clock)) then
   		displays <= interdis;
    end if;       
 	end process;
	 process(clock)
	begin 
    if(rising_edge(clock)) then
   		segments <= interseg;
    end if;       
 	end process;


end Behavioral;
