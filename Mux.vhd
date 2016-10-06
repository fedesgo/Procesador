
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Sc : in  STD_LOGIC;
           Mux_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux;

architecture Behavioral of Mux is

begin
	
	Mux_Out <= A WHEN Sc ='0' ELSE B;

end Behavioral;