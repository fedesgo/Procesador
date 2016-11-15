library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DataMemory is
    Port ( Address : in  STD_LOGIC_VECTOR (4 downto 0);
           DataToStore : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           ContentMem : out  STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is

type mem_type is array (0 to 31) of std_logic_vector (31 downto 0);
signal memory : mem_type:=(others => x"00000000");

begin

	process(Address,DataToStore,rst,WE)
	begin
		if(rst = '1')then
			ContentMem <= (others => '0');
			memory<= (others => x"00000000");
		else
			ContentMem <= memory(conv_integer(Address));
			if(WE = '1')then
				memory(conv_integer(Address))<= DataToStore;
			end if;
		end if;
	end process;


end Behavioral;

