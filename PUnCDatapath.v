//==============================================================================
// Datapath for PUnC LC3 Processor
//==============================================================================

`include "Memory.v"
`include "RegisterFile.v"
`include "Defines.v"

module PUnCDatapath(
	// External Inputs
	input  wire        clk,            // Clock
	input  wire        rst,            // Reset

	// DEBUG Signals
	input  wire [15:0] mem_debug_addr,
	input  wire [2:0]  rf_debug_addr,
	output wire [15:0] mem_debug_data,
	output wire [15:0] rf_debug_data,
	output wire [15:0] pc_debug_data,

	// Add more ports here
	input[4:0] state,
	output[15:0] instruction
);

	// Local Registers
	reg  [15:0] pc = 0;
	reg  [15:0] ir;
	reg [15:0]r_mem_addr_0;
	wire [15:0]r_mem_data_0; 
	reg [2:0]r_rf_addr_0;
	reg [2:0]r_rf_addr_1;
	reg [2:0]w_rf_addr;
	reg [15:0]w_rf_data;
	reg w_rf_en;
	wire [15:0]r_rf_data_0;
	wire [15:0]r_rf_data_1;
	reg [15:0]w_mem_addr_0; 
	reg [15:0]w_mem_data; 
	reg w_mem_en; 
	reg [15:0] added; 
	reg N = 0; 
	reg Z = 0; 
	reg P = 0;
	reg [15:0]intermediate;

	// Declare other local wires and registers here

	// Assign PC debug net
	assign pc_debug_data = pc;
	assign instruction = ir; 
	

	//----------------------------------------------------------------------
	// Memory Module
	//----------------------------------------------------------------------

	// 1024-entry 16-bit memory (connect other ports)
	Memory mem(
		.clk      (clk),
		.rst      (rst),
		.r_addr_0 (r_mem_addr_0),
		.r_addr_1 (mem_debug_addr),
		.w_addr   (w_mem_addr_0),
		.w_data   (w_mem_data),
		.w_en     (w_mem_en),
		.r_data_0 (r_mem_data_0),
		.r_data_1 (mem_debug_data)
	);

	//----------------------------------------------------------------------
	// Register File Module
	//----------------------------------------------------------------------

	// 8-entry 16-bit register file (connect other ports)
	RegisterFile rfile(
		.clk      (clk),
		.rst      (rst),
		.r_addr_0 (r_rf_addr_0),
		.r_addr_1 (r_rf_addr_1),
		.r_addr_2 (rf_debug_addr),
		.w_addr   (w_rf_addr),
		.w_data   (w_rf_data),
		.w_en     (w_rf_en),
		.r_data_0 (r_rf_data_0),
		.r_data_1 (r_rf_data_1),
		.r_data_2 (rf_debug_data)
	);

	//----------------------------------------------------------------------
	// Add all other datapath logic here
	//----------------------------------------------------------------------
	
	always @(posedge clk) begin
		if (state == 5'd0) begin // fetch
			  ir <= r_mem_data_0;
			// r_mem_addr_0 <= pc; 
			
		end
		if (state == 5'd1) begin // decode
			pc <= pc + 1; 
		end
		 if (state == 5'd2) begin // add i
			// r_rf_addr_0 <= ir[8:6]; 
			// r_rf_addr_1 <= ir[2:0];
			// w_rf_addr <= ir[11:9]; 
			if (w_rf_data == 16'd0) begin // setcc
				Z <= 1;
				N <= 0; 
				P <= 0;  
				
			end
			else if (w_rf_data[15] == 1) begin
				N <= 1; 
				P <= 0; 
				Z <= 0; 
				 
			end
			else begin
				P <= 1; 
				Z <= 0; 
				N <= 0; 
				 
			end
		end 
		if (state == 5'd3) begin // add ii
				if (w_rf_data == 16'd0) begin // setcc
				Z <= 1;
				N <= 0; 
				P <= 0;  
				
			end
			else if (w_rf_data[15] == 1) begin
				N <= 1; 
				P <= 0; 
				Z <= 0; 
				
			end
			else begin
				P <= 1; 
				Z <= 0; 
				N <= 0; 
				
			end
		end
		
		if (state == 5'd4) begin // and i
			// r_rf_addr_0 <= ir[8:6]; 
			// r_rf_addr_1 <= ir[2:0];
			// w_rf_addr <= ir[11:9]; 
			if (w_rf_data == 16'd0) begin // setcc
				Z <= 1;
				N <= 0; 
				P <= 0;  
			end
			else if (w_rf_data[15] == 1) begin
				N <= 1; 
				P <= 0; 
				Z <= 0; 
			end
			else begin
				P <= 1; 
				Z <= 0; 
				N <= 0; 
			end
		end
		if (state == 5'd5) begin // and ii
			// r_rf_addr_0 <= ir[8:6]; 
			// w_rf_addr <= ir[11:9]; 
			if (w_rf_data == 16'd0) begin // setcc
				Z <= 1;
				N <= 0; 
				P <= 0;  
			end
			else if (w_rf_data[15] == 1) begin
				N <= 1; 
				P <= 0; 
				Z <= 0; 
			end
			else begin
				P <= 1; 
				Z <= 0; 
				N <= 0; 
			end
		end
		if (state == 5'd6) begin // br
			
		end
		if (state == 5'd7) begin // jmp
			// r_rf_addr_0 <= ir[8:6]; 
		end
		if (state == 5'd8) begin // jsr i
			//w_rf_addr <= 111;
			//w_rf_data <= pc; 
		end
		if (state == 5'd9) begin // jsr ii
			
		end
		if (state == 5'd10) begin // jsrr i 
			//w_rf_addr <= 111;
			//w_rf_data <= pc; 
		end
		 if (state == 5'd11) begin // jsrr ii
			//r_rf_addr_0 <= ir[8:6]; 
		end
		if (state == 5'd12) begin // ld
			//w_rf_addr <= ir[11:9];
			if (r_mem_data_0 == 16'd0) begin // setcc
				Z <= 1;
				N <= 0; 
				P <= 0;  
			end
			else if (r_mem_data_0[15] == 1) begin
				N <= 1; 
				P <= 0; 
				Z <= 0; 
			end
			else begin
				P <= 1; 
				Z <= 0; 
				N <= 0; 
			end
			
		end
		if (state == 5'd13) begin // ldi i 
			
		end
		if (state == 5'd14) begin // ldi ii
			// w_rf_addr <= ir[11:9];
			if (r_mem_data_0 == 16'd0) begin // setcc
				Z <= 1;
				N <= 0; 
				P <= 0;  
			end
			else if (r_mem_data_0[15] == 1) begin
				N <= 1; 
				P <= 0; 
				Z <= 0; 
			end
			else begin
				P <= 1; 
				Z <= 0; 
				N <= 0; 
			end
		end
		if (state == 5'd15) begin // ldr
			//w_rf_addr <= ir[11:9];
			//r_rf_addr_0 <= ir[8:6]; 
			if (r_mem_data_0 == 16'd0) begin // setcc
				Z <= 1;
				N <= 0; 
				P <= 0;  
			end
			else if (r_mem_data_0[15] == 1) begin
				N <= 1; 
				P <= 0; 
				Z <= 0; 
			end
			else begin
				P <= 1; 
				Z <= 0; 
				N <= 0; 
			end
		end
		if (state == 5'd16) begin // lea
			//w_rf_addr <= ir[11:9];
			if (w_rf_data== 16'd0) begin // setcc
				Z <= 1;
				N <= 0; 
				P <= 0;   
			end
			else if (w_rf_data[15] == 1) begin
				N <= 1; 
				P <= 0; 
				Z <= 0; 
			end
			else begin
				P <= 1; 
				Z <= 0; 
				N <= 0; 
			end
		end
		if (state == 5'd17) begin // not
			//w_rf_addr <= ir[11:9];
			//r_rf_addr_0 <= ir[8:6]; 
			if (w_rf_data== 16'd0) begin // setcc
				Z <= 1;
				N <= 0; 
				P <= 0;    
			end
			else if (w_rf_data[15] == 1) begin
				N <= 1; 
				P <= 0; 
				Z <= 0; 
			end
			else begin
				P <= 1; 
				Z <= 0; 
				N <= 0;  
			end
		end
		/*if (state == 5'd18) begin // ret
			//r_rf_addr_0 <= 111; 
		end
		if (state == 5'd19) begin // st
			//r_rf_addr_0 <= ir[11:9]; 
		end
		if (state == 5'd20) begin // sti i
			
		end
		if (state == 5'd21) begin // sti ii
			r_rf_addr_0 <= ir[11:9];
			
		end
		if (state == 5'd22) begin // str
			r_rf_addr_0 <= ir[8:6]; 
			r_rf_addr_1 <= ir[11:9]; 
		end 
		if (state == 5'd23) begin // halt
			
		end  */
	end
 
	always @(*) begin
		w_rf_en = 0; 
		w_mem_en = 0; 
		added = 0; 
	
		if (state == 5'd0) begin // fetch
			  // ir = r_mem_data_0;
			  r_mem_addr_0 = pc; 
		end
		if (state == 5'd1) begin // decode
			
		end
		if (state == 5'd2) begin // add i
			 r_rf_addr_0 = ir[8:6]; 
			 r_rf_addr_1 = ir[2:0];
			w_rf_addr = ir[11:9]; 
			w_rf_en = 1; 
			w_rf_data = r_rf_data_0 + r_rf_data_1; 
			
		end
		if (state == 5'd3) begin // add ii
			w_rf_en = 1; 
			r_rf_addr_0 = ir[8:6]; 
			w_rf_addr = ir[11:9]; 
			if (ir[4] == 1) begin // extend
				added[15:4] = 12'b111111111111;
			end else begin
				added[15:4] = 12'd0; 
			end
			added[3:0] = ir[3:0];
			w_rf_data = r_rf_data_0 + added; 
		
		end
		if (state == 5'd4) begin // and i
			r_rf_addr_0 = ir[8:6]; 
			r_rf_addr_1 = ir[2:0];
			w_rf_addr = ir[11:9]; 
			w_rf_en = 1; 
			w_rf_data = r_rf_data_0 & r_rf_data_1; 
		end
		if (state == 5'd5) begin // and ii
			r_rf_addr_0 = ir[8:6]; 
			w_rf_addr = ir[11:9]; 
			w_rf_en = 1; 
			if (ir[4] == 1) begin // extend
				added[15:4] = 12'b111111111111;
			end else begin
				added[15:4] = 12'd0; 
			end
			added[3:0] = ir[3:0];
			w_rf_data = r_rf_data_0 & added; 
			
		end
		if (state == 5'd6) begin // br
			if ((ir[11] & N) | (ir[10] & Z) | (ir[9] & P)) begin
				if (ir[8] == 1) begin // extend
				added[15:8] = 8'b11111111;
				end else begin
				added[15:8] = 8'd0; 
				end
				added[7:0] = ir[7:0];
				pc = pc + added; 
			end
		end
		if (state == 5'd7) begin // jmp
			r_rf_addr_0 = ir[8:6];
			pc = r_rf_data_0; 
			 
		end
		if (state == 5'd8) begin //jsr i 
			w_rf_addr = 111;
			w_rf_data = pc; 
			w_rf_en = 1;   
		end
		if (state == 5'd9) begin // jsr ii
			if (ir[10] == 1) begin // extend
				added[15:10] = 6'b111111;
			end else begin
				added[15:10] = 12'd0; 
			end
			added[9:0] = ir[9:0];
			pc = pc + added; 
		end
			
		
		if (state == 5'd10) begin // jsrr i
			w_rf_en = 1;  
			w_rf_addr = 111;
			w_rf_data = pc; 
		end 
		if (state == 5'd11) begin // jsrr ii
			pc = r_rf_data_0;
			r_rf_addr_0 = ir[8:6];  
		end
		if (state == 5'd12) begin // ld 
			w_rf_en = 1; 
			w_rf_addr <= ir[11:9];
			if (ir[8] == 1) begin // extend
				added[15:8] = 8'b11111111;
			end else begin
				added[15:8] = 8'd0; 
			end
			added[7:0] = ir[7:0];

			r_mem_addr_0 = pc + added; 
			w_rf_data = r_mem_data_0; 
			
		end
		if (state == 5'd13) begin // ldi i
			 
			if (ir[8] == 1) begin // extend
				added[15:8] = 8'b11111111;
			end else begin
				added[15:8] = 8'd0; 
			end
			added[7:0] = ir[7:0];

			r_mem_addr_0 = pc + added; 
			intermediate = r_mem_data_0; 
		end
		if (state == 5'd14) begin // ldi ii
			w_rf_en = 1;
			w_rf_addr = ir[11:9];
			r_mem_addr_0 = intermediate; 
			w_rf_data = r_mem_data_0; 
		end
		if (state == 5'd15) begin // ldr
			w_rf_en = 1; 
				w_rf_addr = ir[11:9];
			r_rf_addr_0 = ir[8:6]; 
			if (ir[5] == 1) begin // extend
				added[15:5] = 11'b11111111111;
			end else begin
				added[15:5] = 11'd0; 
			end
			added[4:0] = ir[4:0];
			r_mem_addr_0 = r_rf_data_0 + added; 
			w_rf_data = r_mem_data_0; 
		end
		if (state == 5'd16) begin // lea
			w_rf_en = 1; 
			w_rf_addr = ir[11:9];
			if (ir[8] == 1) begin // extend
				added[15:8] = 8'b11111111;
			end else begin
				added[15:8] = 8'd0; 
			end
			added[7:0] = ir[7:0];
			w_rf_data = added + pc; 
		
		end
		if (state == 5'd17) begin // not
			w_rf_en = 1; 
				w_rf_addr = ir[11:9];
			r_rf_addr_0 = ir[8:6]; 
			w_rf_data = ~r_rf_data_0; 
			
		end
		if (state == 5'd18) begin // ret
			pc = r_rf_data_0; 
			r_rf_addr_0 = 111; 
		end
		if (state == 5'd19) begin // st
			w_mem_en = 1; 
			r_rf_addr_0 = ir[11:9]; 
			if (ir[8] == 1) begin // extend
				added[15:8] = 8'b11111111;
			end else begin
				added[15:8] = 8'd0; 
			end
			added[7:0] = ir[7:0];
			w_mem_addr_0 = pc + added; 
			w_mem_data = r_rf_data_0; 
		end
		if (state == 5'd20) begin // sti i
			if (ir[8] == 1) begin // extend
				added[15:8] = 8'b11111111;
			end else begin
				added[15:8] = 8'd0; 
			end
			added[7:0] = ir[7:0];
			r_mem_addr_0 = pc + added; 
			intermediate = r_mem_data_0; 
		end
		if (state == 5'd21) begin // sti ii
			w_mem_en = 1; 
			r_rf_addr_0 = ir[11:9];
			w_mem_addr_0 = intermediate; 
			w_mem_data = r_rf_data_0; 
		end
		if (state == 5'd22) begin // str
			w_mem_en = 1; 
			r_rf_addr_0 = ir[8:6]; 
			r_rf_addr_1 = ir[11:9]; 
			if (ir[5] == 1) begin // extend
				added[15:5] = 11'b11111111111;
			end else begin
				added[15:5] = 11'd0; 
			end
			added[4:0] = ir[4:0];
			w_mem_addr_0 = added + r_rf_data_0;
			w_mem_data = r_rf_data_1; 
		end
		if (state == 5'd23) begin // halt	
		end
		if (rst == 1) begin
			pc = 0; 
			Z = 0; 
			P = 0; 
			N = 0; 
		end
	end
endmodule
