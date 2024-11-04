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


module P_Z_LUT #(
    parameter BITWIDTH = 16,
    parameter LUT_ADDRESS_WIDTH = 4
)(
    input   logic   [LUT_ADDRESS_WIDTH - 1 : 0] x,
    output   logic   [BITWIDTH - 1 : 0] p,
    output   logic   [BITWIDTH - 1 : 0] z

);

logic [BITWIDTH - 1:0] z_lut [15:0];
logic [BITWIDTH - 1:0] p_lut [15:0];


/// TODO: fill the Lookup-table with correct values

integer i;
initial begin
    for (i=0 ; i < 16; i++) begin
        z_lut[i]  = i[15:0];
        p_lut[i]  = i[15:0];
    end
end



assign p = z_lut[x];
assign z = p_lut[x];

endmodule

