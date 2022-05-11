LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

ENTITY Status_reg IS 
	PORT (
	
	nrst: IN STD_LOGIC; -- zera o registrador
	clk_in: IN STD_LOGIC; -- clock, escrita na borda de subida
	abus_in: IN STD_LOGIC_VECTOR(8 DOWNTO 0); -- entrada de endereçamento abus_in[6..0] = "0000011".
	dbus_in: IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- entrada de dados para escrita
	wr_en: IN STD_LOGIC; -- habilita escrita dbus_in para fsr_out
	rd_en: IN STD_LOGIC; -- habilitaçao da leitura dbus_out = fsr_out
	
	z_in: IN STD_LOGIC; -- dado para escrita apenas no bit 2 do registrador
	dc_in: IN STD_LOGIC; -- dado para escrita apenas no bit 1 do registrador
	c_in: IN STD_LOGIC;-- dado para escrita apenas no bit 0 do registrador
	z_wr_en: IN STD_LOGIC; -- habilita escrita do bit 2 do registrador
	dc_wr_en: IN STD_LOGIC; -- habilita escrita do bit 1 do registrador
	c_wr_en: IN STD_LOGIC; -- habilita escrita do bit 0 do registrador
	
-- ---------------- SAIDAS ----------------------
	
	dbus_out: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- saida da leitura exceto os bits 4 e 3
	irp_out: OUT STD_LOGIC; --saida do bit 7 do registrador (sempre ativa)
	rp_out: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);-- saida do bit 6 e 5 do registrador (sempre ativa)
	z_out: OUT STD_LOGIC; --saida do bit 2 do registrador (sempre ativa)
	dc_out: OUT STD_LOGIC; --saida do bit 1 do registrador (sempre ativa)
	c_out: OUT STD_LOGIC --saida do bit 0 do registrador (sempre ativa)
	)
END ENTITY;

ARCHITECTURE Arch1 OF Status_reg IS	
	signal registrador: STD_LOGIC_VECTOR(7 DOWNTO 0); -- registrador final
BEGIN
	
	registrador <- dbus_in WHEN abus_in = "0000011" AND clk_in = '1';
	
	irp_out <- dbus_in(7) WHEN abus_in = "0000011" AND clk_in = '1';
	

	fsr_out_tmp = '00000000' WHEN nrst = '1' ELSE
	dbus_in WHEN clk_in = '1' AND abus_in(6 DOWNTO 0) = "0000100" AND wr_en = '1';
	
	fsr_out = fsr_out_tmp;
	
	dbus_out = fsr_out_tmp WHEN rd_en = '1' AND abus_in(6 DOWNTO 0) = "0000100";
	
END Arch1;