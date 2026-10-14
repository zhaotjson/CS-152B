`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2026 10:10:27 AM
// Design Name: 
// Module Name: testbench
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


module testbench();


reg [3:0] ALUCtrl;
reg [15:0] A;
reg [15:0] B;
wire [15:0] out;
wire zero;
wire overflow;



alu_16_bit alu(
    .ALUCtrl(ALUCtrl),
    .A(A),
    .B(B),
    .out(out),
    .zero(zero),
    .overflow(overflow)
);

initial begin


    // =====================================
    // Subtraction: ALUCtrl = 0000
    // =====================================
    ALUCtrl = 4'b0000;

    A = 16'd3; B = 16'd1; #10;
    if (out !== 16'd2) begin $display("Error: 3 - 1 failed"); $stop; end

    A = 16'd5; B = 16'd5; #10;
    if (out !== 16'd0) begin $display("Error: 5 - 5 failed"); $stop; end

    A = -16'sd5; B = 16'd4; #10;
    if (out !== -16'sd9) begin $display("Error: -5 - 4 failed"); $stop; end

    A = -16'sd100; B = 16'd0; #10;
    if (out !== -16'sd100) begin $display("Error: -100 - 0 failed"); $stop; end

    A = 16'd0; B = 16'd1; #10;
    if (out !== 16'hFFFF) begin $display("Error: 0 - 1 failed"); $stop; end

    A = 16'h8000; B = 16'd1; #10;
    if (out !== 16'h7FFF) begin $display("Error: Subtraction boundary result failed"); $stop; end


    // =====================================
    // Addition: ALUCtrl = 0001
    // =====================================
    ALUCtrl = 4'b0001;

    A = 16'd1; B = 16'd1; #10;
    if (out !== 16'd2) begin $display("Error: 1 + 1 failed"); $stop; end

    A = 16'd5; B = 16'd3; #10;
    if (out !== 16'd8) begin $display("Error: 5 + 3 failed"); $stop; end

    A = -16'sd5; B = 16'd5; #10;
    if (out !== 16'd0) begin $display("Error: -5 + 5 failed"); $stop; end

    A = 16'd32760; B = 16'd7; #10;
    if (out !== 16'd32767) begin $display("Error: Maximum positive addition failed"); $stop; end

    A = 16'd32767; B = 16'd1; #10;
    if (out !== 16'h8000) begin $display("Error: Positive overflow result failed"); $stop; end

    A = 16'h8000; B = 16'hFFFF; #10;
    if (out !== 16'h7FFF) begin $display("Error: Negative overflow result failed"); $stop; end

    A = 16'hFFFF; B = 16'd1; #10;
    if (out !== 16'd0) begin $display("Error: Addition wraparound failed"); $stop; end


    // =====================================
    // Bitwise OR: ALUCtrl = 0010
    // =====================================
    ALUCtrl = 4'b0010;

    A = 16'b1010_1010_1010_1010;
    B = 16'b0101_0101_0101_0101; #10;
    if (out !== 16'hFFFF) begin $display("Error: Bitwise OR alternating bits failed"); $stop; end

    A = 16'h0000; B = 16'h0000; #10;
    if (out !== 16'h0000) begin $display("Error: Bitwise OR zeros failed"); $stop; end

    A = 16'hF0F0; B = 16'h0F0F; #10;
    if (out !== 16'hFFFF) begin $display("Error: Bitwise OR complementary patterns failed"); $stop; end

    A = 16'h1234; B = 16'h00FF; #10;
    if (out !== 16'h12FF) begin $display("Error: Bitwise OR partial overlap failed"); $stop; end


    // =====================================
    // Bitwise AND: ALUCtrl = 0011
    // =====================================
    ALUCtrl = 4'b0011;

    A = 16'b1010_1010_1010_1010;
    B = 16'b0101_0101_0101_0101; #10;
    if (out !== 16'h0000) begin $display("Error: Bitwise AND alternating bits failed"); $stop; end

    A = 16'hFFFF; B = 16'hFFFF; #10;
    if (out !== 16'hFFFF) begin $display("Error: Bitwise AND all ones failed"); $stop; end

    A = 16'hF0F0; B = 16'h0FF0; #10;
    if (out !== 16'h00F0) begin $display("Error: Bitwise AND partial overlap failed"); $stop; end

    A = 16'h1234; B = 16'h0000; #10;
    if (out !== 16'h0000) begin $display("Error: Bitwise AND with zero failed"); $stop; end


    // =====================================
    // Decrement: ALUCtrl = 0100
    // =====================================
    ALUCtrl = 4'b0100;

    A = 16'd5; #10;
    if (out !== 16'd4) begin $display("Error: Decrement 5 failed"); $stop; end

    A = 16'd1; #10;
    if (out !== 16'd0) begin $display("Error: Decrement 1 failed"); $stop; end

    A = 16'd0; #10;
    if (out !== 16'hFFFF) begin $display("Error: Decrement 0 failed"); $stop; end

    A = 16'h8000; #10;
    if (out !== 16'h7FFF) begin $display("Error: Decrement minimum signed value failed"); $stop; end

    A = 16'hFFFF; #10;
    if (out !== 16'hFFFE) begin $display("Error: Decrement all ones failed"); $stop; end


    // =====================================
    // Increment: ALUCtrl = 0101
    // =====================================
    ALUCtrl = 4'b0101;

    A = 16'd5; #10;
    if (out !== 16'd6) begin $display("Error: Increment 5 failed"); $stop; end

    A = 16'd0; #10;
    if (out !== 16'd1) begin $display("Error: Increment 0 failed"); $stop; end

    A = 16'hFFFF; #10;
    if (out !== 16'h0000) begin $display("Error: Increment all ones failed"); $stop; end

    A = 16'h7FFF; #10;
    if (out !== 16'h8000) begin $display("Error: Increment maximum positive value failed"); $stop; end


    // =====================================
    // Invert: ALUCtrl = 0110
    // =====================================
    ALUCtrl = 4'b0110;

    A = 16'h0000; #10;
    if (out !== 16'h0000) begin $display("Error: Invert zero failed"); $stop; end

    A = 16'hFFFF; #10;
    if (out !== -16'hFFFF) begin $display("Error: Invert all ones failed"); $stop; end

    A = 16'hAAAA; #10;
    if (out !== -16'hAAAA) begin $display("Error: Invert alternating bits failed"); $stop; end

    A = 16'h1234; #10;
    if (out !== -16'h1234) begin $display("Error: Invert general pattern failed"); $stop; end


    // =====================================
    // ALUCtrl = 0111
    // Reserved: res7 is unconnected.
    // No result test until implemented.
    // =====================================


    // =====================================
    // Logical shift left: ALUCtrl = 1000
    // =====================================
    ALUCtrl = 4'b1000;

    A = 16'h0001; #10;
    if (out !== 16'h0002) begin $display("Error: Logical shift left 1 failed"); $stop; end

    A = 16'h4000; #10;
    if (out !== 16'h8000) begin $display("Error: Logical shift left into MSB failed"); $stop; end

    A = 16'h8000; #10;
    if (out !== 16'h0000) begin $display("Error: Logical shift left MSB failed"); $stop; end

    A = 16'hAAAA; #10;
    if (out !== 16'h5554) begin $display("Error: Logical shift left alternating bits failed"); $stop; end

    A = 16'h0000; #10;
    if (out !== 16'h0000) begin $display("Error: Logical shift left zero failed"); $stop; end


    // =====================================
    // Set less than or equal: ALUCtrl = 1001
    // =====================================
    ALUCtrl = 4'b1001;

    A = 16'd3; B = 16'd5; #10;
    if (out !== 16'd1) begin $display("Error: Less than comparison failed 3 < 5 %d", out); $stop; end    
    
    A = -16'd3; B = 16'd5; #10;
    if (out !== 16'd1) begin $display("Error: Less than comparison failed -3 < 5 %d", out); $stop; end

    A = -16'd3; B = -16'd5; #10;
    if (out !== 16'd0) begin $display("Error: Less than comparison failed 3 < -5 %d", out); $stop; end

    A = 16'd5; B = 16'd5; #10;
    if (out !== 16'd1) begin $display("Error: Equal comparison failed %d", out); $stop; end

    A = 16'd8; B = 16'd5; #10;
    if (out !== 16'd0) begin $display("Error: Greater than comparison failed %d", out); $stop; end

    A = 16'd0; B = 16'd0; #10;
    if (out !== 16'd1) begin $display("Error: Zero operands comparison failed %d", out); $stop; end


    // =====================================
    // Logical shift right: ALUCtrl = 1010
    // =====================================
    ALUCtrl = 4'b1010;

    A = 16'h0002; #10;
    if (out !== 16'h0001) begin $display("Error: Logical shift right 2 failed"); $stop; end

    A = 16'h8000; #10;
    if (out !== 16'h4000) begin $display("Error: Logical shift right MSB failed"); $stop; end

    A = 16'h0001; #10;
    if (out !== 16'h0000) begin $display("Error: Logical shift right LSB failed"); $stop; end

    A = 16'hAAAA; #10;
    if (out !== 16'h5555) begin $display("Error: Logical shift right alternating bits failed"); $stop; end

    A = 16'h0000; #10;
    if (out !== 16'h0000) begin $display("Error: Logical shift right zero failed"); $stop; end


    // =====================================
    // ALUCtrl = 1011
    // Reserved: res11 is unconnected.
    // No result test until implemented.
    // =====================================


    // =====================================
    // Arithmetic shift left: ALUCtrl = 1100
    // =====================================
    ALUCtrl = 4'b1100;

    A = 16'h0001; #10;
    if (out !== 16'h0002) begin $display("Error: Arithmetic shift left 1 failed"); $stop; end

    A = 16'h4000; #10;
    if (out !== 16'h8000) begin $display("Error: Arithmetic shift left into MSB failed"); $stop; end

    A = 16'h8000; #10;
    if (out !== 16'h0000) begin $display("Error: Arithmetic shift left MSB failed"); $stop; end

    A = 16'h1234; #10;
    if (out !== 16'h2468) begin $display("Error: Arithmetic shift left general pattern failed"); $stop; end


    // =====================================
    // ALUCtrl = 1101
    // Reserved: res13 is unconnected.
    // No result test until implemented.
    // =====================================


    // =====================================
    // Arithmetic shift right: ALUCtrl = 1110
    // =====================================
    ALUCtrl = 4'b1110;

    A = 16'h0002; #10;
    if (out !== 16'h0001) begin $display("Error: Arithmetic shift right positive value failed"); $stop; end

    A = 16'h8000; #10;
    if (out !== 16'hC000) begin $display("Error: Arithmetic shift right sign extension failed"); $stop; end

    A = 16'hFFFF; #10;
    if (out !== 16'hFFFF) begin $display("Error: Arithmetic shift right all ones failed"); $stop; end

    A = 16'h4000; #10;
    if (out !== 16'h2000) begin $display("Error: Arithmetic shift right positive MSB failed"); $stop; end

    A = 16'h0000; #10;
    if (out !== 16'h0000) begin $display("Error: Arithmetic shift right zero failed"); $stop; end


    // =====================================
    // ALUCtrl = 1111
    // Reserved: res15 is unconnected.
    // No result test until implemented.
    // =====================================



    // =====================================
    // Zero Flag Tests: zero = 1 when out == 0
    // =====================================

    // Subtraction
    ALUCtrl = 4'b0000;

    A = 16'd5; B = 16'd5; #10;
    if (zero !== 1'b1) begin $display("Error: Subtraction zero flag failed"); $stop; end

    A = 16'd5; B = 16'd3; #10;
    if (zero !== 1'b0) begin $display("Error: Subtraction nonzero flag failed"); $stop; end

    // Addition
    ALUCtrl = 4'b0001;

    A = 16'd0; B = 16'd0; #10;
    if (zero !== 1'b1) begin $display("Error: Addition zero flag failed"); $stop; end

    A = 16'hFFFF; B = 16'd1; #10;
    if (zero !== 1'b1) begin $display("Error: Addition wraparound zero flag failed"); $stop; end

    A = 16'd5; B = 16'd3; #10;
    if (zero !== 1'b0) begin $display("Error: Addition nonzero flag failed"); $stop; end

    // Bitwise OR
    ALUCtrl = 4'b0010;

    A = 16'h0000; B = 16'h0000; #10;
    if (zero !== 1'b1) begin $display("Error: OR zero flag failed"); $stop; end

    A = 16'hAAAA; B = 16'h5555; #10;
    if (zero !== 1'b0) begin $display("Error: OR nonzero flag failed"); $stop; end

    // Bitwise AND
    ALUCtrl = 4'b0011;

    A = 16'hAAAA; B = 16'h5555; #10;
    if (zero !== 1'b1) begin $display("Error: AND zero flag failed"); $stop; end

    A = 16'hFFFF; B = 16'hFFFF; #10;
    if (zero !== 1'b0) begin $display("Error: AND nonzero flag failed"); $stop; end

    // Decrement
    ALUCtrl = 4'b0100;

    A = 16'd1; #10;
    if (zero !== 1'b1) begin $display("Error: Decrement zero flag failed"); $stop; end

    A = 16'd5; #10;
    if (zero !== 1'b0) begin $display("Error: Decrement nonzero flag failed"); $stop; end

    // Increment
    ALUCtrl = 4'b0101;

    A = 16'hFFFF; #10;
    if (zero !== 1'b1) begin $display("Error: Increment wraparound zero flag failed"); $stop; end

    A = 16'd5; #10;
    if (zero !== 1'b0) begin $display("Error: Increment nonzero flag failed"); $stop; end

    // Logical shift left
    ALUCtrl = 4'b1000;

    A = 16'h8000; #10;
    if (zero !== 1'b1) begin $display("Error: Shift left zero flag failed"); $stop; end

    A = 16'h0001; #10;
    if (zero !== 1'b0) begin $display("Error: Shift left nonzero flag failed"); $stop; end

    // Set less than or equal
    ALUCtrl = 4'b1001;

    A = 16'd5; B = 16'd3; #10;
    if (zero !== 1'b1) begin $display("Error: Comparison false zero flag failed"); $stop; end

    A = 16'd3; B = 16'd5; #10;
    if (zero !== 1'b0) begin $display("Error: Comparison true zero flag failed"); $stop; end

    // Logical shift right
    ALUCtrl = 4'b1010;

    A = 16'h0001; #10;
    if (zero !== 1'b1) begin $display("Error: Shift right zero flag failed"); $stop; end

    A = 16'h0002; #10;
    if (zero !== 1'b0) begin $display("Error: Shift right nonzero flag failed"); $stop; end


    // =====================================
    // Overflow Tests
    // =====================================

    // Addition: Positive overflow
    ALUCtrl = 4'b0001;

    A = 16'h7FFF; B = 16'h0001; #10;
    if (overflow !== 1'b1) begin $display("Error: Positive addition overflow failed"); $stop; end

    // Addition: Negative overflow
    A = 16'h8000; B = 16'hFFFF; #10;
    if (overflow !== 1'b1) begin $display("Error: Negative addition overflow failed"); $stop; end

    // Addition: No overflow
    A = 16'd5; B = 16'd3; #10;
    if (overflow !== 1'b0) begin $display("Error: Addition no overflow failed"); $stop; end

    // Addition: Negative result without overflow
    A = 16'h8000; B = 16'h0000; #10;
    if (overflow !== 1'b0) begin $display("Error: Negative addition no overflow failed"); $stop; end


    // Subtraction: Positive overflow
    ALUCtrl = 4'b0000;

    A = 16'h8000; B = 16'h0001; #10;
    if (overflow !== 1'b1) begin $display("Error: Positive subtraction overflow failed"); $stop; end

    // Subtraction: Negative overflow
    A = 16'h7FFF; B = 16'hFFFF; #10;
    if (overflow !== 1'b1) begin $display("Error: Negative subtraction overflow failed"); $stop; end

    // Subtraction: No overflow
    A = 16'd10; B = 16'd5; #10;
    if (overflow !== 1'b0) begin $display("Error: Subtraction no overflow failed"); $stop; end


    // Increment: Signed overflow
    ALUCtrl = 4'b0101;

    A = 16'h7FFF; #10;
    if (overflow !== 1'b1) begin $display("Error: Increment overflow failed"); $stop; end

    // Decrement: Signed overflow
    ALUCtrl = 4'b0100;

    A = 16'h8000; #10;
    if (overflow !== 1'b1) begin $display("Error: Decrement overflow failed"); $stop; end




    $display("All ALU result tests passed!");
    $finish;
    
end

endmodule
