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


module Divider #(
    parameter BITWIDTH = 16
)(
    input   logic   [BITWIDTH - 1 : 0] a,
    input   logic   [BITWIDTH - 1 : 0] b,
    output  logic   [BITWIDTH - 1 : 0] result

);

/// TODO: Handle signed integers

assign result = a / b;

endmodule

