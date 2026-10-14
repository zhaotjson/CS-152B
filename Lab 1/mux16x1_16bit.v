`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2026 10:35:27 AM
// Design Name: 
// Module Name: mux4x1_16bit
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


module mux16x1_16bit(
    input [15:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15,
    input [3:0] sel,
    output [15:0] out

);

    wire [15:0] t0, t1, t2, t3;
    
    
    
    mux4x1_16bit mux0 (in0, in1, in2, in3, sel[1:0], t0);
    mux4x1_16bit mux1 (in4, in5, in6, in7, sel[1:0], t1);
    mux4x1_16bit mux2 (in8, in9, in10, in11, sel[1:0], t2);
    mux4x1_16bit mux3 (in12, in13, in14, in15, sel[1:0], t3);
    
    mux4x1_16bit mux4 (t0, t1, t2, t3, sel[3:2], out);





endmodule