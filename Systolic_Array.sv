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

`include "PE.sv"



module Systolic_Array #(
    parameter BITWIDTH = 16,
    parameter PE_X = 4,             //  PE array columns
    parameter PE_Y = 4,              //  PE array rows
    parameter DRAM_BW = BITWIDTH * PE_X 

)(
    input   logic                       clk,
    input   logic                       reset,
    input   logic   [2:0]               op_code,
    input   logic   [DRAM_BW - 1 : 0]   accel_input_data,
    input   logic                       weight_or_act,
    output  logic   [DRAM_BW - 1 : 0]   accel_output_data
);

logic   [BITWIDTH - 1 : 0]  left_right_link [PE_X][PE_Y];
logic   [BITWIDTH - 1 : 0]  up_down_link    [PE_X][PE_Y];
logic   [BITWIDTH - 1 : 0]  vertical_bus    [PE_X];


logic   [BITWIDTH - 1 : 0]  weight_sram_reg [PE_X];
logic   [BITWIDTH - 1 : 0]  act_sram_reg [PE_Y];

genvar i;
genvar j;
generate
    for(i = 0; i < PE_X; i++)begin
        assign up_down_link[i][0] = weight_sram_reg[i];
    end
    for(j = 0; j < PE_Y; j++)begin
        assign left_right_link[0][j] = act_sram_reg[j];
    end
endgenerate

generate
    for(i = 0; i < PE_X; i++)begin : column_
        for(j = 0; j < PE_Y; j++)begin: row_
            PE #(
                .BITWIDTH(16) // Parameter value for BITWIDTH
            ) pe_instance (
                .clk(clk),                         // Connect to the clock signal
                .reset(reset),                     // Connect to the reset signal
                .input_left(left_right_link[i][j]),      // Connect to the left input data wire
                .input_up(up_down_link[i][j]),          // Connect to the upper input data wire
                .vertical_bus(vertical_bus[i]),  // Connect to the vertical bus wire
                .op_code(op_code),          // Connect to the opcode signal
                .output_right(left_right_link[i+1][j]),  // Connect to the right output wire
                .output_down(up_down_link[i][j+1])     // Connect to the down output wire
            );

        end
    end
endgenerate

integer index_x, index_y;
always @(posedge clk or posedge reset) begin
    if (reset) begin

    end
    else begin
        if (weight_or_act == 1'b0)begin  //input from DRAM is weight
            for (index_x = 0; index_x < PE_X; index_x++) begin
                weight_sram_reg[index_x] <= accel_input_data [(index_x+1) * BITWIDTH - 1: index_x * BITWIDTH];
            end
        end
        else begin  //input from DRAM is weight
            for (index_y = 0; index_y < PE_Y; index_y++) begin
                act_sram_reg[index_y] <= accel_input_data [(index_y+1) * BITWIDTH - 1: index_y * BITWIDTH];
            end
        end
    end
end



always @(posedge clk or posedge reset) begin
    if (reset) begin
        
    end
    else begin
        for (index_x = 0; index_x < PE_X; index_x++) begin
                accel_output_data [(index_x+1) * BITWIDTH - 1: index_x * BITWIDTH] <= up_down_link[index_x][PE_Y - 1];
            end
    end
end


endmodule

