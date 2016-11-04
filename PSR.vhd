library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR is
    Port ( clk : in STD_LOGIC;
			  rst: in STD_LOGIC;
			  nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
			  nCWP : in STD_LOGIC;
			  CWP : out STD_LOGIC;
           carry : out  STD_LOGIC);
end PSR;

architecture Behavioral of PSR is

---signal reg : std_logic_vector(4 downto 0) := (others =>'0');

begin

process(clk)
	begin
		if (rising_edge(clk)) then
			if(rst = '1') then
				CWP <= '0';
				carry <= '0';
			else
	--			reg(4) <= nCWP;
	--			reg(3 downto 0) <= nzvc;
				carry <= nzvc(0);
				CWP <= nCWP;
			end if;
		end if;
end process;

end Behavioral;

