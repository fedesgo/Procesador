library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU30 is
    Port ( SEU30_in : in  STD_LOGIC_VECTOR (29 downto 0);
           SEU30_out : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU30;

architecture Behavioral of SEU30 is

begin
	process(SEU_in)
	begin
		if SEU_in(29) = '1' then
			SEU_out(31 downto30) <= (others=>'1');
		else
			SEU_out(31 downto 30) <= (others=>'0');
		end if;
		SEU_out(29 downto 0) <= SEU_in;
	end process;

end Behavioral;

