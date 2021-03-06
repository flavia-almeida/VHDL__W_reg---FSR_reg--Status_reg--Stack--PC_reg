LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

ENTITY Status_reg IS 
	PORT (
	
	nrst: IN STD_LOGIC; -- zera o registrador
	clk_in: IN STD_LOGIC; -- clock, escrita na borda de subida
	abus_in: IN STD_LOGIC_VECTOR(8 DOWNTO 0); -- entrada de enderešamento abus_in[6..0] = "0000011".
	dbus_in: IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- entrada de dados para escrita
	wr_en: IN STD_LOGIC; -- habilita escrita dbus_in para fsr_out
	rd_en: IN STD_LOGIC; -- habilitašao da leitura dbus_out = fsr_out
	
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
	);
END ENTITY;

ARCHITECTURE Arch1 OF Status_reg IS	
	signal registrador: STD_LOGIC_VECTOR(7 DOWNTO 0); -- registrador final
BEGIN
	
	
	process(clk_in, nrst)
	BEGIN
		IF nrst = '0' THEN
				registrador <= (others => '0');
				irp_out <= '0';
				rp_out(0) <= '0';
				rp_out(1) <= '0';
				z_out <= '0';
				dc_out <= '0';
				c_out <= '0';
		
		ELSIF rising_edge(clk_in) THEN
			
			IF abus_in(6 DOWNTO 0) = "0000011" THEN				

				
				IF wr_en = '1' THEN
					registrador <= dbus_in;
				END IF;
				registrador(4)<= '1';
				registrador(3)<= '1';
								
				IF z_wr_en = '1' THEN
					registrador(2) <= z_in;					
				END IF;
				
				IF dc_wr_en = '1' THEN
					registrador(1) <= dc_in;					
				END IF;
				
				IF c_wr_en = '1' THEN
					registrador(0) <= c_in;					
				END IF;					
				

				
				c_out <= registrador(0);
				z_out <= registrador(2);
				dc_out <= registrador(1);
				irp_out <= registrador(7);
				rp_out(0) <= registrador(5);
				rp_out(1) <= registrador(6);	
						
			END IF;
		END IF;
		IF rd_en = '1' THEN
				dbus_out <= registrador;
		END IF;
	END PROCESS;
END Arch1;