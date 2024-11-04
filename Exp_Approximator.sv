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
`include "E_P_Calculator.sv"

module Exp_Approximator #(
    parameter BITWIDTH = 16,
    parameter LUT_ADDRESS_WIDTH = 4
)(
    input   logic   [LUT_ADDRESS_WIDTH - 1 : 0] x,
    output  logic   [BITWIDTH - 1 : 0] e_x

);

/// TODO: Handle signed integers

logic [BITWIDTH - 1 : 0] e_p;
logic [BITWIDTH - 1 : 0] p, z;

P_Z_LUT #(
    .BITWIDTH(BITWIDTH),
    .LUT_ADDRESS_WIDTH(LUT_ADDRESS_WIDTH)

) p_z_lut(
    .x(x),
    .p(p),
    .z(z)
);


E_P_Calculator #(
    .BITWIDTH(BITWIDTH)
) e_p_calculator(
    
    .p(p),
    .l_p(e_p)
);

assign e_x = e_p >> z;

endmodule

