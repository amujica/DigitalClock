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
-- AND_2: consigue la condición U1<SUMA<=U2
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AND_2 is
 Port (  A : in STD_LOGIC;   -- Entrada A
			B : in STD_LOGIC;   -- Entrada B
			S : out STD_LOGIC); -- Salida
end AND_2;

architecture a_AND_2 of AND_2 is
begin
	 S <= A and B;          -- La salida S se correponde con la operacion AND
									-- de las entradas A y B (solo sera 1 cuando A y B lo sean)
end a_AND_2;