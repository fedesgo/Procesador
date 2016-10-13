
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY TB_InstructionMem IS
END TB_InstructionMem;
 
ARCHITECTURE behavior OF TB_InstructionMem IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT InstructionMem
    PORT(
         reg_address : IN  std_logic_vector(31 downto 0);
         rst : IN  std_logic;
         OutInstruction : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reg_address : std_logic_vector(31 downto 0) := (others => '0');
   signal rst : std_logic := '0';

 	--Outputs
   signal OutInstruction : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: InstructionMem PORT MAP (
          reg_address => reg_address,
          rst => rst,
          OutInstruction => OutInstruction
        );

 
 

   -- Stimulus process
   stim_proc: process
   begin
	
		rst <= '1';
		reg_address <= x"00000001";
      wait for 20 ns;	
		rst <= '0';
		reg_address <= x"0000000f";
		wait for 20 ns;
		reg_address <= x"0000003e";
		wait for 20 ns;
		reg_address <= x"00000026";
		wait for 20 ns;
     
      wait;
   end process;

END;
