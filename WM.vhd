library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Win_man is
    Port ( rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           cwp : in  STD_LOGIC;
           ncwp : out  STD_LOGIC;
           nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrd : out  STD_LOGIC_VECTOR (5 downto 0));
end Win_man;

architecture Behavioral of Win_man is

signal rs1n: integer range 0 to 39:=0;
signal rs2n: integer range 0 to 39:=0;
signal rdn: integer range 0 to 39:=0;


begin
process(cwp,rs1,rs2,rd,op,op3)
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


	----Evaluacion tipo de registro destino(rd)----

	if(rd>="00000" and rd<="00111")then --Evaluacion de los registros globales
		rdn <= conv_integer(rd);
	else
		if(rd >= "11000" and rd <= "11111")then -- Evaluacion de los registros de entrada
			rdn <= conv_integer(rd) - (conv_integer(cwp)*16);
		else
			if(rd >= "10000" and rd <= "10111")then -- Evaluacion de los registros locales
				rdn <= conv_integer(rd)+(conv_integer(cwp)*16);
			else
				if(rd >= "01000" and rd <= "01111")then -- Evaluacion de los registros de salida
					rdn <= conv_integer(rd) + (conv_integer(cwp)*16);
				end if;
			end if;
		end if;
	end if;

-----------------------------------------------------------------
end process;

nrs1 <= conv_std_logic_vector(rs1n,6);
nrs2 <= conv_std_logic_vector(rs2n,6);
nrd <= conv_std_logic_vector(rdn,6);

end Behavioral;