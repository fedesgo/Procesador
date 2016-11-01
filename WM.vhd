library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Win_man is
    Port ( rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rsd : in  STD_LOGIC_VECTOR (4 downto 0);
           op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           cwp : in  STD_LOGIC;
           ncwp : out  STD_LOGIC;
           srs1 : out  STD_LOGIC_VECTOR (5 downto 0);
           srs2 : out  STD_LOGIC_VECTOR (5 downto 0);
           srd : out  STD_LOGIC_VECTOR (5 downto 0));
end Win_man;

architecture Behavioral of Win_man is

signal rs1n: integer range 0 to 39:=0;
signal rs2n: integer range 0 to 39:=0;
signal rsdn: integer range 0 to 39:=0;


begin
process(cwp,rs1,rs2,rsd,op,op3)
begin

------Save-and-Restore------

	if (op="10" and op3="111100") then -- Save
		ncwp <= '0';
	else
		if (op="10" and op3="111101")then --Restore
			ncwp <= '1';
		end if;
	end if;


	----Evaluacion tipo de registro 1(rs1)----
	if(rs1>="00000" and rs1<="00111")then --Evaluacion de los registros globales
		rs1n <= conv_integer(rs1);
	else
		if(rs1 >= "11000" and rs1 <= "11111")then -- Evaluacion de los registros de entrada
			rs1n <= conv_integer(rs1) - (conv_integer(cwp)*16);
		else
			if(rs1 >= "10000" and rs1 <= "10111")then -- Evaluacion de los registros locales
				rs1n <= conv_integer(rs1)+(conv_integer(cwp)*16);
			else
				if(rs1 >= "01000" and rs1 <= "01111")then -- Evaluacion de los registros de salida
					rs1n <= conv_integer(rs1) + (conv_integer(cwp)*16);
				end if;
			end if;
		end if;
	end if;


	----Evaluacion tipo de registro 2(rs2)----

	if(rs2>="00000" and rs2<="00111")then --Evaluacion de los registros globales
		rs2n <= conv_integer(rs2);
	else
		if(rs2 >= "11000" and rs2 <= "11111")then -- Evaluacion de los registros de entrada
			rs2n <= conv_integer(rs2) - (conv_integer(cwp)*16);
		else
			if(rs2 >= "10000" and rs2 <= "10111")then -- Evaluacion de los registros locales
				rs2n <= conv_integer(rs2)+(conv_integer(cwp)*16);
			else
				if(rs2 >= "01000" and rs2 <= "01111")then -- Evaluacion de los registros de salida
					rs2n <= conv_integer(rs2) + (conv_integer(cwp)*16);
				end if;
			end if;
		end if;
	end if;


	----Evaluacion tipo de registro destino(rsd)----

	if(rsd>="00000" and rsd<="00111")then --Evaluacion de los registros globales
		rsdn <= conv_integer(rsd);
	else
		if(rsd >= "11000" and rsd <= "11111")then -- Evaluacion de los registros de entrada
			rsdn <= conv_integer(rsd) - (conv_integer(cwp)*16);
		else
			if(rsd >= "10000" and rsd <= "10111")then -- Evaluacion de los registros locales
				rsdn <= conv_integer(rsd)+(conv_integer(cwp)*16);
			else
				if(rsd >= "01000" and rsd <= "01111")then -- Evaluacion de los registros de salida
					rsdn <= conv_integer(rsd) + (conv_integer(cwp)*16);
				end if;
			end if;
		end if;
	end if;

-----------------------------------------------------------------
end process;

srs1 <= conv_std_logic_vector(rs1n,6);
srs2 <= conv_std_logic_vector(rs2n,6);
srd <= conv_std_logic_vector(rsdn,6);

end Behavioral;