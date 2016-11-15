library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MuxPC is
    Port ( Address : in  STD_LOGIC_VECTOR (31 downto 0);
           Disp30 : in  STD_LOGIC_VECTOR (31 downto 0);
           Disp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           PCn : in  STD_LOGIC_VECTOR (31 downto 0);
           PCSelector : in  STD_LOGIC_VECTOR (1 downto 0);
           out_MuxPC : out  STD_LOGIC_VECTOR (31 downto 0));
end MuxPC;

architecture Behavioral of MuxPC is

begin

	process(Addres,Disp30,Disp22,PC,PCSelector)
	begin
		case PCSelector is 
			when "00" =>
				out_MuxPC <= Address;
			when "01" =>
				out_MuxPC <= Disp30;
			when "10" =>
				out_MuxPC <= Disp22;
			when "11" =>
				out_MuxPC <= PCn;
		end case;
	end process;

end Behavioral;

