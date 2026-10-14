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


module mux4x1_16bit(
        input [15:0] in0, in1, in2, in3,
        input [1:0] sel,
        output [15:0] out
    );
    
    
    
    genvar i;
    
    //Do the 4x1 for each bit of input
    generate
        for (i = 0; i < 16; i = i + 1) begin : mux_loop
            mux4x1_1bit m4x1 (
                .in0(in0[i]),
                .in1(in1[i]),
                .in2(in2[i]),
                .in3(in3[i]),
                .sel(sel),
                .out(out[i])
           );
        end
   endgenerate
endmodule
