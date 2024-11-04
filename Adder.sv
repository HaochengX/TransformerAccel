`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2024 03:06:27 PM
// Design Name: 
// Module Name: FlexiBit_Accelerator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Adder #(
    parameter BITWIDTH = 16
)(
    input   logic   [BITWIDTH - 1 : 0]  a,
    input   logic   [BITWIDTH - 1 : 0]  b,
    input   logic                       subtract,
    output  logic   [BITWIDTH - 1 : 0]  result

);

/// TODO: Handle signed integers

logic [BITWIDTH : 0] full_result;
logic [BITWIDTH : 0] b_add_sub;

assign b_add_sub = (subtract)? (~{b[BITWIDTH-1], b} + 1) : ({1'b0, b});

assign full_result = {1'b0, a} + b_add_sub;

assign result = full_result[BITWIDTH - 1 : 0];

endmodule

