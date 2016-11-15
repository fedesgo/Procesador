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
		op2 : IN std_logic_vector(2 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		cond : IN std_logic_vector(3 downto 0);
		icc : IN std_logic_vector(3 downto 0);          
		ALU_op : OUT std_logic_vector(5 downto 0);
		RFDest : OUT std_logic;
		RFSource : OUT std_logic_vector(1 downto 0);
		WrEnMem : OUT std_logic;
		PCSource : OUT std_logic_vector(1 downto 0);
		WrEnRF : OUT std_logic_vector(1 downto 0);
		PSR_op : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT RF
	PORT(
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		rd : IN std_logic_vector(5 downto 0);
		rst : IN std_logic;
		we : IN std_logic;
		DataToWrite : IN std_logic_vector(31 downto 0);          
		Crs1 : OUT std_logic_vector(31 downto 0);
		Crs2 : OUT std_logic_vector(31 downto 0);
		Crd : OUT std_logic_vector(31 downto 0)
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
		C : IN std_logic;          
		AluResult : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	-----------------------VERSION3-------------------
	COMPONENT PSR_M
	PORT(
		op1 : IN std_logic;
		op2 : IN std_logic;
		ALUr : IN std_logic_vector(31 downto 0);
		PSR_op : IN std_logic_vector(5 downto 0);          
		nzvc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT PSR
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		nzvc : IN std_logic_vector(3 downto 0);
		nCWP : IN std_logic;          
		CWP : OUT std_logic;
		carry : OUT std_logic;
		icc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	
	-----------------------VERISON4-------------------
	COMPONENT WM
	PORT(
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		cwp : IN std_logic;          
		ncwp : OUT std_logic;
		nrs1 : OUT std_logic_vector(5 downto 0);
		nrs2 : OUT std_logic_vector(5 downto 0);
		nrd : OUT std_logic_vector(5 downto 0);
		rego7 : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	-----------------------VERSION6--------------------
	COMPONENT DataMemory
	PORT(
		Address : IN std_logic_vector(4 downto 0);
		DataToStore : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;
		WE : IN std_logic;          
		ContentMem : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT MuxPC
	PORT(
		Address : IN std_logic_vector(31 downto 0);
		Disp30 : IN std_logic_vector(31 downto 0);
		Disp22 : IN std_logic_vector(31 downto 0);
		PCn : IN std_logic_vector(31 downto 0);
		PCSelector : IN std_logic_vector(1 downto 0);          
		out_MuxPC : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT MuxRF
	PORT(
		DataMemory : IN std_logic_vector(31 downto 0);
		AluResult : IN std_logic_vector(31 downto 0);
		PC : IN std_logic_vector(31 downto 0);
		RFSource : IN std_logic_vector(1 downto 0);
		out_MuxRF : IN std_logic_vector(31 downto 0);       
		);
	END COMPONENT;
	
	COMPONENT MuxRegDest
	PORT(
		Rdest : IN std_logic_vector(5 downto 0);
		Ro7 : IN std_logic_vector(5 downto 0);
		RdSelec : IN std_logic;          
		nRd : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SEU22
	PORT(
		SEU22_in : IN std_logic_vector(21 downto 0);          
		SEU22_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SEU30
	PORT(
		SEU30_in : IN std_logic_vector(29 downto 0);          
		SEU30_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

signal AddTonPc, nPcToAdd, AddConst, PcToIM, IMtoRF, ALUToRF, RFToALU, RFToMux, SEUToMux, MuxToALU: std_logic_vector(31 downto 0);
signal CUToALU, CUToPSRM, WMnrs1, WMnrs2, WMnrd: std_logic_vector(5 downto 0);
signal PSRMToPSR : std_logic_vector(3 downto 0);
signal aux_carry, PSRtoWM, WMtoPSR : std_logic;

begin

	Inst_nProgram_Counter: Program_Counter PORT MAP(
		In_PC => AddTonPc,
		Out_PC => nPcToAdd,
		rst => rst,
		clk => clk
	);
	
	Inst_Program_Counter: Program_Counter PORT MAP(
		In_PC => nPcToAdd,
		Out_PC => PcToIM,
		rst => rst,
		clk => clk
	);
	
AddConst <= x"00000001";
	
	Inst_Adder: Adder PORT MAP(
		A => AddConst,
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
		op2 => ,
		op3 => IMToRF(24 downto 19),
		cond => ,
		icc => ,
		ALU_op => CUToALU,
		RFDest => ,
		RFSource => ,
		WrEnMem => ,
		PCSource => ,
		WrEnRF => ,
		PSR_op => CUToPSRM
	);

	Inst_RF: RF PORT MAP(
		rs1 => WMnrs1,
		rs2 => WMnrs2,
		rd => WMnrd,
		rst => rst,
		we => ,
		DataToWrite => ALUToRF,
		Crs1 => RFToALU,
		Crs2 => RFToMux,
		Crd => 
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
		C => aux_carry,
		AluOp => CUToALU,
		AluResult => ALUToRF
	);
	
	Inst_PSR_M: PSR_M PORT MAP(
		op1 => RFToALU(31),
		op2 => MuxToALU(31),
		ALUr => ALUToRF,
		PSR_op => CUToPSRM,
		nzvc => PSRMToPSR
	);
	
	Inst_PSR: PSR PORT MAP(
		clk => clk,
		rst => rst,
		nzvc => PSRMToPSR,
		nCWP => WMtoPSR,
		CWP => PSRtoWM,
		carry => aux_carry,
		icc => 
	);
	
	Inst_WM: WM PORT MAP(
		rs1 => IMToRF(18 downto 14),
		rs2 => IMToRF(4 downto 0),
		rd => IMToRF(29 downto 25),
		op => IMToRf(31 downto 30),
		op3 => IMToRf(24 downto 19),
		cwp => PSRtoWM,
		ncwp => WMtoPSR,
		nrs1 => WMnrs1,
		nrs2 => WMnrs2,
		nrd => WMnrd
	);
	
	Inst_DataMemory: DataMemory PORT MAP(
		Address => ,
		DataToStore => ,
		rst => ,
		WE => ,
		ContentMem => 
	);

	Inst_MuxPC: MuxPC PORT MAP(
		Address => ,
		Disp30 => ,
		Disp22 => ,
		PCn => ,
		PCSelector => ,
		out_MuxPC => 
	);
	
	Inst_MuxRF: MuxRF PORT MAP(
		DataMemory => ,
		AluResult => ,
		PC => PcToIM,
		RFSource => ,
		out_MuxRF => 
	);

	Inst_MuxRegDest: MuxRegDest PORT MAP(
		Rdest => ,
		Ro7 => ,
		RdSelec => ,
		nRd => 
	);
	
	Inst_SEU22: SEU22 PORT MAP(
		SEU22_in => IMtoRF(21 downto 0),
		SEU22_out => SEU22toAdd22
	);
	
	Inst_Adder22: Adder PORT MAP(
		A => SEU22toAdd22,
		B => PcToIM,
		Add_out => 
	);
	
	Inst_SEU30: SEU30 PORT MAP(
		SEU30_in => IMtoRF(29 downto 0),
		SEU30_out => SEU30toAdd30
	);
	
	Inst_Adder30: Adder PORT MAP(
		A => SEU30toAdd30,
		B => PcToIM,
		Add_out => 
	);
	
	Pr_out <= ALUToRF;
	
end Behavioral;

