LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all

ENTITY w_reg IS 
	PORT (
	
	nrst: IN STD_LOGIC;
	clk_in: IN STD_LOGIC;
	d_in: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	wr_en: IN STD_LOGIC;
	
	w_out: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	);
END ENTITY;

ARCHITECTURE Arch1 OF w_reg IS	

BEGIN

	w_out <= d_in when clk_in = '1' and  wr_en = '1' else
	"00000000" when nrst = '1';

END Arch1;