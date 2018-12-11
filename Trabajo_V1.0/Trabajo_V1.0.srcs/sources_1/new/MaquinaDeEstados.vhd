----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MaquinaDeEstados is
    Port(
        Reset, Clk, Corto, Largo, Encendido : in std_logic;
        Bomba_Led, Indica_On : out std_logic;
        Estado_out: out std_logic_vector(0 to 1)
    );
end MaquinaDeEstados;

architecture Behavioral of MaquinaDeEstados is
    type estado is (S0_OFF, S1_ON, S2_CORTO, S3_LARGO);
    signal state_register: estado;
    signal next_state: estado;
    
    begin
            Inicio: process(Clk)
            begin
            if rising_edge(Clk) then
            state_register <= next_state;
            end if;
   end process;
    
            Siguiente_Estado: process(state_register, Corto, Largo, Encendido)
            begin
            next_state<=state_register;
            case state_register is 
                when S0_OFF=>
                    if Encendido = '1' then
                        next_state <= S1_ON;
                    end if;
                when S1_ON=> 
                    if Encendido = '0' then 
                        next_state <= S0_OFF;
                    elsif Corto= '1' then 
                        next_state <= S2_CORTO;
                    elsif Largo = '1' then 
                        next_state <= S3_LARGO;
                    end if;
                when S2_CORTO=>
                    if Reset = '1' then 
                        next_state <=S1_ON;
                    elsif Encendido='0' then 
                        next_state <=S0_OFF;
                    end if;                      
                when S3_LARGO=>
                     if Reset = '1' then 
                         next_state <=S1_ON;
                     elsif Encendido='0' then 
                         next_state <=S0_OFF;
                     end if;
                when others=>
                    next_state<=S0_OFF; 
        end case;
   end process;
   
   salidas:process(state_register)
   begin
        case state_register is
            when S0_OFF=>
                Bomba_Led<='0';
                Indica_On<='0';
                Estado_out<="00";
            when S1_ON=>
                Bomba_Led<='0';
                Indica_On<='1';
                Estado_out<="01";
                --Tenemos que añadir el tiempo que está funcionando el "echar café durante el CORTO y el LARGO"
            when S2_CORTO=>
                Bomba_Led<='1';
                Indica_On<='1';
                Estado_out<="10";
            when S3_LARGO=>
                Bomba_Led<='1';
                Indica_On<='1';
                Estado_out<="11";
        end case;
   end process;      

end Behavioral;












