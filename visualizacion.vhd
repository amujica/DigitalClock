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

entity visualizacion is
 Port ( E0 : in STD_LOGIC_VECTOR (3 downto 0);   -- Entrada MUX 0
 E1 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 1
 E2 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 2
 E3 : in STD_LOGIC_VECTOR (3 downto 0);          -- Entrada MUX 3
 CLK : in STD_LOGIC;                             -- Entrada de reloj
 SEG7 : out STD_LOGIC_VECTOR (6 downto 0);       -- Salida para los displays
 AN : out STD_LOGIC_VECTOR (3 downto 0));        -- Activación individual
end visualizacion;

architecture a_visualizacion of visualizacion is  --Señales necesarias:
signal N_1 : STD_LOGIC_VECTOR (3 downto 0);       -- Señal de 4 bits
signal N_2 : STD_LOGIC_VECTOR (1 downto 0);       -- Señal de 2 bits

component MUX4x4
 Port ( E0 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada 0
 E1 : in STD_LOGIC_VECTOR (3 downto 0);        -- Entrada 1
 E2 : in STD_LOGIC_VECTOR (3 downto 0);        -- Entrada 2
 E3 : in STD_LOGIC_VECTOR (3 downto 0);        -- Entrada 3
 S : in STD_LOGIC_VECTOR (1 downto 0);         -- Señal de control
 Y : out STD_LOGIC_VECTOR (3 downto 0));       -- Salida
end component;

component decod7s
 Port ( 	D : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada BCD
			S: out STD_LOGIC_VECTOR (0 to 6));    -- Salida para excitar los displays
end component;


component refresco
 Port ( CLK : in STD_LOGIC;                    -- Reloj
 S : out STD_LOGIC_VECTOR (1 downto 0);        -- Control para el mux
 AN : out STD_LOGIC_VECTOR (3 downto 0));      -- Control displays individuales
end component;
begin

G1 : decod7s
      port map (         -- Portmap del componente decod7s. Usamos la señal N_1
					N_1,      -- para conectar su entrada con la salida del
					SEG7      -- componente MUX4x4
               );  

G2 : MUX4x4
      port map (         -- Portmap del componente MUX4x4. Usamos la señal N_1 
					E0,  		 -- para conectar su salida con la entrada de decod7s.
					E1,       -- La señal N_2 la usamos para conectarlo con la salida S
					E2,       -- de refresco
					E3,
					N_2,
					N_1
				 
					);							 		 
					 
G3 : refresco
       port map (        -- Portmap del componente refresco. Usamos la señal N_2 
					 CLK,     -- para conectar la entrada S con la entrada S de MUX4x4  
					 N_2,
					 AN
                );
		 
end a_visualizacion;