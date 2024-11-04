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

`include "Divider.sv"
`include "Adder.sv"
`include "Max_Selector.sv"
`include "Exp_Approximator.sv"


module PE #(
    parameter BITWIDTH = 16,
    parameter LUT_ADDRESS_WIDTH = 4

)(
    input   logic                       clk,
    input   logic                       reset,
    input   logic   [BITWIDTH - 1 : 0]  input_left,
    input   logic   [BITWIDTH - 1 : 0]  input_up,
    input   logic   [BITWIDTH - 1 : 0]  vertical_bus,
    input   logic   [2:0]               op_code,

    output   logic  [BITWIDTH - 1 : 0]  output_right,
    output   logic  [BITWIDTH - 1 : 0]  output_down

);

logic   [BITWIDTH - 1 : 0] register [3:0];    /// register[0] is used for now
logic   [BITWIDTH - 1 : 0] add_out, max_out, exp_out, div_out;
logic   [BITWIDTH - 1 : 0] adder_in;

assign adder_in = (op_code[0])? (vertical_bus):(input_up);


Adder #(
    .BITWIDTH(BITWIDTH)
) adder(
    .a(register[0]),
    .b(adder_in),
    .subtract(op_code[0]),
    .result(add_out)            /// register [1] is for summation result
);

Divider #(
    .BITWIDTH(BITWIDTH)
) divider(
    .a(register[0]),
    .b(vertical_bus),
    .result(div_out)            /// register [1] is for summation result
);

Max_Selector #(
    .BITWIDTH(BITWIDTH)
) max_selector(
    .a(register[0]),
    .b(input_up),
    .result(max_out)            /// register [1] is for summation result
);

Exp_Approximator #(
    .BITWIDTH(BITWIDTH),
    .LUT_ADDRESS_WIDTH(LUT_ADDRESS_WIDTH)
) exp_approximator(
    .x(register[0][LUT_ADDRESS_WIDTH - 1 : LUT_ADDRESS_WIDTH - 4]),
    .e_x(exp_out)            /// register [1] is for summation result
);



always @(posedge clk or posedge reset) begin
    if(reset) begin
        output_right <= 0;
        output_down <= 0;
    end
    else begin
        if (op_code == 3'b000)begin    /// op_code for max_selector
            output_right <= 0;
            output_down <= max_out;

        end
        if (op_code == 3'b001)begin    /// op_code for exp_approximator
            output_right <= 0;
            output_down <= exp_out;
            register[0] <= exp_out;
        end
        if (op_code == 3'b010 | op_code == 3'b011)begin    /// op_code for adder/subtractor
            output_right <= 0;
            output_down <= add_out;
            register[0] <= div_out;

        end
        if (op_code == 3'b011)begin    /// op_code for divider
            output_right <= 0;
            output_down <= div_out;
            register[0] <= div_out;
        end


    end


end


endmodule

