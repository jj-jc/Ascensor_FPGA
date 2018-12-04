----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.12.2018 11:05:06
-- Design Name: 
-- Module Name: Display_refresh_tb - Behavioral
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

entity Display_refresh_tb is
--  Port ( );
end Display_refresh_tb;

architecture Behavioral of Display_refresh_tb is
COMPONENT Display_refresh IS
generic ( width: positive:=7 );
Port(
--SE UTILIZARA UN DIVISOR DE FRECUENCIA TENDRA QUE ESTAR ENTRE 1ms y 16ms
--Este será de 1000Hz para tener 1ms 
--Como la nexsys es de 100MHz hay que dividir entre 100000
clk :in std_logic;
reset:in std_logic;
Segment_unid: in std_logic_vector (width-1 downto 0);--unidades
Segment_dec: in std_logic_vector (width-1 downto 0);--decenas
display_number: out std_logic_vector (width-1 downto 0);--numero
display_selection: out std_logic_vector (3 downto 0)--selección del display.
);
END COMPONENT;
constant width : positive:= 7;
SIGNAL clk_tb:std_logic:='0';
SIGNAL reset_tb:std_logic;
SIGNAL Segment_unid_tb: std_logic_vector (width-1 downto 0);--unidades
SIGNAL Segment_dec_tb: std_logic_vector (width-1 downto 0);--decenas
SIGNAL display_number_tb: std_logic_vector (width-1 downto 0);--numero
SIGNAL display_selection_tb: std_logic_vector (3 downto 0);--selección del display.
BEGIN
unidad1: Display_refresh PORT MAP(
    clk =>clk_tb,
    reset=>reset_tb,
    Segment_unid=>Segment_unid_tb,
    Segment_dec=>Segment_dec_tb,
    display_number=>display_number_tb,
    display_selection=>display_selection_tb
);
clk_tb <=not clk_tb after 10 ns;
reset_tb<='1', '0' after 50 ns;
Segment_unid_tb<="1001111";
Segment_dec_tb<="0100000";
end Behavioral;
