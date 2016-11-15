library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MuxRF is
    Port ( DataMemory : in  STD_LOGIC_VECTOR (31 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           RFSource : in  STD_LOGIC_VECTOR (1 downto 0);
           out_MuxRF : in  STD_LOGIC_VECTOR (31 downto 0));
end MuxRF;

architecture Behavioral of MuxRF is

begin

	process(DataMemory,AluResult,PC,RFsource)
	begin
		case RFSource is 
      when "00" =>
         out_MuxRF <= DataMemory;
      when "01" =>
         out_MuxRF <= AluResult;
      when "10" =>
         out_MuxRF <= PC;
		end case;
	end process;

end Behavioral;

