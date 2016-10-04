LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_Program_Counter IS
END TB_Program_Counter;
 
ARCHITECTURE behavior OF TB_Program_Counter IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Program_Counter
    PORT(
         In_PC : IN  std_logic_vector(31 downto 0);
         Out_PC : OUT  std_logic_vector(31 downto 0);
         rst : IN  std_logic;
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal In_PC : std_logic_vector(31 downto 0) := (others => '0');
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal Out_PC : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Program_Counter PORT MAP (
          In_PC => In_PC,
          Out_PC => Out_PC,
          rst => rst,
          clk => clk
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
      In_PC <= x"00000206";
		wait for 20 ns;
		In_PC <= X"00000207";
		wait for 20 ns;
		In_PC <= X"00000208";
		wait for 20 ns;
		rst <= '1';
		In_PC <= X"00000001";
		wait for 20 ns;
		rst <= '1';
		wait;
   end process;

END;
