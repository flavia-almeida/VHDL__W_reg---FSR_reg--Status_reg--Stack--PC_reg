LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

ENTITY Status_reg IS 
	PORT (
	
	nrst: IN STD_LOGIC; -- zera o registrador
	clk_in: IN STD_LOGIC; -- clock, escrita na borda de subida
	stack_in: IN STD_LOGIC_VECTOR(12 DOWNTO 0); -- entrada de dados para pilha
	stack_push: IN STD_LOGIC; -- habilita para empilhar os valores
	stack_pop: IN STD_LOGIC; -- habilita escrita dbus_in para fsr_out
	
-- ---------------- SAIDAS ----------------------
	
	stack_out: OUT STD_LOGIC_VECTOR(12 DOWNTO 0); -- saida da leitura exceto os bits 4 e 3
	)
END ENTITY;

ARCHITECTURE Arch1 OF Status_reg IS	
	signal registrador: STD_LOGIC_VECTOR(7 DOWNTO 0); -- registrador final
BEGIN
	
	
	process(clk_in, nrst)
	BEGIN
		IF rising_edge(clk_in) THEN
		
			IF nrst = '1' THEN
				registrador <= (others => '0');
				irp_out <= '0';
				rp_out(0) <= '0';
				rp_out(1) <= '0';
				z_out <= '0';
				dc_out <= '0';
				c_out <= '0';
			END IF;
			
			IF abus_in abus_in (6 DOWNTO 0) = "0000011" THEN
			
				registrador <= dbus_in;
				registrador(4)<= '1';
				registrador(3)<= '1';
				irp_out <= registrador(7);
				rp_out(0) <= registrador(5);
				rp_out(1) <= registrador(6);
				z_out <= registrador(2);
				dc_out <= registrador(1);
				c_out <= registrador(0);
				
				IF rd_en = '1' THEN
					dbus_out <= registrador;
				END IF;
				
			END IF;
		END IF;
	END PROCESS;
END Arch1;