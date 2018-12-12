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
    generic(width_t: positive:=10);
    Port ( 
           Reset: in STD_LOGIC;
           CLK : in STD_LOGIC;
           LOAD_N: in std_logic;
           J: in STD_LOGIC_VECTOR (width_t-1 downto 0);
           display_number: out std_logic_vector (6 downto 0);--numero
           display_selection: out std_logic_vector (7 downto 0);--selección del display.
           ZERO_N : out STD_LOGIC
           );
end Mostrar_tiempo;
architecture Behavioral of Mostrar_tiempo is
COMPONENT fdivider IS
      generic(module:positive);
      Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce_out : out STD_LOGIC);
END COMPONENT;
COMPONENT Num_un_dec IS
   generic (width: positive);
    Port ( clk:STD_LOGIC;    
          numero : in STD_LOGIC_VECTOR (width-1 downto 0);
          unidades : out STD_LOGIC_VECTOR (3 downto 0);
          decenas : out STD_LOGIC_VECTOR (3 downto 0));
 END COMPONENT;        
COMPONENT Contador_compuesto IS
    generic ( WIDTH: positive := 4);
    port ( CLR : in std_logic;
        CLK : in std_logic;
        UP : in std_logic;
        CE_N : in std_logic;
        LOAD_N: in std_logic;
        J_dec: in std_logic_vector (WIDTH - 1 downto 0);
        J_unid: in std_logic_vector (WIDTH - 1 downto 0);
        ZERO_N: out std_logic;
        Q_unid : out std_logic_vector (WIDTH - 1 downto 0);
        Q_dec : out std_logic_vector (WIDTH - 1 downto 0)       
);
END COMPONENT;
COMPONENT Decoder IS
    Port(code : IN std_logic_vector(3 DOWNTO 0);
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
Segment_dec: in std_logic_vector (width-1 downto 0);--decenas
display_number: out std_logic_vector (width-1 downto 0);--numero
display_selection: out std_logic_vector (7 downto 0)--selección del display.
);
END COMPONENT;
SIGNAL clk_1s:std_logic;
SIGNAL clk_1ms:std_logic;
SIGNAL unidades:std_logic_vector (3 downto 0);
SIGNAL decenas:std_logic_vector (3 downto 0);
SIGNAL Q_unidades:std_logic_vector (3 downto 0);
SIGNAL Q_decenas:std_logic_vector (3 downto 0);
SIGNAL BCD_unidades:std_logic_vector (6 downto 0);
SIGNAL BCD_decenas:std_logic_vector (6 downto 0);
begin
 clk1s: fdivider 
        GENERIC MAP( module=>10000000)
        PORT MAP(
            clk=>clk,
            reset=>reset,
            ce_out=>clk_1s);
 clk1ms: fdivider 
        GENERIC MAP( module=>100000)
        PORT MAP(
             clk=>clk,
             reset=>reset,
             ce_out=>clk_1ms);           
 cont: Contador_compuesto
        PORT MAP(
            CLR=>reset,
            CLK=>clk_1s,
            UP=>'0',
            CE_N=>'0',
            LOAD_N=>LOAD_N,
            J_dec=>decenas,
            J_unid=>unidades,
            ZERO_N=>ZERO_N,
            Q_unid=>Q_unidades,
            Q_dec=>Q_decenas);      
  nd:Num_un_dec 
        GENERIC MAP(width=>8)
        PORT MAP(
            clk=>clk,
            numero=>J,
            unidades=>unidades,
            decenas=>decenas);
 decunid:Decoder
        PORT MAP(
            code=>Q_unidades,
            led=>BCD_unidades);
 decdec:Decoder
       PORT MAP(
           code=>Q_decenas,
           led=>BCD_decenas);
 display:Display_refresh
        PORT MAP(
            clk=>clk_1ms,
            segment_unid=>BCD_unidades,
            segment_dec=>BCD_decenas,
            reset=>reset,
            display_number=>display_number,
            display_selection=>display_selection);                   
 end Behavioral;