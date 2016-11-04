
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;

entity InstructionMem is
    Port ( reg_address : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           OutInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end InstructionMem;

architecture Behavioral of InstructionMem is

	type rom_type is array (0 to 63) of std_logic_vector (31 downto 0);
		
	impure function InitRomFromFile (RomFileName : in string) return rom_type is
		FILE RomFile : text open read_mode is RomFileName;
		variable RomFileLine : line;
		variable temp_bv : bit_vector(31 downto 0);
		variable temp_mem : rom_type;
		begin
			for I in rom_type'range loop
				readline (RomFile, RomFileLine);
				read(RomFileLine, temp_bv);
				temp_mem(i) := to_stdlogicvector(temp_bv);
			end loop;
		return temp_mem;
	end function;
	
	signal instruction : rom_type := InitRomFromFile("Prueba4.txt");

begin
	process(rst,reg_address, instruction)
	begin
			if(rst = '1')then
				outInstruction <= (others=>'0');
			else
				outInstruction <= instruction(conv_integer(reg_address(5 downto 0)));
			end if;
	end process;

end Behavioral;

