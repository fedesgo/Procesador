library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MuxRegDest is
    Port ( Rdest : in  STD_LOGIC_VECTOR (5 downto 0);
           Ro7 : in  STD_LOGIC_VECTOR (5 downto 0);
           RdSelec : in  STD_LOGIC;
           nRd : out  STD_LOGIC_VECTOR (5 downto 0));
end MuxRegDest;

architecture Behavioral of MuxRegDest is

begin
	process(RdSelec, Rdest, Ro7)
	begin
		if(RdSelec = '0') then
			nRd <= Rdest;
		elsif(RdSelec = '1') then
			nRd <= Ro7;
		end if;
	end process;

end Behavioral;

