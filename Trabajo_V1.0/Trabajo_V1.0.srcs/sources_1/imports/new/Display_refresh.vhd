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
    display_selection: out std_logic_vector (3 downto 0)--selección del display.  
);
end Display_refresh;

architecture Behavioral of Display_refresh is
SIGNAL reloj:STD_LOGIC;
--signal S_display_selection: std_logic_vector (3 downto 0):="0001";
signal display_actual: unsigned(1 downto 0):="00";
COMPONENT divisor IS
Port (     clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC);
END COMPONENT;

begin
div: divisor PORT MAP(
clk=>clk,
reset=>reset,
clk_out=>reloj
);
--display_selection <= S_display_selection;
  process(reloj, reset)--capturamos los flancos y aumentamos en uno el display
    begin
    if reset= '1' then
        display_selection <= (others =>'0');
    elsif (reloj'event and reloj='1') then
        display_actual <= display_actual + 1;
        case display_actual is 
              when "00"=>
              display_selection <= "0001";
              display_number <= Segment_unid;
              when "01"=>
              display_selection <= "0010";
              display_number <= Segment_dec;
              when "10"=>
              display_selection <= "0100";
              display_number <= (others =>'0');
              when "11"=>
              display_selection <= "1000";
              display_number <= (others =>'0');
              when others=> 
              display_selection<= "0001";
              end case;
    end if;   
  end process;
end behavioral;
