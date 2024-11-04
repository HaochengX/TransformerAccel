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


module Subtractor #(
    parameter BITWIDTH = 16
)(
    input   logic   [BITWIDTH - 1 : 0] a,
    input   logic   [BITWIDTH - 1 : 0] b,
    output  logic   [BITWIDTH - 1 : 0] result

);

/// TODO: Handle signed integers

logic [BITWIDTH : 0] full_result;

assign full_result = {1'b0, a} - {1'b0, b};

assign result = full_result[BITWIDTH - 1 : 0];

endmodule

