library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU22 is
    Port ( SEU22_in : in  STD_LOGIC_VECTOR (21 downto 0);
           SEU22_out : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU22;

architecture Behavioral of SEU22 is

begin
	process(SEU_in)
	begin
		if SEU_in(21) = '1' then
			SEU_out(31 downto 22) <= (others=>'1');
		else
			SEU_out(31 downto 22) <= (others=>'0');
		end if;
		SEU_out(21 downto 0) <= SEU_in;
	end process;

end Behavioral;

