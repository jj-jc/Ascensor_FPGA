----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2018 23:05:48
-- Design Name: 
-- Module Name: Display_refresh - Behavioral
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

entity Display_refresh is
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
    display_selection: out std_logic_vector (7 downto 0)--selección del display.
    );
end Display_refresh;

architecture Behavioral of Display_refresh is
SIGNAL reloj:STD_LOGIC;
--signal S_display_selection: std_logic_vector (3 downto 0):="0001";
signal display_actual: unsigned(1 downto 0):="00";
signal decenas:std_logic_vector(6 downto 0):="1001100";
--signal unidades:std_logic_vector(6 downto 0):="0010010";
begin
--display_selection <= S_display_selection;
  process(clk,reset)--capturamos los flancos y aumentamos en uno el display --Falta reset
    begin   
    if reset= '1' then
        display_selection <= (others =>'1');
        display_actual<="00";
        display_number<="1111110";        
    elsif (clk'event and clk='1') then
    if display_actual ="00" then 
               display_selection <= "11111110";
    --              --display_number <= Segment_unid;
                 display_number <= segment_unid;
     elsif display_actual ="01" then 
                display_selection <= "11111101";
     --              --display_number <= Segment_unid;
                  display_number <= decenas;
     else 
                display_selection <= "11110111";
                display_number <= (others =>'1');
     end if;                
     display_actual <= display_actual + 1;
    end if;    
  end process;
end behavioral;
