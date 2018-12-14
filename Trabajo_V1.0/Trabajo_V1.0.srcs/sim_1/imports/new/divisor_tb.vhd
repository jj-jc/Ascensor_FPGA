----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2018 17:13:43
-- Design Name: 
-- Module Name: divisor_tb - Behavioral
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

entity divisor_tb is
--  Port ( );
end divisor_tb;

architecture Behavioral of divisor_tb is
COMPONENT fdivider IS
     Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce_out : out STD_LOGIC);
END COMPONENT;
SIGNAL clk_int:STD_LOGIC:='0';
SIGNAL reset_int,clk_out_int: STD_LOGIC;
begin
div: fdivider PORT MAP(
clk=>clk_int,
reset=>reset_int,
ce_out=>clk_out_int);
reset_int<='0';
clk_int<=not clk_int after 10 ns;
end Behavioral;
