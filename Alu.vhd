library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity Alu is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           AluOp : in  STD_LOGIC_VECTOR (5 downto 0);
           AluResult : out  STD_LOGIC_VECTOR (31 downto 0));
end Alu;

architecture Behavioral of Alu is

begin
	process(A,B,AluOp)
	begin
	   case (AluOp) is 
			when "000000" => -- add
				AluResult <= A + B;
			when "000001" => -- sub
				AluResult <= A - B;
			when "000010" => --or
				AluResult <= A or B;
			when "000011" => --and
				AluResult <= A and B;
			when "000100" => --xor
				AluResult <= A xor B;
			when "000101" => -- orN
				AluResult <= not(A or B);
			when "000110" => --andN
				AluResult <= not(A and B);
			when "000111" => --xnor
				AluResult <= A xnor B;
			when others => -- Cae el nop
				AluResult <= (others=>'0');
		end case;
	end process;

end Behavioral;

