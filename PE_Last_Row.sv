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
`include "Subtractor.sv"
`include "Max_Selector.sv"


module PE_Last_Row #(
    parameter BITWIDTH = 16

)(
    input   logic                       clk,
    input   logic                       reset,
    input   logic   [BITWIDTH - 1 : 0]  input_left,
    input   logic   [BITWIDTH - 1 : 0]  input_up,

    output   logic   [BITWIDTH - 1 : 0]  vertical_bus
    output   logic  [BITWIDTH - 1 : 0]  output_right,
    output   logic  [BITWIDTH - 1 : 0]  output_down

);

assign vertical_bus = |send_enable ? bus_drive : 'z;






endmodule

