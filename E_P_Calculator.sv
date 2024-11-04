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


module E_P_Calculator #(
    // parameter DECIMAL_PRECISION = 1000,
    parameter BITWIDTH = 16
)(
    input   logic   [BITWIDTH - 1 : 0] p,
    output   logic   [BITWIDTH - 1 : 0] l_p

);

/// TODO: Handle signed integers
logic [BITWIDTH - 1 : 0] l_p_multiplied;

assign l_p_multiplied = (359 * p * p) + (970 * p) + 1000;

assign l_p = l_p_multiplied/1000;

endmodule

