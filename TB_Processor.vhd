LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_Processor IS
END TB_Processor;
 
ARCHITECTURE behavior OF TB_Processor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Processor
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         Pr_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal Pr_out : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Processor PORT MAP (
          rst => rst,
          clk => clk,
          Pr_out => Pr_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      rst <= '1';
      wait for 20 ns;
		rst <= '0';
		wait;
   end process;

END;
