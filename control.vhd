
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity refresco is
    Port ( CLK : in  STD_LOGIC;                     -- Reloj
           AN : out STD_LOGIC_VECTOR(3 downto 0);   -- Control displays individuales
           S : out  STD_LOGIC_VECTOR(1 downto 0));  -- Control para el mux
end refresco;

architecture a_refresco of refresco is
signal cont : STD_LOGIC_VECTOR (31 downto 0);      --Señal de contador de 32 bits 
signal activacion : STD_LOGIC_VECTOR (1 downto 0); --Señal de seleccion del mux

begin

process (CLK)
begin

if CLK'event and CLK='1' then   

  cont<=cont + '1';    

  if cont=50000 then                    -- Cada 50000 valores del contador el display activado cambia

    activacion <= activacion + '1';     -- Genera la secuencia 00,01,10 y 11

	 cont<=(others=>'0');                -- Pone el contador a 0

  end if;
end if;
end process;

S<=activacion;                              -- La salida S se corresponde con la señal activacion 

                                            -- Los displays se activan con un 0:
AN <= 	"0111" when activacion="00" else   -- Primer display activado cuando activacion="00"
			"1011" when activacion="01" else   -- Segundo display activado cuando activacion="01"
			"1101" when activacion="10" else   -- Tercer display activado cuando activacion="10"
			"1110" when activacion="11";       -- Cuarto display activado cuando activacion="11"

end a_refresco;

