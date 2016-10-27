library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR is
    Port ( clk : in STD_LOGIC;
			  nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
			  nCWP : in STD_LOGIC;
			  CWP : out STD_LOGIC;
           carry : out  STD_LOGIC);
end PSR;

architecture Behavioral of PSR is

signal reg : std_logic_vector(4 downto 0) := (others =>'0');

begin

process(clk)
	begin
		if (rising_edge(clk)) then
			reg(4) <= nCWP;
			reg(3 downto 0) <= nzvc;
			carry <= reg(0);
			CWP <= reg(4);
		end if;
end process;

end Behavioral;

