library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplexor is
    Port(
        /*a           : in  std_logic;
        b           : in  std_logic;
        sel         : in  std_logic;
        q_struct    : out std_logic;
        q_condition : out std_logic*/
        d : in std_logic_vector(7 downto 0);
        s : in std_logic_vector(2 downto 0);
        q : out std_logic
    );
end multiplexor;

architecture Behavioral of multiplexor is

begin
    /*q_condition <= a when sel = '0'
    else b when sel = '1'
    else '0';
    
    q_struct <= (a and not(sel)) or (b and sel);*/
    q <= d(0) when s = "000" 
    else d(1) when s = "001"
    else d(2) when s = "010"
    else d(3) when s = "011"
    else d(4) when s = "100"
    else d(5) when s = "101"
    else d(6) when s = "110"
    else d(7) when s = "111";
end Behavioral;
