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
-- registro: copia la entrada cuando el enable esta activo
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registro is
 Port ( 
			ENTRADA : in STD_LOGIC_VECTOR (13 downto 0); -- Entradas
			SALIDA : out STD_LOGIC_VECTOR (13 downto 0); -- Salidas
			EN : in STD_LOGIC;                           -- Enable
			RCLK : in STD_LOGIC);                        -- Reloj
end registro;


architecture a_registro of registro is

signal trans: STD_LOGIC_VECTOR (13 downto 0);         -- Señal de 14 bits

begin

process (RCLK, EN)

begin
if (RCLK'event and RCLK = '1' AND EN='1') then
trans <= ENTRADA;                                   -- La señal trans se corresponde con la entrada con flanco       
end if;															 -- positivo de reloj y EN='1'
end process;

SALIDA <= trans;                                    -- La salida se corresponde con la señal trans         
end a_registro;