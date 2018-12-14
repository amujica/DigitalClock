----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:32:57 11/30/2017 
-- Design Name: 
-- Module Name:    gen_second - Behavioral 
-- Project Name: 
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
entity gen_second is
 Port ( CLK : in STD_LOGIC; -- Reloj de la FPGA
			CLK_SECOND : out STD_LOGIC); -- Reloj de muestreo
end gen_second;

architecture a_gen_second of gen_second is

signal cont_M : STD_LOGIC_VECTOR (31 downto 0):= (others=>'0'); -- contador 1
signal S_M : STD_LOGIC :='0';
begin
 PROC_CONT : process (CLK)
 begin
if CLK'event and CLK='1' then
 cont_M <= cont_M + 1;

 if cont_M >= 25000000 then
 S_M <=not S_M;
 cont_M <=(others=>'0');
 end if;
end if;
 end process;
 CLK_SECOND<=S_M;

end a_gen_second;

