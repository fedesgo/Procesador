library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR is
    Port ( clk : in STD_LOGIC;
			  nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           carry : out  STD_LOGIC);
end PSR;

architecture Behavioral of PSR is

signal reg : std_logic_vector(3 downto 0) := (others =>'0');

begin

process(clk)
	begin
		if (rising_edge(clk)) then
			reg <= nzvc;
			carry <= reg(0);
		end if;
end process;

end Behavioral;

