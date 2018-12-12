----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2018 11:47:40
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
generic (
WIDTH: positive := 4
);
port (
CLR : in std_logic;
CLK : in std_logic;
UP : in std_logic;
CE_N : in std_logic;
LOAD_N: in std_logic;
J : in std_logic_vector (WIDTH - 1 downto 0);
ZERO_N: out std_logic;
Q : out std_logic_vector (WIDTH - 1 downto 0)
);
end counter;

architecture behavioral of counter is
signal q_i: unsigned(Q'range);
begin
process (CLR, CLK, LOAD_N, J)
    begin
        if CLR = '1' then
            q_i <= (others => '0');
    elsif LOAD_N = '0' then
        q_i <= unsigned(J);
    elsif rising_edge(CLK) then
    if CE_N = '0' then
    if UP = '1' then
        q_i <= q_i + 1;
    else
         q_i <= q_i - 1;
    end if;
    end if;
    end if;
    end process;
    Q <= std_logic_vector(q_i);
    ZERO_N <= '0' when q_i = 0 else '1';
end behavioral;


