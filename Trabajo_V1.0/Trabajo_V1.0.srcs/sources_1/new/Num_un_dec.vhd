----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2018 18:56:03
-- Design Name: 
-- Module Name: Num_un_dec - Behavioral
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

entity Num_un_dec is
    generic (width: positive := 8);
    Port ( clk: in STD_LOGIC;
           numero : in STD_LOGIC_VECTOR(width-1 downto 0);
           unidades : out STD_LOGIC_VECTOR (3 downto 0);
           decenas : out STD_LOGIC_VECTOR (3 downto 0));
end Num_un_dec;

architecture Behavioral of Num_un_dec is
signal numero_int: integer range 0 to 99;
begin
numero_int<=to_integer(unsigned(numero));
process
begin 
decenas<=std_logic_vector(to_unsigned(numero_int/8,4));
unidades<=std_logic_vector(to_unsigned(numero_int mod 8,4));
end process;
end Behavioral;
