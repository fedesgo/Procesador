library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RF is
    Port ( rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           rst : in  STD_LOGIC;
           DataToWrite : in  STD_LOGIC_VECTOR (31 downto 0);
           Crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Crs2 : out  STD_LOGIC_VECTOR (31 downto 0));
end RF;

architecture Behavioral of RF is

type rf_type is array (0 to 31) of std_logic_vector (31 downto 0);
signal registers : rf_type :=(others => x"00000000");

begin
process(rs1,rs2,rd,rst,DataToWrite)
	begin
		if (rst = '1') then
			Crs1 <= (others => '0');
			Crs2 <= (others => '0');
			registers <= (others => x"00000000");
		elsif (rd /= "00000") then
			registers(conv_integer(rd)) <= DataToWrite;
		end if;
		Crs1 <= registers(conv_integer(rs1));
		Crs2 <= registers(conv_integer(rs2));
	end process;

end Behavioral;

