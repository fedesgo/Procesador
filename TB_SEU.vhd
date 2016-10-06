LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_SEU IS
END TB_SEU;
 
ARCHITECTURE behavior OF TB_SEU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SEU
    PORT(
         SEU_in : IN  std_logic_vector(12 downto 0);
         SEU_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal SEU_in : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal SEU_out : std_logic_vector(31 downto 0);
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SEU PORT MAP (
          SEU_in => SEU_in,
          SEU_out => SEU_out
        );

   -- Stimulus process
   stim_proc: process
   begin		
		SEU_in <= "1110010000010";
      wait for 20 ns;
		SEU_in <= "0111111111111";
		wait for 20 ns;
		SEU_in <= "1111111111111";
		wait for 20 ns;
   end process;

END;
