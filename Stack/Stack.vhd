LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

ENTITY Stack IS 
	PORT (
	
	nrst: IN STD_LOGIC; -- zera o registrador
	clk_in: IN STD_LOGIC; -- clock, escrita na borda de subida
	stack_in: IN STD_LOGIC_VECTOR(12 DOWNTO 0); -- entrada de dados para pilha
	stack_push: IN STD_LOGIC; -- habilita para empilhar os valores
	stack_pop: IN STD_LOGIC; -- habilita escrita dbus_in para fsr_out
	
-- ---------------- SAIDAS ----------------------
	
	stack_out: OUT STD_LOGIC_VECTOR(12 DOWNTO 0) -- saida da leitura exceto os bits 4 e 3
	);
END ENTITY;

ARCHITECTURE Arch1 OF Stack IS	
		TYPE stack_reg_type IS ARRAY(0 to 7) OF
		STD_LOGIC_VECTOR(12 DOWNTO 0);				
	SIGNAL stack_reg : stack_reg_type;
BEGIN
	process(nrst, clk_in)
	BEGIN
		IF nrst = '0' THEN
			stack_reg <= (others => (others => '0'));
		ELSIF rising_edge(clk_in) THEN
						
			IF stack_pop = '1' THEN
				stack_reg(7) <=(others => '0');
				stack_reg(0 to 6) <= stack_reg (1 to 7);
			ELSIF stack_push = '1' THEN
				stack_reg(0) <= stack_in;
				stack_reg(1 TO 7) <= stack_reg(0 TO 6);
			END IF;
		END IF;
	END PROCESS;
	
	stack_out <= stack_reg(0);
END Arch1;