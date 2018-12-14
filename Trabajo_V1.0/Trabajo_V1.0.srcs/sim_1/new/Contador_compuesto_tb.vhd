----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2018 23:08:43
-- Design Name: 
-- Module Name: Contador_compuesto_tb - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Contador_compuesto_tb is

end Contador_compuesto_tb;

architecture Behavioral of Contador_compuesto_tb is
COMPONENT  Contador_compuesto is
generic ( WIDTH: positive := 4);
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
        Q_dec : out std_logic_vector (WIDTH - 1 downto 0));
END COMPONENT;
    constant width : positive:=4 ;
    signal CLR_tb:  std_logic;                                 
    signal CLK_tb:  std_logic:='0';                                 
    signal UP_tb:  std_logic;                                  
    signal CE_N_tb: std_logic;                                
    signal LOAD_N_tb: std_logic;                               
    signal J_dec_tb: std_logic_vector (WIDTH - 1 downto 0);    
    signal J_unid_tb: std_logic_vector (WIDTH - 1 downto 0);
    signal ZERO_N_tb: std_logic;                              
    signal Q_unid_tb :  std_logic_vector (WIDTH - 1 downto 0); 
    signal Q_dec_tb : std_logic_vector (WIDTH - 1 downto 0);

begin
contador: Contador_compuesto 
PORT MAP(
    CLR =>clr_tb,
    clk =>clk_tb,
    UP => up_tb,
    CE_N =>CE_N_tb,
    LOAD_N =>LOAD_N_tb,
    J_dec =>J_dec_tb,
    J_unid =>J_unid_tb,
    ZERO_N =>ZERO_N_tb,
    Q_unid =>Q_unid_tb,
    Q_dec => Q_dec_tb
);
clk_tb <= not clk_tb after 10 ns;
clr_tb<='1', '0' after 5 ns;
ce_n_tb<='0';
Up_tb<='0';
j_unid_tb<="0111" after 10ns;
j_dec_tb<="0011" after 10ns;
load_n_tb<='0','1' after 200ns;

end behavioral;














