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
-- reg_desp40: Captura las 40 muestras correspondientes a un tiempo de bit
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity reg_desp40 is
 Port ( SIN : in STD_LOGIC; 						-- Datos de entrada serie
 CLK : in STD_LOGIC;								   -- Reloj de muestreo
 Q : out STD_LOGIC_VECTOR (39 downto 0));    -- Salida paralelo
end reg_desp40;


architecture a_reg_desp40 of reg_desp40 is

signal salida:  STD_LOGIC_VECTOR (39 downto 0):=(others=>'0');  -- señal de 49 bits inicializada 
																					 -- con 40 ceros
begin
	process(CLK)
	begin
		if (CLK'event and CLK='1' ) then        
		
     	 salida <= salida(38 downto 0) & SIN;	 -- Concatenación de los 39 primeros bits 
															 -- de la salida anterior con la entrada SIN con
															 -- cada flanco positivo del reloj:
		end if;											 -- desplazamiento hacia la izquierda de los bits

	end process;
	
Q<=salida;                  -- La salida Q se corresponde con la señal salida                

end a_reg_desp40;

