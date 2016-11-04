library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           ALU_op : out  STD_LOGIC_VECTOR (5 downto 0);
			  PSR_op : out STD_LOGIC_VECTOR (5 downto 0));
end CU;

architecture Behavioral of CU is

begin
process(op, op3)
	begin
		if (op = "10") then
			case (op3) is
				when "000000" => 
					ALU_op <= "000000";--add
				when "000100" => 
					ALU_op <= "000001";--sub
				when "000010" => 
					ALU_op <= "000010";--or
				when "000001" => 
					ALU_op <= "000011";--and
				when "000011" => 
					ALU_op <= "000100";--xor
				when "000110" => 
					ALU_op <= "000101";--orN
				when "000101" => 
					ALU_op <= "000110";--andN
				when "000111" => 
					ALU_op <= "000111";--xnor
				when "010000" => 
					ALU_op <= "000000";--addcc
					PSR_op <= "000001";
				when "001000" => 
					ALU_op <= "001000";--addx
				when "011000" => 
					ALU_op <= "001000";--addxcc
					PSR_op <= "000001";
				when "010100" => 
					ALU_op <= "000001";--subcc
					PSR_op <= "000010";
				when "001100" => 
					ALU_op <= "001001";--subx
				when "011100" => 
					ALU_op <= "001001";--subxcc
					PSR_op <= "000010";
				when "010010" => 
					ALU_op <= "000010";--orcc
					PSR_op <= "000011";
				when "010001" => 
					ALU_op <= "000011";--andcc
					PSR_op <= "000011";
				when "010011" => 
					ALU_op <= "000100";--xorcc
					PSR_op <= "000011";
				when "010110" => 
					ALU_op <= "000101";--orNcc
					PSR_op <= "000011";
				when "010101" => 
					ALU_op <= "000110";--andNcc
					PSR_op <= "000011";
				when "010111" => 
					ALU_op <= "000111";--xnorcc
					PSR_op <= "000011";
				when others =>  
					ALU_OP <= "100000";--nop
					PSR_op <= "000000";
			end case;
		else 
			ALU_op <= "100000";
			PSR_op <= "000000";
		end if;
	end process;

end Behavioral;

