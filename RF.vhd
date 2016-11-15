library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity RF is
    Port ( rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
           rst : in  STD_LOGIC;
			  we : in STD_LOGIC;
           DataToWrite : in  STD_LOGIC_VECTOR (31 downto 0);
           Crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Crs2 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Crd : out STD_LOGIC_VECTOR (31 downto 0));
end RF;

architecture Behavioral of RF is

type rf_type is array (0 to 39) of std_logic_vector (31 downto 0);
signal registers : rf_type :=(others => x"00000000");

begin
process(rs1,rs2,rd,rst,DataToWrite, registers)
	begin
		if (rst = '1') then
			Crs1 <= (others => '0');
			Crs2 <= (others => '0');
			Crd <= (others => '0');
			registers <= (others => x"00000000");
		else
			if (rd /= "000000" and we = '1') then
				registers(conv_integer(rd)) <= DataToWrite;
			end if;
			Crs1 <= registers(conv_integer(rs1));
			Crs2 <= registers(conv_integer(rs2));
			Crd <= registers(conv_integer(rd));
		end if;
	end process;

end Behavioral;

