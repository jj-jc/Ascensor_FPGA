----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2018 12:02:02
-- Design Name: 
-- Module Name: Mostrar_tiempo - Behavioral
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

entity Mostrar_tiempo is
    generic(width: positive:=6);
    Port ( 
           CLR: in STD_LOGIC;
           CLK : in STD_LOGIC;
           UP : in STD_LOGIC;
           CE_N : in STD_LOGIC;
           LOAD_N: in std_logic;
           J : in STD_LOGIC_VECTOR (width-1 downto 0);
           display_number: out std_logic_vector (width-1 downto 0);--numero
           display_selection: out std_logic_vector (7 downto 0)--selección del display.
           );
end Mostrar_tiempo;
architecture Behavioral of Mostrar_tiempo is
COMPONENT counter IS
    Port(
        CLR: in std_logic;
        CLK : in std_logic;
        UP : in std_logic;
        CE_N : in std_logic;
        LOAD_N: in std_logic;
        J : in std_logic_vector (WIDTH - 1 downto 0);
        ZERO_N: out std_logic;
        Q : out std_logic_vector (WIDTH - 1 downto 0)
    );
END COMPONENT;
COMPONENT Decoder IS
    PORT (
         code : IN std_logic_vector(3 DOWNTO 0);
         led : OUT std_logic_vector(6 DOWNTO 0));
    END COMPONENT;
COMPONENT Display_refresh IS
    generic ( width: positive:=7 );
    Port(
    --SE UTILIZARA UN DIVISOR DE FRECUENCIA TENDRA QUE ESTAR ENTRE 1ms y 16ms
    --Este será de 1000Hz para tener 1ms 
    --Como la nexsys es de 100MHz hay que dividir entre 100000
    clk :in std_logic;
    reset:in std_logic;
    Segment_unid: in std_logic_vector (width-1 downto 0);--unidades
    --Segment_dec: in std_logic_vector (width-1 downto 0);--decenas
    display_number: out std_logic_vector (width-1 downto 0);--numero
    display_selection: out std_logic_vector (7 downto 0)--selección del display.
    );
   END COMPONENT;


Signal ZERO_N_INT: std_logic;
Signal Q_INT: std_logic_vector (width -1 downto 0);
Signal LED_INT: std_logic_vector(6 DOWNTO 0);

begin

cont: counter PORT MAP(
    CLR=>CLR,
    CLK=>CLK,
    UP=>UP,
    CE_N=>CE_N,
    LOAD_N=>LOAD_N,
    J=>J,
    ZERO_N=>ZERO_N_INT,
    Q=>Q_INT);
bcd: decoder PORT MAP(
    code=>Q_int,
    led=>Led_int
    );
Display: Display_refresh PORT MAP(
     clk=>clk,
     reset=>CLR,
     Segment_unid=>Led_int,
     display_number=>display_number,
     display_selection=>display_selection
     );
 end Behavioral;