library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR_M is
    Port ( op1 : in  STD_LOGIC;
           op2 : in  STD_LOGIC;
           ALUr : in  STD_LOGIC_VECTOR (31 downto 0);
           PSR_op : in  STD_LOGIC_VECTOR (5 downto 0);
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0));
end PSR_M;

architecture Behavioral of PSR_M is

begin

process(op1, op2, ALUr, PSR_op)
	begin
		case (PSR_op) is
			when "000001" => --addcc & addxcc
				nzvc(3) <= ALUr(31);
				if (ALUr = x"00000000") then
					nzvc(2) <= '1';
				else nzvc(2) <= '0';
				end if;
				nzvc(1) <= (op1 and op2 and not(ALUr(31))) or (not(op1) and not(op2) and ALUr(31));
				nzvc(0) <= (op1 and op2) or (not(ALUr(31)) and (op1 or op2));
				
			when "000010" => ---subcc & subxcc
				nzvc(3) <= ALUr(31);
				if (ALUr = x"00000000") then
					nzvc(2) <= '1';
				else nzvc(2) <= '0';
				end if;
				nzvc(1) <= (op1 and not(op2) and not(ALUr(31))) or (not(op1) and op2 and ALUr(31));
				nzvc(0) <= (not(op1) and op2) or (ALUr(31) and (not(op1) or op2));
			when "000011" => ---logic cc
				nzvc(3) <= ALUr(31);
				if (ALUr = x"00000000") then
					nzvc(2) <= '1';
				else nzvc(2) <= '0';
				end if;
				nzvc(1) <= '0';
				nzvc(0) <= '0';
			when others =>
				nzvc <= (others=>'0');
		end case;
end process;

end Behavioral;

