----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2018 19:29:03
-- Design Name: 
-- Module Name: Contador_compuesto - Behavioral
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

entity Contador_compuesto is
generic (
    WIDTH: positive := 4);
    port (
        CLR : in std_logic;
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
end Contador_compuesto;

architecture Behavioral of Contador_compuesto is
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

Signal ZERO_N_unid_INT: std_logic;
Signal ZERO_N_dec_INT: std_logic;
Signal Load_int:std_logic;
Signal J_unid_in:std_logic_vector (WIDTH - 1 downto 0);

begin
count_unid: counter PORT MAP(
  CLR=>CLR,
  CLK=>CLK,
  UP=>UP,
  CE_N=>CE_N,
  LOAD_N=>load_int,
  J=>J_unid_in,
  ZERO_N=>ZERO_N_unid_INT,
  Q=>Q_unid
);
count_dece: counter PORT MAP(
  CLR=>CLR,
  CLK=>CLK,
  UP=>UP,
  CE_N=>ZERO_N_unid_INT,
  LOAD_N=>LOAD_N,
  J=>J_dec,
  ZERO_N=>ZERO_N_dec_INT,
  Q=>Q_dec
);
ZERO_N <= '0' when (ZERO_N_unid_INT ='0' and ZERO_N_dec_INT='0') 
              else '1';
process(clk)
begin
if(rising_edge(clk)) then
if (load_N='0') then
    load_int<='0'; 
    J_unid_in<=J_unid; 
elsif (ZERO_N_unid_INT='0' and ZERO_N_dec_INT='1' and load_int='1') then     
    J_unid_in<="1001";
    load_int<='0';--le cargamos un 9 para que vuelva a hacer la resta de las unidades
end if;
else load_int<='1';
end if;
end process;
end Behavioral;
