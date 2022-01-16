//==============================================================================
// Control Unit for PUnC LC3 Processor
//==============================================================================

`include "Defines.v"

module PUnCControl(
	// External Inputs
	input  wire        clk,            // Clock
	input  wire        rst,            // Reset
	
	// Add more ports here
	input wire[15:0] instruction, 
	output reg[4:0] state1
);

	// FSM States
	// Add your FSM State values as localparams here
	// localparam STATE_FETCH     = X'd0;
	
	localparam FETCH = 5'd0;
	localparam DECODE = 5'd1; 
	localparam ADD1 = 5'd2; 
	localparam ADD2 = 5'd3; 
	localparam AND1 = 5'd4;
	localparam AND2 = 5'd5;
	localparam BR = 5'd6;
	localparam JMP = 5'd7;
	localparam JSR1 = 5'd8; 
	localparam  JSR2 = 5'd9;
	localparam JSRR1 = 5'd10; 
	localparam JSRR2 = 5'd11;
	localparam LD = 5'd12;
	localparam LDI1 = 5'd13;
	localparam LDI2 = 5'd14;
	localparam LDR = 5'd15;
	localparam LEA = 5'd16;
	localparam NOT = 5'd17;
	localparam RET = 5'd18;
	localparam ST = 5'd19;
	localparam STI1 = 5'd20;
	localparam STI2 = 5'd21;
	localparam STR = 5'd22;
	localparam HALT = 5'd23; 



	// State, Next State
	// reg [X:0] state, next_state;
	reg [4:0] state; 
	reg [4:0] next_state; 

	// Output Combinational Logic
	always @( * ) begin
		// Set default values for outputs here (prevents implicit latching)

		// Add your output logic here
		//case (state)
		//	STATE_FETCH: begin
		//
		//	end
		//endcase
		if (state == FETCH) begin
			state1 = FETCH;
		end
		else if (state == DECODE) begin
			state1 = DECODE; 
		end
		else if (state == ADD1) begin
			state1 = ADD1; 
		end
		else if (state == ADD2) begin
			state1 = ADD2;
		end
		else if (state == AND1 ) begin
			state1 = AND1;
		end
		else if (state == AND2) begin
			state1 = AND2;
		end
		else if (state == BR) begin
			state1 = BR;
		end
		else if (state == JMP) begin
			state1 = JMP;
		end
		else if (state == JSR1) begin
			state1 = JSR1;
		end
		else if (state == JSR2) begin
			state1 = JSR2;
		end
		else if (state == JSRR1) begin
			state1 = JSRR1;
		end
		else if (state == JSRR2) begin
			state1 = JSRR2;
		end
		else if (state == LD) begin
			state1 = LD;
		end
		else if (state == LDI1) begin
			state1 = LDI1;
		end
		else if (state == LDI2) begin
			state1 = LDI2;
		end
		else if (state == LDR) begin
			state1 = LDR;
		end
		else if (state == LEA) begin
			state1 = LEA;
		end
		else if (state == NOT) begin
			state1 = NOT;
		end
		else if (state == RET) begin
			state1 = RET;
		end
		else if (state == ST) begin
			state1 = ST;
		end
		else if (state == STI1) begin
			state1 = STI1;
		end
		else if (state == STI2) begin
			state1 = STI2;
		end
		else if (state == STR) begin
			state1 = STR;
		end
		else if (state == HALT) begin
			state1 = HALT;
		end
	end

	// Next State Combinational Logic
	always @( * ) begin
		// Set default value for next state here
		next_state = state; 
		// Add your next-state logic here
		//case (state)
		//	STATE_FETCH: begin
		//
		//	end
		//endcase
		if (state == FETCH) begin
			next_state = DECODE;
		end
		else if (state == DECODE && instruction[`OC] == `OC_ADD && instruction[5] == 0) begin
			next_state = ADD1; 
		end
		else if (state == DECODE && instruction[`OC] == `OC_ADD && instruction[5] == 1) begin
			next_state = ADD2; 
		end
		else if (state == DECODE && instruction[`OC] == `OC_AND && instruction[5] == 0) begin
			next_state = AND1; 
		end
		else if (state == DECODE && instruction[`OC] == `OC_AND && instruction[5] == 1) begin
			next_state = AND2;
		end
		else if (state == DECODE && instruction[`OC] == `OC_BR) begin
			next_state = BR;
		end
		else if (state == DECODE && instruction[`OC] == `OC_JMP) begin
			next_state = JMP;
		end
		else if (state == DECODE && instruction[`OC] == `OC_JSR && instruction[11] == 1) begin
			next_state = JSR1;
		end
		else if (state == JSR1) begin
			next_state = JSR2;
		end
		else if (state == DECODE && instruction[`OC] == `OC_JSR && instruction[11] == 0) begin
			next_state = JSRR1;
		end
		else if (state == JSRR1) begin
			next_state = JSRR2;
		end
		else if (state == DECODE && instruction[`OC] == `OC_LD) begin
			next_state = LD;
		end
		else if (state == DECODE && instruction[`OC] == `OC_LDI) begin
			next_state = LDI1;
		end
		else if (state == LDI1) begin
			next_state = LDI2;
		end
		else if (state == DECODE && instruction[`OC] == `OC_LDR) begin
			next_state = LDR;
		end
		else if (state == DECODE && instruction[`OC] == `OC_LEA) begin
			next_state = LEA;
		end
		else if (state == DECODE && instruction[`OC] == `OC_NOT) begin
			next_state = NOT;
		end
		else if (state == DECODE && instruction[`OC] == `OC_ST) begin
			next_state = ST;
		end
		else if (state == DECODE && instruction[`OC] == `OC_STI) begin
			next_state = STI1;
		end
		else if (state == STI1) begin
			next_state = STI2;
		end
		else if (state == DECODE && instruction[`OC] == `OC_STR) begin
			next_state = STR;
		end
		else if (state == DECODE && instruction[`OC] == `OC_HLT) begin
			next_state = HALT;
		end
		else if (state == AND1 || state == AND2 || state == ADD1 || state == ADD2 || state == BR || state == JMP || state == JSR2 || state == JSRR2 || state == LD || state == LDI2 || state == LDR || state == LEA || state == NOT || state == ST || state == STI2 || state == STR) begin
			next_state = FETCH;
		end

	end

	// State Update Sequential Logic
	always @(posedge clk) begin
		if (rst) begin
			// Add your initial state here
			//state <= STATE_FETCH;
			state <= FETCH; 
		end
		else begin
			// Add your next state here
			//state <= next_state;
			state <= next_state; 
		end
	end

endmodule
