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

entity Divisor is
    GENERIC(frec: integer:= 10);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end Divisor;

architecture Behavioral of Divisor is
begin
PROCESS(clk, reset) is
variable cuenta:integer:= 0;
variable reloj:STD_LOGIC:='0';
begin
if reset='1' and reset'event then 
cuenta:=0;
end if;
if(clk'event and clk='1') then
    if(cuenta<frec-1) then
    cuenta:=cuenta+1; 
    else
     reloj:=not reloj;
     cuenta:=0;
    end if;        
end if;
clk_out<=reloj; 
end process;
end Behavioral;
