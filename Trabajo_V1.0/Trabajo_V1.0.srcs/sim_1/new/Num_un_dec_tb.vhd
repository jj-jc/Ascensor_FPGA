----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2018 19:09:53
-- Design Name: 
-- Module Name: Num_un_dec_tb - Behavioral
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

entity Num_un_dec_tb is
--  Port ( );
end Num_un_dec_tb;

architecture Behavioral of Num_un_dec_tb is
COMPONENT Num_un_dec IS
    generic (WIDTH: positive := 10);
    Port ( clk:STD_LOGIC;
           numero : in STD_LOGIC_VECTOR (width-1 downto 0);
           unidades : out STD_LOGIC_VECTOR (3 downto 0);
           decenas : out STD_LOGIC_VECTOR (3 downto 0)
           );
end COMPONENT;
SIGNAL clk_tb:STD_LOGIC:='0';
SIGNAL numero_tb:STD_LOGIC_VECTOR (9 downto 0);
SIGNAL unidades_tb:STD_LOGIC_VECTOR (3 downto 0);
SIGNAL decenas_tb:STD_LOGIC_VECTOR (3 downto 0);
begin
u_d: Num_un_dec PORT MAP( 
    clk=>clk_tb,
    numero=>numero_tb,
    unidades=>unidades_tb,
    decenas=>decenas_tb);
clk_tb<=not clk_tb after 5 ns;  
numero_tb<="0000101101" after 10 ns , "0001100011" after 50 ns;


end Behavioral;
