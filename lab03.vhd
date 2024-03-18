library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity lab03 is
  port
  (
    a, b, c, d : in std_logic;
    -- a      : in std_logic;
    -- b      : in std_logic;
    -- c      : in std_logic;

    q_inv : out std_logic;
    -- q_log0 : out std_logic;
    -- q_log1 : out std_logic;
    q_log0, q_log1 : out std_logic;

    q_and  : out std_logic;
    q_or   : out std_logic;
    q_xor  : out std_logic;
    q_xnor : out std_logic;
    q_nand : out std_logic;
    q_nor  : out std_logic;
    q_vote : out std_logic;

  );
end lab03;

architecture structural of lab03 is

  signal invertor                       : std_logic;
  signal pterm0, pterm1, pterm2, pterm3 : std_logic;

begin

  invertor <= not a;
  q_inv    <= invertor;
  q_log0   <= '0';
  q_log1   <= '1';
  q_and    <= a and b and c;
  q_or     <= a or b or c;
  q_xor    <= a xor b xor c;
  q_xnor   <= a xnor b xnor c;
  q_nand   <= not(a and b and c);
  q_nor    <= not(a or b or c);

  pterm0 <= a and c;
  pterm1 <= a and b;
  pterm2 <= a and d;
  pterm3 <= b and c and d;
  q_vote <= pterm0 or pterm1 or pterm2 or pterm3;

end structural;