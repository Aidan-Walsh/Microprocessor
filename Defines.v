//==============================================================================
// Global Defines for PUnC LC3 Computer
//==============================================================================

// Add defines here that you'll use in both the datapath and the controller

//------------------------------------------------------------------------------
// Opcodes
//------------------------------------------------------------------------------
`define OC 15:12       // Used to select opcode bits from the IR

`define OC_ADD 4'b0001 // Instruction-specific opcodes
`define OC_AND 4'b0101
`define OC_BR  4'b0000
`define OC_JMP 4'b1100
`define OC_JSR 4'b0100
`define OC_LD  4'b0010
`define OC_LDI 4'b1010
`define OC_LDR 4'b0110
`define OC_LEA 4'b1110
`define OC_NOT 4'b1001
`define OC_ST  4'b0011
`define OC_STI 4'b1011
`define OC_STR 4'b0111
`define OC_HLT 4'b1111

`define IMM_BIT_NUM 5  // Bit for distinguishing ADDR/ADDI and ANDR/ANDI
`define IS_IMM 1'b1
`define JSR_BIT_NUM 11 // Bit for distinguishing JSR/JSRR
`define IS_JSR 1'b1

`define BR_N 11        // Location of special bits in BR instruction
`define BR_Z 10
`define BR_P 9

`define FETCH 5'b00000;
`define DECODE 5'd1; 
`define ADD1 5'd2; 
`define ADD2 5'd3; 
`define AND1 5'd4;
`define AND2 5'd5;
`define BR 5'd6;
`define JMP 5'd7;
`define JSR1 5'd8; 
`define JSR2 5'd9;
`define JSRR1 5'd10; 
`define JSRR2 5'd11;
`define LD 5'd12;
`define LDI1 5'd13;
`define LDI2 5'd14;
`define LDR 5'd15;
`define LEA 5'd16;
`define NOT 5'd17;
`define RET 5'd18;
`define ST 5'd19;
`define STI1 5'd20;
`define STI2 5'd21;
`define STR 5'd22;
`define HALT 5'd23;

