`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2026 10:15:02 AM
// Design Name: 
// Module Name: 16_bit_alu
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


module alu_16_bit(
        input [3:0] ALUCtrl,
        input [15:0] A,
        input [15:0] B,
        output [15:0] out,
        output zero,
        output overflow
    );
    
    wire [15:0] res0, res1, res2, res3, res4, res5, res6, res7, res8, res9, res10, res11, res12, res13, res14, res15;
    wire overflow0, overflow1, overflow2, overflow3, overflow4, overflow5, overflow6, overflow7, overflow8, overflow9, overflow10, overflow11, overflow12, overflow13, overflow14, overflow15;
    

    buf (overflow2, 1'b0);
    buf (overflow3, 1'b0);
    buf (overflow7, 1'b0);
    buf (overflow9, 1'b0);
    buf (overflow11, 1'b0);
    buf (overflow13, 1'b0);
    buf (overflow15, 1'b0);
    
    
    
    
    sub_16bit sub(
         .A(A),
         .B(B),
         .S(res0),
         .C(overflow0)
    );
    
    add_16bit add(
         .A(A),
         .B(B),
         .S(res1),
         .C(overflow1)
    );
    
    
    bitwise_or bit_or(
        .A(A),
        .B(B),
        .S(res2)
    );
    
    bitwise_and bit_and(
         .A(A),
         .B(B),
         .S(res3)
    );
    
    
    decrement dec(
        .A(A),
        .S(res4),
        .C(overflow4)
    );
    
    
    increment inc(
         .A(A),
         .S(res5),
         .C(overflow5)
    );
    

    invert inv(
         .A(A),
         .S(res6),
         .C(overflow6)
    );
    
    
    //nothing for res7
    
    logic_shift_left log_left(
         .A(A),
         .S(res8),
         .C(overflow8)
    );
    
    
    set_less_than_or_equal less_eq(
         .A(A),
         .B(B),
         .S(res9)
    );
    
    
    logic_shift_right log_right(
         .A(A),
         .S(res10),
         .C(overflow10)
    );
    
    
    //nothing for res 11
    
    arith_shift_left arith_left(
         .A(A),
         .S(res12),
         .C(overflow12)
    );
    
    
    arith_shift_right arith_right(
         .A(A),
         .S(res14),
         .C(overflow14)
    );
    
    
    
    mux16x1_16bit mux (
        .in0(res0),
        .in1(res1),
        .in2(res2), 
        .in3(res3),
        .in4(res4),
        .in5(res5),
        .in6(res6),
        .in7(res7),
        .in8(res8),
        .in9(res9),
        .in10(res10),
        .in11(res11),
        .in12(res12),
        .in13(res13),
        .in14(res14),
        .in15(res15),
        .sel(ALUCtrl),
        .out(out)
     );
    
    
      mux16x1_16bit overflow_mux (
         .in0(overflow0),
         .in1(overflow1),
         .in2(overflow2), 
         .in3(overflow3),
         .in4(overflow4),
         .in5(overflow5),
         .in6(overflow6),
         .in7(overflow7),
         .in8(overflow8),
         .in9(overflow9),
         .in10(overflow10),
         .in11(overflow11),
         .in12(overflow12),
         .in13(overflow13),
         .in14(overflow14),
         .in15(overflow15),
         .sel(ALUCtrl),
         .out(overflow)
      );
     
     
     

    
      nor(zero, out[0], out[1], out[2], out[3], out[4], out[5], out[6], out[7], out[8], out[9], out[10], out[11], out[12], out[13], out[14], out[15]);
      
    
    
    
    
    
endmodule
