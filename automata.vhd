----------------------------------------------------------------------------------
-- Company: Etsit UPM
-- Engineers: Alberto Mujica Ayuso & Javier Sánchez-Blanco Boyer 
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    
-- Project Name: Reloj de Celt
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity automata is
 Port ( CLK : in STD_LOGIC;   -- Reloj del autómata
 C0 : in STD_LOGIC;           -- Condición de decision para "0"
 C1 : in STD_LOGIC;           -- Condición de decisión para "1"
 DATO : out STD_LOGIC;        -- Datos a cargar
 CAPTUR : out STD_LOGIC;      -- Enable del reg. de desplaz.
 VALID : out STD_LOGIC);      -- Enable del reg de validación
end automata;

architecture a_automata of automata is
type TIPO_ESTADO is (ESP_SYNC,AVAN_ZM,MUESTREO,DATO0,DATO1,DATOSYNC); -- Estados del automata
signal ST : TIPO_ESTADO:= ESP_SYNC ;                                  -- Estado inicial en que arranca
signal salidas : STD_LOGIC_VECTOR (2 downto 0) :="000";

begin
 process (CLK)
 variable cont : STD_LOGIC_VECTOR (7 downto 0):="00000000";    -- contador
                                                               -- para contar ciclos en un estado, iniciado a 0
		begin
			if (CLK'event and CLK = '1') then
				
				case ST is
					when ESP_SYNC => 	                    -- Estado normal, dura 1 ciclo de reloj

						   if (C0='0' and C1='0') then     -- Si COC1= "00" el estado cambia a AVANZAR
									ST<=AVAN_ZM;
							else                            -- En el resto de casos se queda en el mismo estado (ESP_SYNC)
								ST<= ESP_SYNC;
							end if;
  
					when AVAN_ZM => 							  -- Estado que dura 20 ciclos de reloj
 
							cont:= cont+1;				         -- Se incrementa el contador.
							if (cont=20) then 		         -- Si llega a 20
							  cont:=(others=>'0');           -- Poner el contador a 0
							  ST<=MUESTREO;			         -- Y cambiar de estado
				    		else
							  ST<=AVAN_ZM;			            -- Si no ha llegado a 20 permanecer
                     end if; 						    		-- en el mismo estado
							
					when MUESTREO =>	                     -- Estado que dura 39 ciclos de reloj
							
							cont:= cont+1;                   -- Lleva la cuenta de los ciclos de reloj
							if (cont=39) then						-- Cuando el contador llega a 39  se
						       cont:=(others=>'0');		   -- pone contador a 0
								
								if (C0='0' and C1='0') then   -- Si COC1="00" 
									ST <= DATOSYNC;            -- pasamos al estado DATOSYNC
								end if;
							
								if (C0='0' and C1='1') then   -- Si COC1="01" 
									ST <= DATO1;					-- pasamos al estado DATO1
								end if;
	
								if(C0='1' and C1='0') then    -- Si COC1="10"
									ST <= DATO0;               -- pasamos al estado DATO0
								end if;
							
								else 
								ST<=MUESTREO;                 -- En el resto de casos nos quedamos en MUESTREO
						
						
							end if; 
							
					when DATO0 =>                          -- Estado que dura 1 ciclo de reloj
								ST <= MUESTREO;		         -- Vuelve a muestreo
								
					when DATO1=>                           -- Estado que dura 1 ciclo de reloj
								ST <= MUESTREO;					-- Vuelve a muestreo
								
					when DATOSYNC=>                        -- Estado que dura 1 ciclo de reloj
								ST <= MUESTREO;               -- Vuelve a muestreo
				
					end case;
		
				end if;
	
	end process; 
			 
 with ST select
            salidas<=
                        "010" when DATO0,   -- Salida (3 bits) sera "010" cuando el estado es DATO0
								"110" when DATO1,   -- Salida (3 bits) sera "110" cuando el estado es DATO1
								"001" when DATOSYNC,-- Salida (3 bits) sera "001" cuando el estado es DATOSYNC
								"000" when others;  -- Salida (3 bits) sera "000" en el resto de estados
								
								
				DATO <= salidas(2);    --DATO sera el tercer bit de salidas (0 cuando DATO0 y 1 cuando DATO1)
				CAPTUR <= salidas(1);  --CAPTUR sera el segundo bit de salidas (ENABLE de reg_desp)
				VALID <= salidas(0);   --VALID sera el primer bit de salidas (ENABLE de registro)


end a_automata;