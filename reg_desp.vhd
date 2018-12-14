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
-- Almacena los 14 bits de la hora
----------------------------------------------------------------------------------
library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity reg_desp is
 
 Port ( 
		SIN : in STD_LOGIC;                      -- Datos de entrada serie
		CLK : in STD_LOGIC;                      -- Reloj
		EN : in STD_LOGIC;                       -- Enable
		Q : out STD_LOGIC_VECTOR (13 downto 0)); -- Salida paralelo

end reg_desp;

architecture a_reg_desp of reg_desp is
 
signal salida:  STD_LOGIC_VECTOR (13 downto 0):=(others=>'0'); -- señal de 14 bits inicializada 
																					-- con 14 ceros
begin
	process(CLK)
	begin
		if (CLK'event and CLK='1' and EN='1' ) then      
		
      salida <= salida(12 downto 0) & SIN;	 -- Concatenación de los 13 primeros bits 
															 -- de la salida anterior con la entrada SIN con
															 -- cada flanco positivo del reloj y con EN='1'
		end if;
		
	end process;  
	Q<=salida;                                 -- La salida Q se corresponde con la señal salida         
	
end a_reg_desp;
