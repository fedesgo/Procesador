library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Processor is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Pr_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Processor;

architecture Behavioral of Processor is

	COMPONENT Program_Counter
	PORT(
		In_PC : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;
		clk : IN std_logic;          
		Out_PC : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Adder
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);          
		Add_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT InstructionMem
	PORT(
		reg_address : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		OutInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT CU
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		ALU_op : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT RF
	PORT(
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		rst : IN std_logic;
		DataToWrite : IN std_logic_vector(31 downto 0);          
		Crs1 : OUT std_logic_vector(31 downto 0);
		Crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SEU
	PORT(
		SEU_in : IN std_logic_vector(12 downto 0);          
		SEU_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Mux
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		Sc : IN std_logic;          
		Mux_Out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Alu
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		AluOp : IN std_logic_vector(5 downto 0);          
		AluResult : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
signal AddTonPc, nPcToAdd, nPcToPc, PcToIM, IMtoRF, ALUToRF, RFToALU, RFToMux, SEUToMux, MuxToALU: std_logic_vector(31 downto 0);
signal CUToALU: std_logic_vector(5 downto 0);

begin

	Inst_nProgram_Counter: Program_Counter PORT MAP(
		In_PC => AddTonPc,
		Out_PC => nPcToPc,
		rst => rst,
		clk => clk
	);
	
	Inst_Program_Counter: Program_Counter PORT MAP(
		In_PC => nPcToPc,
		Out_PC => PcToIM,
		rst => rst,
		clk => clk
	);
	
	Inst_Adder: Adder PORT MAP(
		A => x"00000001",
		B => nPcToAdd,
		Add_out => AddTonPc
	);
	
	Inst_InstructionMem: InstructionMem PORT MAP(
		reg_address => PcToIM,
		rst => rst,
		OutInstruction => IMToRF
	);

	Inst_CU: CU PORT MAP(
		op => IMToRf(31 downto 30),
		op3 => IMToRF(24 downto 19),
		ALU_op => CUToALU
	);

	Inst_RF: RF PORT MAP(
		rs1 => IMToRF(18 downto 14),
		rs2 => IMToRF(4 downto 0),
		rd => IMToRF(29 downto 25),
		rst => rst,
		DataToWrite => ALUToRF,
		Crs1 => RFToALU,
		Crs2 => RFToMux
	);
	
	Inst_SEU: SEU PORT MAP(
		SEU_in => IMToRF(12 downto 0),
		SEU_out => SEUToMux
	);
	
	Inst_Mux: Mux PORT MAP(
		A => RFToMux,
		B => SEUToMux,
		Sc => IMToRF(13),
		Mux_Out => MuxToALU
	);

	Inst_Alu: Alu PORT MAP(
		A => RFToALU,
		B => MuxToALU,
		AluOp => CUToALU,
		AluResult => ALUToRF
	);
	
	Pr_out <= ALUToRF;
	
end Behavioral;

