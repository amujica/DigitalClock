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
-- gen_reloj: divide el reloj para conseguir la frecuencia que queremos
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity gen_reloj is
 Port (  CLK : in STD_LOGIC;           -- Reloj de la FPGA (50Mhz)
			CLK_OUT : out STD_LOGIC);     -- Reloj de muestreo (40 Hz)
end gen_reloj;

architecture a_gen_reloj of gen_reloj is

signal cont_M : STD_LOGIC_VECTOR (31 downto 0):= (others=>'0');	 -- contador 1
signal S_M : STD_LOGIC :='0';													 --señal para usar
begin
	PROC_CONT : process (CLK)
		begin
			if CLK'event and CLK='1' then         --Suma 1 a cont_M por cada
				cont_M <= cont_M + 1;				  --flanco positivo del reloj
 
				if cont_M >= 625000 then            --Cuando llega a 625000,
					S_M <=not S_M;				    		-- se niega S_M y
					cont_M <=(others=>'0');				--se pone el contador a 0
				end if;
			end if;
		end process;
		
 CLK_OUT<=S_M;                --La salida CLK_OUT se corresponde con la señal S_M

end a_gen_reloj;