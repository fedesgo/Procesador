
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY TB_Mux IS
END TB_Mux;
 
ARCHITECTURE behavior OF TB_Mux IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mux
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Sc : IN  std_logic;
         Mux_Out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Sc : std_logic := '0';

 	--Outputs
   signal Mux_Out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux PORT MAP (
          A => A,
          B => B,
          Sc => Sc,
          Mux_Out => Mux_Out
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      
		A <= x"00000014";
		B <= x"00000008";
		Sc <= '0';
		wait for 20 ns;
		
		A <= x"00000014";
		B <= x"00000008";
		Sc <= '1';
		wait for 20 ns;
		
		A <= x"00000010";
		B <= x"0000000F";
		Sc <= '0';
		wait for 20 ns;
		
		A <= x"00000010";
		B <= x"0000000F";
		Sc <= '1';

      wait;
   end process;

END;
