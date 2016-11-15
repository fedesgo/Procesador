library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU is
    Port ( SEU_in : in  STD_LOGIC_VECTOR (12 downto 0);
           SEU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU;

architecture Behavioral of SEU is

begin
	process(SEU_in)
	begin
		if SEU_in(12) = '1' then
			SEU_out(31 downto 13) <= (others=>'1');
		else
			SEU_out(31 downto 13) <= (others=>'0');
		end if;
		SEU_out(12 downto 0) <= SEU_in;
	end process;

end Behavioral;

