library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Program_Counter is
    Port ( In_PC : in  STD_LOGIC_VECTOR (31 downto 0);
           Out_PC : out  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC);
end Program_Counter;

architecture Behavioral of Program_Counter is

--signal Data : std_logic_vector(31 downto 0)

begin

process(clk, rst)
begin
	if(rst = '1') then
		Out_PC <= "00000000000000000000000000000000";
	elsif rising_edge(clk) then
		Out_PC <= In_PC;
	end if;
end process;

end Behavioral;

