----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.11.2018 12:56:54
-- Design Name: 
-- Module Name: practica3_1_tb - Behavioral
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
entity MaquinaDeEstados_tb is
--  Port ( );
end MaquinaDeEstados_tb;

architecture Behavioral of MaquinaDeEstados_tb is
COMPONENT MaquinaDeEstados IS 
 Port(
       Reset, Clk, Corto, Largo, Encendido : IN STD_LOGIC;
       Bomba_Led, Indica_On : OUT STD_LOGIC;
       Estado_out: out STD_LOGIC_VECTOR(0 to 1)
   );
END COMPONENT;
SIGNAL Reset_tb: STD_LOGIC;
SIGNAL Clk_tb:STD_LOGIC:= '0';
SIGNAL Corto_tb:STD_LOGIC;
SIGNAL Largo_tb:STD_LOGIC;
SIGNAL Encendido_tb:STD_LOGIC;
SIGNAL Bomba_Led_tb:STD_LOGIC;
SIGNAL Indica_On_tb:STD_LOGIC;
SIGNAL Estado_out_tb:STD_LOGIC_VECTOR(0 TO 1);
TYPE Maq_test is record
    --El estado anterior queda representado por, 00=S0, 01=S1, 10=S2,11=S3 (Es una pseudoentrada)
    Reset: STD_LOGIC;    
    Corto:STD_LOGIC;
    Largo:STD_LOGIC;
    Encendido:STD_LOGIC;
    Bomba_Led:STD_LOGIC;
    Indica_On:STD_LOGIC;
    Estado: STD_LOGIC_VECTOR(0 TO 1);
END RECORD;
TYPE Maq_test_vector IS ARRAY (natural RANGE <>) OF Maq_test;
CONSTANT test: Maq_test_vector:=(
(Estado=>"00", Reset=>'-',Corto=>'-',Largo=>'-',Encendido=>'0',Bomba_Led=>'0',Indica_On =>'0'),--S0
(Estado=>"01", Reset=>'0',Corto=>'0',Largo=>'0',Encendido=>'1',Bomba_Led=>'0',Indica_On =>'1'),--Cambia a S1
(Estado=>"11", Reset=>'0',Corto=>'0',Largo=>'1',Encendido=>'1',Bomba_Led=>'1',Indica_On =>'1'),--Cambia a Largo
(Estado=>"01", Reset=>'1',Corto=>'-',Largo=>'-',Encendido=>'1',Bomba_Led=>'0',Indica_On =>'1'),
(Estado=>"10", Reset=>'0',Corto=>'1',Largo=>'-',Encendido=>'1',Bomba_Led=>'1',Indica_On =>'1'),
(Estado=>"01", Reset=>'1',Corto=>'-',Largo=>'-',Encendido=>'1',Bomba_Led=>'0',Indica_On =>'1'),
(Estado=>"00", Reset=>'-',Corto=>'-',Largo=>'-',Encendido=>'0',Bomba_Led=>'0',Indica_On =>'0')
);
BEGIN
unidad1: MaquinaDeEstados PORT MAP(
    Reset=>Reset_tb,
    Corto=>Corto_tb,
    Largo=>Largo_tb,
    Clk=>Clk_tb,
    Encendido=>Encendido_tb,
    Bomba_Led=>Bomba_Led_tb,
    Indica_On=>Indica_On_tb, 
    Estado_out=>Estado_out_tb   
);
Clk_tb <= not Clk_tb after 10 ns;
tb: PROCESS IS
BEGIN
FOR i IN 0 TO test'HIGH LOOP
    Reset_tb<=test(i).Reset;
    Corto_tb<=test(i).Corto;   
    Largo_tb<=test(i).Largo;
    Encendido_tb<=test(i).Encendido;
    WAIT FOR 20 ns;
    ASSERT ((Bomba_Led_tb=test(i).Bomba_Led) and (Indica_On_tb=test(i).Indica_On)and (Estado_out_tb=test(i).Estado)) 
    REPORT "Salida incorrecta."
    SEVERITY FAILURE;    
END LOOP;
ASSERT false
REPORT "Simulacion finalizada. Test superado."
SEVERITY FAILURE;
END PROCESS;
END BEHAVIORAL;