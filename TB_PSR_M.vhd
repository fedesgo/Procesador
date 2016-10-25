LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_PSR_M IS
END TB_PSR_M;
 
ARCHITECTURE behavior OF TB_PSR_M IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSR_M
    PORT(
         op1 : IN  std_logic;
         op2 : IN  std_logic;
         ALUr : IN  std_logic_vector(31 downto 0);
         PSR_op : IN  std_logic_vector(5 downto 0);
         nzvc : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op1 : std_logic := '0';
   signal op2 : std_logic := '0';
   signal ALUr : std_logic_vector(31 downto 0) := (others => '0');
   signal PSR_op : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal nzvc : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR_M PORT MAP (
          op1 => op1,
          op2 => op2,
          ALUr => ALUr,
          PSR_op => PSR_op,
          nzvc => nzvc
        );

   -- Stimulus process
   stim_proc: process
   begin
		-----ADDXCC & ADDCC-----
      op1 <= '0';
		op2 <= '0';
		-----bit Z---------
		ALUr <= x"00000000";
		PSR_op <= "000000";
		wait for 20 ns;
		PSR_op <= "000001";
		wait for 20 ns;
		PSR_op <= "000010";
		wait for 20 ns;
		PSR_op <= "000000";
		ALUr <= x"00000004";
		wait for 20 ns;
		------ bit N --------
		ALUr <= x"F0000000";
		wait for 20 ns;
		------- bit V -------
		op1 <= '1';
		op2 <= '1';
		ALUr <= x"000F0000";
		wait for 20 ns;
		op1 <= '0';
		op2 <= '0';
		ALUr <= x"F0000000";
		wait for 20 ns;
		------- bit C -------
		op1 <= '1';
		ALUr <= x"00A00000";
		wait;
   end process;

END;
