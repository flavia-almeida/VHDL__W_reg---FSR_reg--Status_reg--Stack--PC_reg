LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

ENTITY FSR_reg IS 
	PORT (
	
	nrst: IN STD_LOGIC; -- zera o registrador
	clk_in: IN STD_LOGIC; -- clock, escrita na borda de subida
	abus_in: IN STD_LOGIC_VECTOR(8 DOWNTO 0); -- entrada de endere�amento abus_in[6..0] = �0000100�.
	dbus_in: IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- entrada de dados para escrita
	wr_en: IN STD_LOGIC; -- habilita escrita dbus_in para fsr_out
	rd_en: IN STD_LOGIC; -- habilita�ao da leitura dbus_out = fsr_out
	
	
	dbus_out: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- saida da leitura
	fsr_out: OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- saida do registrador
	);
END ENTITY;

ARCHITECTURE Arch1 OF FSR_reg IS	
	signal fsr_out_tmp: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	
	process(clk_in, nrst)
	BEGIN
	fsr_out_tmp <= (others => '0');
	IF rising_edge(clk_in) THEN
		IF nrst = '0' THEN
			fsr_out_tmp <= (others => '0');
		ELSIF abus_in (6 DOWNTO 0) = "0000100" THEN
			IF wr_en = '1' THEN
				fsr_out_tmp <= dbus_in;
			END IF;
		END IF;
		
		IF rd_en = '1' THEN
			dbus_out <= fsr_out_tmp WHEN abus_in(6 DOWNTO 0) = "0000100"; -- ELSE "ZZZZZZZZ"; -- Sa�da da leitura
		END IF;
		fsr_out <= fsr_out_tmp;
	END IF;
--		programCounter(12 DOWNTO 8) <= pcLath(4 DOWNTO 0);
		
	END PROCESS;

--	dbus_out <= fsr_out_tmp WHEN abus_in(6 DOWNTO 0) = "0000100" AND rd_en = '1' ELSE "ZZZZZZZZ"; -- Sa�da da leitura
END Arch1;