library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           ALU_op : out  STD_LOGIC_VECTOR (5 downto 0));
end CU;

architecture Behavioral of CU is

begin
process(op, op3)
	begin
		if (op = "10") then
			case (op3) is
				when "000000" => ALU_op <= "000000";--add
				when "000100" => ALU_op <= "000001";--sub
				when "000010" => ALU_op <= "000010";--or
				when "000001" => ALU_op <= "000011";--and
				when "000011" => ALU_op <= "000100";--xor
				when "000110" => ALU_op <= "000101";--orN
				when "000101" => ALU_op <= "000110";--andN
				when "000111" => ALU_op <= "000111";--xnor
				when others =>  ALU_OP <= "001000";--nop
			end case;
		else ALU_op <= "001000";
		end if;
	end process;

end Behavioral;

