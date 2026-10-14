`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2026 10:35:27 AM
// Design Name: 
// Module Name: mux4x1_1bit
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


module mux4x1_1bit(
        input in0, in1, in2, in3,
        input [1:0] sel,
        output out
        
    );
    
    wire not_sel_1, not_sel_0;
    wire w0, w1, w2, w3;
    
    not (not_sel_1, sel[1]);
    not (not_sel_0, sel[0]);
    
    
    //Sets w to in if chosen by selector
    and (w0, in0, not_sel_1, not_sel_0);
    and (w1, in1, not_sel_1, sel[0]);
    and (w2, in2, sel[1], not_sel_0);
    and (w3, in3, sel[1], sel[0]);
    
    
    //returns out with the value of w that iis chosen
    or (out, w0, w1, w2, w3);
    
    
endmodule
