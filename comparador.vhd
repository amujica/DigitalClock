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
-- Comparador: compara la señal de 6 bits con los umbrales para decidir si es 0 o 1 más tarde
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity comparador is
 Port (  P : in STD_LOGIC_VECTOR (5 downto 0); -- Entrada P
			Q : in STD_LOGIC_VECTOR (5 downto 0); -- Entrada Q
			PGTQ : out STD_LOGIC;                 -- Salida P>Q
			PLEQ : out STD_LOGIC);                -- Salida P=Q
end comparador;


architecture a_comparador of comparador is

begin

PGTQ <= '1' when (P > Q) else '0';              -- PGTQ sera 1 cuando P>Q y 0 cuando no
PLEQ <= '1' when (Q > P) or (Q = P) else '0';   -- PLEQ sera 1 cuando P<Q o P=Q y 0 cuando P>Q

end a_comparador;