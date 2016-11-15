library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
			  op2 : in STD_LOGIC_VECTOR (2 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  cond : in STD_LOGIC_VECTOR (3 downto 0);
			  icc : in STD_LOGIC_VECTOR (3 downto 0);
			  
           ALU_op : out  STD_LOGIC_VECTOR (5 downto 0);
			  RFDest : out STD_LOGIC;
			  RFSource : out STD_LOGIC_VECTOR ( 1 downto 0);
			  WrEnMem : out STD_LOGIC;
			  PCSource : out STD_LOGIC_VECTOR (1 downto 0);
			  WrEnRF : out STD_LOGIC_VECTOR (1 downto 0);
			  PSR_op : out STD_LOGIC_VECTOR (5 downto 0));
end CU;

architecture Behavioral of CU is

begin
process(op, op2, op3, cond, icc)
	begin
		if (op = "00") then --Branches, NOP, Sethi
		
		--------BRANCHES------------------
			if(op2 = "010") then
				case cond is
					when "1000" => --Branch always
						ALU_op <= "111111"; --No se toma como una operación
						RFDest <= '0'; --No importa
						RFSource <= "00"; --No importa
						WrEnMem <= '0';
						PCSource <= "10"; --PC + SEU(DISP22)
						WrEnRF <= '0';
					when "1001" => --Branch not equal
						if (not(icc(2)) = '1') then
							ALU_op <= "111111"; --No se toma como una operación
							RFDest <= '0'; --No importa
							RFSource <= "00"; --No importa
							WrEnMem <= '0';
							PCSource <= "10"; --PC + SEU(DISP22)
							WrEnRF <= '0';
						else
							ALU_op <= "111111"; --No se toma como una operación
							RFDest <= '0'; --No importa
							RFSource <= "00"; --No importa
							WrEnMem <= '0';
							PCSource <= "11"; --PC + 1
							WrEnRF <= '0';
						end if;
					when "0001" => --Branch equal
						if (icc(2) = '1') then
							ALU_op <= "111111"; --No se toma como una operación
							RFDest <= '0'; --No importa
							RFSource <= "00"; --No importa
							WrEnMem <= '0';
							PCSource <= "10"; --PC + SEU(DISP22)
							WrEnRF <= '0';
						else
							ALU_op <= "111111"; --No se toma como una operación
							RFDest <= '0'; --No importa
							RFSource <= "00"; --No importa
							WrEnMem <= '0';
							PCSource <= "11"; --PC + 1
							WrEnRF <= '0';
						end if;
					when "1010" => --Branch greater
						if ((not(icc(2) or (icc(3) xor icc(1)))) = '1') then
							ALU_op <= "111111"; --No se toma como una operación
							RFDest <= '0'; --No importa
							RFSource <= "00"; --No importa
							WrEnMem <= '0';
							PCSource <= "10"; --PC + SEU(DISP22)
							WrEnRF <= '0';
						else
							ALU_op <= "111111"; --No se toma como una operación
							RFDest <= '0'; --No importa
							RFSource <= "00"; --No importa
							WrEnMem <= '0';
							PCSource <= "11"; --PC + 1
							WrEnRF <= '0';
						end if;
					when "0010" => --Branch less or equal
						if ((icc(2) or (icc(3) xor icc(1))) = '1') then
							ALU_op <= "111111"; --No se toma como una operación
							RFDest <= '0'; --No importa
							RFSource <= "00"; --No importa
							WrEnMem <= '0';
							PCSource <= "10"; --PC + SEU(DISP22)
							WrEnRF <= '0';
						else
							ALU_op <= "111111"; --No se toma como una operación
							RFDest <= '0'; --No importa
							RFSource <= "00"; --No importa
							WrEnMem <= '0';
							PCSource <= "11"; --PC + 1
							WrEnRF <= '0';
						end if;
					when "1011" => --Branch greater or equal
						if ((not(icc(3) xor icc(1))) = '1') then
							ALU_op <= "111111"; --No se toma como una operación
							RFDest <= '0'; --No importa
							RFSource <= "00"; --No importa
							WrEnMem <= '0';
							PCSource <= "10"; --PC + SEU(DISP22)
							WrEnRF <= '0';
						else
							ALU_op <= "111111"; --No se toma como una operación
							RFDest <= '0'; --No importa
							RFSource <= "00"; --No importa
							WrEnMem <= '0';
							PCSource <= "11"; --PC + 1
							WrEnRF <= '0';
						end if;
					when "0011" => --Branch less
						if ((icc(3) xor icc(1)) = '1') then
							ALU_op <= "111111"; --No se toma como una operación
							RFDest <= '0'; --No importa
							RFSource <= "00"; --No importa
							WrEnMem <= '0';
							PCSource <= "10"; --PC + SEU(DISP22)
							WrEnRF <= '0';
						else
							ALU_op <= "111111"; --No se toma como una operación
							RFDest <= '0'; --No importa
							RFSource <= "00"; --No importa
							WrEnMem <= '0';
							PCSource <= "11"; --PC + 1
							WrEnRF <= '0';
						end if;
					when others => --no implementado
						ALU_op <= "111111";--No se toma como una operacion
						RFDest <= '0';
						RFSource <= "00";--No importa
						WrEnMem <= '0';
						PCSource <= "00"; -- Pc por direccion
						WrEnRF <= '0';
				end case;
				
		-----------------SETHI----------------------
			elsif(op2 = "100") then
				ALU_op <= "111111";
				RFDest <= '0';
				RFSource <= "01"; ---SALIDA DEL ALU
				WrEnMem <= '0';
				PCSource <= "11"; -- PC + 1
				WrEnRF <= '0';
			end if;
			
		elsif (op = "01") then ----------- Call----------
			ALU_op <= "111111";
			RFDest <= '1'; --Reg o7
			RFSource <= "10"; ---Almacena PC en o7
			WrEnMem <= '0';
			PCSource <= "01"; -- PC + SEU(disp30)
			WrEnRF <= '1';
		
		elsif (op = "10") then
			case (op3) is
				when "000000" => 
					ALU_op <= "000000";--add
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "000100" => 
					ALU_op <= "000001";--sub
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "000010" => 
					ALU_op <= "000010";--or
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "000001" => 
					ALU_op <= "000011";--and
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "000011" => 
					ALU_op <= "000100";--xor
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "000110" => 
					ALU_op <= "000101";--orN
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "000101" => 
					ALU_op <= "000110";--andN
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "000111" => 
					ALU_op <= "000111";--xnor
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "010000" => 
					ALU_op <= "000000";--addcc
					PSR_op <= "000001";
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "001000" => 
					ALU_op <= "001000";--addx
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "011000" => 
					ALU_op <= "001000";--addxcc
					PSR_op <= "000001";
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "010100" => 
					ALU_op <= "000001";--subcc
					PSR_op <= "000010";
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "001100" => 
					ALU_op <= "001001";--subx
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "011100" => 
					ALU_op <= "001001";--subxcc
					PSR_op <= "000010";
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "010010" => 
					ALU_op <= "000010";--orcc
					PSR_op <= "000011";
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "010001" => 
					ALU_op <= "000011";--andcc
					PSR_op <= "000011";
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "010011" => 
					ALU_op <= "000100";--xorcc
					PSR_op <= "000011";
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "010110" => 
					ALU_op <= "000101";--orNcc
					PSR_op <= "000011";
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "010101" => 
					ALU_op <= "000110";--andNcc
					PSR_op <= "000011";
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "010111" => 
					ALU_op <= "000111";--xnorcc
					PSR_op <= "000011";
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "100101" => ---SLL
					ALU_op <= "001000";
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "100110" => ---SRL
					ALU_op <= "001001";
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "111100" => --SAVE
					ALU_op <= "000000";
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "111101" => --RESTORE
					ALU_op <= "000000";
					RFDest <= '0';
					RFSource <= "01"; --- Salida de la ALU entra al RF
					WrEnMem <= '0'; --No se escribe en data memory
					PCSource <= "11"; --PC + 1
					WrEnRF <= '1'; --Se permite escribir en el Register File
				when "111000" => ---Jump and link
					ALU_op <= "000000"; --Address = r[rs1] + r[rs1]_or_imm
					RFDest <= '0';
					RFSource <= "10"; --Escribe el PC en el Register File
					WrEnMem <= '0';
					PCSource <= "00"; --PC se da por dirección
					WrEnRF <= '1'; --Se permite escribir en el Register File
			end case;
			
		---------LOAD Y STORE-----------
		elsif(op = "11") then
			if(op3 = "000000") then --Load
				ALU_op <= "000000"; --Address = r[rs1] + r[rs1]_or_imm
				RFDest <= '0';
				RFSource <= "00"; --Al Register File va lo que sale del Data Memory
				WrEnMem <= '0';
				PCSource <= "00"; --PC por direccion
				WrEnRF <= '1';  --Almacena en RF lo de Datamemory
			elsif(op3 = "000100") then --Store
				ALU_op <= "000000"; --Address = r[rs1] + r[rs1]_or_imm
				RFDest <= '0';
				RFSource <= "00"; --A la memoria va lo que sale de RegisterFile
				WrEnMem <= '0';
				PCSource <= "11";
				WrEnRf <= '0';
			end if;
		end if;
	end process;

end Behavioral;

