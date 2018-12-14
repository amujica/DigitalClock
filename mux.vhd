
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX4x4 is
    Port ( E0 : in  STD_LOGIC_VECTOR (3 downto 0);  -- Entrada de datos 0
           E1 : in  STD_LOGIC_VECTOR (3 downto 0);  -- Entrada de datos 1
			  E2 : in  STD_LOGIC_VECTOR (3 downto 0);  -- Entrada de datos 0
           E3 : in  STD_LOGIC_VECTOR (3 downto 0);  -- Entrada de datos 1
           S : in  STD_LOGIC_VECTOR(1 downto 0);    -- Entrada de control
           Y : out  STD_LOGIC_VECTOR (3 downto 0)); -- Salida
end MUX4x4;

architecture a_MUX4x4 of MUX4x4 is

begin

with S select Y<=    -- S es la entrada de seleccion del Multiplexor
E0 when "00",        -- Si S="00" E0 será la entrada de datos seleccionada
E1 when "01",        -- Si S="01" E1 será la entrada de datos seleccionada
E2 when "10",        -- Si S="10" E2 será la entrada de datos seleccionada
E3 when "11",        -- Si S="11" E3 será la entrada de datos seleccionada
E0 when others;

end a_MUX4x4;
