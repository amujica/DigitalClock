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


entity principal is
 Port ( CLK : in STD_LOGIC;                 -- entrada de reloj
 SIN : in STD_LOGIC;                        -- entrada de datos
 AN : out STD_LOGIC_VECTOR (3 downto 0);    -- control de displays
 SEG7 : out STD_LOGIC_VECTOR (6 downto 0)); -- segmentos de displays
end principal;

architecture a_principal of principal is

-- Constantes del circuito (umbrales de decisión)
constant UMBRAL1 : STD_LOGIC_VECTOR (5 downto 0) := "100010"; -- 34
constant UMBRAL2 : STD_LOGIC_VECTOR (5 downto 0) := "100110"; -- 38


signal CLK_M : STD_LOGIC;                              -- Señales necesarias para conectar 
signal N_DESP40 : STD_LOGIC_VECTOR (39 downto 0);      -- todos los módulos
signal N_SUM40 : STD_LOGIC_VECTOR (5 downto 0);
signal N_PGTQ1 : STD_LOGIC;
signal N_C0 : STD_LOGIC;
signal N_C1 : STD_LOGIC;
signal N_PLEQ2 : STD_LOGIC;
signal N_PGTQ2 : STD_LOGIC;
signal N_DATO : STD_LOGIC;
signal N_CAPTURA : STD_LOGIC;
signal N_VALIDAR : STD_LOGIC;
signal N_REGDESP : STD_LOGIC_VECTOR (13 downto 0);
signal N_14BITS : STD_LOGIC_VECTOR (13 downto 0);



component gen_reloj
 Port ( 	CLK : in STD_LOGIC;       -- Reloj de la FPGA
			CLK_OUT : out STD_LOGIC); -- Reloj de frecuencia dividida
end component;


component reg_desp40
 Port ( SIN : in STD_LOGIC;               -- Datos de entrada serie
 CLK : in STD_LOGIC;                      -- Reloj de muestreo
 Q : out STD_LOGIC_VECTOR (39 downto 0)); -- Salida paralelo
end component;


component sumador40
 Port ( ENT : in STD_LOGIC_VECTOR (39 downto 0);
 SAL : out STD_LOGIC_VECTOR (5 downto 0));
end component;


component comparador
 Port ( P : in STD_LOGIC_VECTOR (5 downto 0);
 Q : in STD_LOGIC_VECTOR (5 downto 0);
 PGTQ : out STD_LOGIC;
 PLEQ : out STD_LOGIC);
end component;


component AND_2
 Port ( A : in STD_LOGIC;
 B : in STD_LOGIC;
 S : out STD_LOGIC);
end component;


component reg_desp
 Port ( SIN : in STD_LOGIC;               -- Datos de entrada serie
 CLK : in STD_LOGIC;                      -- Reloj
 EN : in STD_LOGIC;                       -- Enable
 Q : out STD_LOGIC_VECTOR (13 downto 0)); -- Salida paralelo
end component;


component registro
 Port ( ENTRADA : in STD_LOGIC_VECTOR (13 downto 0);
 SALIDA : out STD_LOGIC_VECTOR (13 downto 0);
 EN : in STD_LOGIC;                               -- Enable
 RCLK : in STD_LOGIC);
end component;

component automata
 Port ( CLK : in STD_LOGIC;      -- Reloj del autómata
 C0 : in STD_LOGIC;              -- Condición de decision para "0"
 C1 : in STD_LOGIC;              -- Condición de decisión para "1"
 DATO : out STD_LOGIC;           -- Datos a cargar
 CAPTUR : out STD_LOGIC;         -- Enable del reg. de desplaz.
 VALID : out STD_LOGIC);         -- Activación registro
end component;

component visualizacion
 Port ( E0 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada MUX 0
 E1 : in STD_LOGIC_VECTOR (3 downto 0);    -- Entrada MUX 1
 E2 : in STD_LOGIC_VECTOR (3 downto 0);    -- Entrada MUX 2
 E3 : in STD_LOGIC_VECTOR (3 downto 0);    -- Entrada MUX 3
 CLK : in STD_LOGIC;                       -- Entrada de reloj FPGA
 SEG7 : out STD_LOGIC_VECTOR (6 downto 0); -- Salida para los displays
 AN : out STD_LOGIC_VECTOR (3 downto 0));  -- Activación individual
end component;

begin

U1 : reg_desp40
      port map (
               SIN=> SIN, 
               Q=>N_DESP40,
					CLK=>CLK_M
               );  

U2 : gen_reloj
      port map (
					CLK=> CLK,
					CLK_OUT=>CLK_M 
					);
					
U3 : sumador40
      port map (
					ENT=>N_DESP40,
					SAL=>N_SUM40
					);
					 
U4 : comparador
       port map (
		          P=>N_SUM40,
                Q=>UMBRAL1,
					 PGTQ=>N_PGTQ1,
					 PLEQ=>N_C1
					 );					 
					 
U5 : comparador
       port map (
					 P=>N_SUM40,
                Q=>UMBRAL2,
					 PGTQ=>N_PGTQ2,
                PLEQ=>N_PLEQ2
                );


U6 : AND_2
       port map (
					 A=>N_PGTQ1,
					 B=>N_PLEQ2,
					 S=>N_C0
                );		 
U7 : automata
       port map (
					 CLK=>CLK_M,
					 C0=>N_C0,
					 C1=>N_C1,
					 DATO=>N_DATO,
					 CAPTUR=>N_CAPTURA,
					 VALID=>N_VALIDAR
                );
U8 : reg_desp
       port map (
					 CLK=>CLK_M,
					 SIN=>N_DATO,
					 EN=>N_CAPTURA,
					 Q=>N_REGDESP
                );
U9 : registro
       port map (
					 RCLK=>CLK_M,
					 SALIDA=>N_14BITS,
					 EN=>N_VALIDAR,
					 ENTRADA=>N_REGDESP
                );

U10 : visualizacion
       port map (
					 CLK=> CLK,
					 AN=>AN,
					 SEG7=>SEG7,
					 E0(3)=>'0',
					 E0(2 downto 0)=> N_14BITS(13 downto 11),
					 E1(3 downto 0)=> N_14BITS(10 downto 7),
					 E2(3)=>'0',
					 E2(2 downto 0)=> N_14BITS(6 downto 4),
					 E3(3 downto 0)=> N_14BITS(3 downto 0)
                );		 

end a_principal;