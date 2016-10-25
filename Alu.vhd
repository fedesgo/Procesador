library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity Alu is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           AluOp : in  STD_LOGIC_VECTOR (5 downto 0);
			  C : in STD_LOGIC;
           AluResult : out  STD_LOGIC_VECTOR (31 downto 0));
end Alu;

architecture Behavioral of Alu is

begin
	process(A,B,AluOp,C)
	begin
	   case (AluOp) is 
			when "000000" => -- add
				AluResult <= A + B; 
			when "001000" => -- addx
				AluResult <= A + B + C;
			when "000001" => -- sub
				AluResult <= A - B; 
			when "001001" => -- subx
				AluResult <= A - B - C;
			when "000010" => --or
				AluResult <= A or B;
			when "000011" => --and
				AluResult <= A and B;
			when "000100" => --xor
				AluResult <= A xor B;
			when "000101" => -- orN
				AluResult <= A or (not B);
			when "000110" => --andN
				AluResult <= A and (not B);
			when "000111" => --xnor
				AluResult <= A xor (not B);
			when others => -- Cae el nop
				AluResult <= (others=>'0');
		end case;
	end process;

end Behavioral;

