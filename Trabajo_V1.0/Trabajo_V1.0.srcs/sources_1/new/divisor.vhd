----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2018 16:36:56
-- Design Name: 
-- Module Name: divisor - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fdivider is
generic (
MODULE: positive := 100000
);
port (
RESET : in std_logic;
CLK : in std_logic;
CE_OUT: out std_logic
);
end fdivider;

architecture behavioral of fdivider is
begin
process (RESET, CLK)
subtype count_range is integer range 0 to
module - 1;
variable count: count_range;
begin
if RESET = '1' then
count := count_range'high;
CE_OUT <= '0';
elsif rising_edge(CLK) then
CE_OUT <= '0';
if count /= 0 then
count := count - 1;
else
CE_OUT <= '1';
count := count_range'high;
end if;
end if;
end process;
end behavioral;