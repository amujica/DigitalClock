library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decod7s is
  port ( D   : in  STD_LOGIC_VECTOR (3 downto 0);    -- entrada de datos
         S : out STD_LOGIC_VECTOR (0 to 6));         -- salidas: los 7 segmentos
end decod7s;

architecture a_decod7s of decod7s is
begin
   with D select S <=            -- Dependiendo del valor de D la salida S sera: (Los segmentos se encienden con un 0)
      "0000001" when "0000",     -- S sera un 0 cuando D="0000" (Todos los segmentos menos "g")
      "1001111" when "0001",     -- S sera un 1 cuando D="0001" (Se encienden "b" y "c")
      "0010010" when "0010",     -- S sera un 2 cuando D="0010" (Todos los segmentos menos "c" y "f")
      "0000110" when "0011",     -- S sera un 3 cuando D="0011" (Todos los segmentos menos "f" y "e")
      "1001100" when "0100",     -- S sera un 4 cuando D="0100" (Todos los segmentos menos "a" "d" y "e")
      "0100100" when "0101",     -- S sera un 5 cuando D="0101" (Todos los segmentos menos "b" y "e")
      "0100000" when "0110",     -- S sera un 6 cuando D="0110" (Todos los segmentos menos "b")
      "0001111" when "0111",     -- S sera un 7 cuando D="0111" (Se encienden "a" "b" y "c")
      "0000000" when "1000",     -- S sera un 8 cuando D="1000" (Se encienden todos)
      "0001100" when "1001",     -- S sera un 9 cuando D="1001" (Todos los segmentos menos "e" y "d")
      "1111111" when others;     -- S sera nada en el resto de casos ya que todos los segmentos se apagan
end a_decod7s;
