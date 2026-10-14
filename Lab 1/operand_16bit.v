module add_16bit(
  input wire [15:0] A,
  input wire [15:0] B,

  output wire [15:0] S,
  output wire C
);

wire [16:0] c;
buf (c[0], 1'b0);

wire A_sign;
wire B_sign;
buf (A_sign, A[15]);
buf (B_sign, B[15]);



genvar i;
generate
    for (i = 0; i < 16; i = 1 + i) begin
      add_1bit op (
        .a(A[i]),
        .b(B[i]),
        .cin(c[i]),
    
        .s(S[i]),
        .cout(c[i+1])
      );
    end
endgenerate

wire same_sign;
xnor (same_sign, A_sign, B_sign);

wire diff;

xor (diff, S[15], A_sign);

and (C, diff, same_sign);



endmodule


module sub_16bit(
  input wire [15:0] A,
  input wire [15:0] B,

  output wire [15:0] S,
  output wire C
);

wire C_neg;
wire C_add;

wire [15:0] b;


invert in (
    .A(B),
    .S(b),
    .C(C_neg)
);

add_16bit add (
  .A(A),
  .B(b),

  .S(S),
  .C(C_add)
);

or (C, C_add, C_neg);

endmodule



module invert(
     input wire[15:0] A,
     output wire[15:0] S,
     output wire C
);

wire [15:0] complement;
wire C_comp;

not g[15:0] (complement, A);
increment inc (complement, S, C_comp);


wire is_int_min;
wire A_zero;
nor (A_zero, A[14], A[13], A[12], A[11], A[10], A[9], A[8], A[7], A[6], A[5], A[4], A[3], A[2], A[1], A[0]);
and (is_int_min, A[15], A_zero);
or (C, C_comp, is_int_min);


endmodule


module increment(
  input wire [15:0] A,

  output wire [15:0] S,
  output wire C
);

add_16bit inc (
  .A(A),
  .B(16'd1),
  .S(S),
  .C(C)
);

endmodule

module decrement(
  input wire [15:0] A,

  output wire [15:0] S,
  output wire C
);

sub_16bit inc (
  .A(A),
  .B(1),
  .S(S),
  .C(C)
);

endmodule



module bitwise_or(
  input wire [15:0] A,
  input wire [15:0] B,

  output wire [15:0] S
);

or g[15:0] (S, A, B);

endmodule

module bitwise_and(
  input wire [15:0] A,
  input wire [15:0] B,

  output wire [15:0] S
);

and g[15:0] (S, A, B);

endmodule

module arith_shift_left(
  input wire [15:0] A,

  output wire [15:0] S,
  output wire C
);

wire [16:0] c;
buf (c[0], 1'b0);

wire start_sign;
buf (start_sign, A[15]);

genvar i; 
generate
    for (i = 0; i < 16; i = i + 1) begin
      shift op (
        .a(A[i]),
        .cin(c[i]),
    
        .s(S[i]),
        .cout(c[i+1])
      );
    end
endgenerate


wire end_sign;
buf (end_sign, S[15]);

xor (C, start_sign, end_sign);

endmodule


module arith_shift_right(
  input wire [15:0] A,

  output wire [15:0] S,
  output wire C
);

wire [16:0] c;
buf (c[16], A[15]);


genvar i;
generate
    for (i = 0; i < 16; i = i + 1) begin
      shift op (
        .a(A[15 - i]),
        .cin(c[16 - i]),
    
        .s(S[15 - i]),
        .cout(c[15 - i])
      );
    end
endgenerate

buf(C, c[0]);

endmodule


module logic_shift_left(
  input  wire [15:0] A,

  output wire [15:0] S,
  output wire C
);


wire [16:0] c;

buf(c[0], 1'b0);

genvar i;
generate
    for (i = 0; i < 16; i = i + 1) begin
    
      shift op (
        .a(A[i]),
        .cin(c[i]),
    
        .s(S[i]),
        .cout(c[i+1])
      );
    end
endgenerate

buf (C, c[16]);

endmodule


module logic_shift_right(
  input wire [15:0] A,

  output wire [15:0] S,
  output wire C
);

wire [16:0] c;

buf(c[16], 1'b0);

genvar i;
generate
    for (i = 0; i < 16; i = i + 1) begin
      shift op (
        .a(A[15 - i]),
        .cin(c[16 - i]),
    
        .s(S[15 - i]),
        .cout(c[15 - i])
      );
    end
endgenerate

buf (C, c[0]);

endmodule


module set_less_than_or_equal(
    input wire [15:0] A,
    input wire [15:0] B,
    
    output wire [15:0] S
);

wire [15:0] e;
wire [15:0] alb;
wire [15:0] bla;
wire [15:0] not_e;
wire [15:0] not_bla;
wire [15:0] not_e_and_not_bla;

//assign S = 0;

buf (e[15], 1'b1);
buf (alb[15], 1'b0);
buf (bla[15], 1'b0);


genvar i;
generate
    for (i = 1; i < 16; i = i + 1) begin
        equal eq (
            .a(A[15 - i]),
            .b(B[15 - i]),
            .cin(e[16 - i]),
            .s(e[15 - i])
        );
        
        less le (
            .a(B[15 - i]),
            .b(A[15 - i]),
            .cin(bla[16 - i]),
            .s(bla[15-i])
        );
        
        not (not_e[15-i], e[15-i]);
        not (not_bla[15-i], bla[15-i]);
        and (not_e_and_not_bla[15-i], not_e[15-i], not_bla[15-i]);
        or (alb[15-i], not_e_and_not_bla[15-i], alb[16-i]);
    end
 endgenerate
 
 wire [1:0] sel;
 buf (sel[0], A[15]);
 buf (sel[1], B[15]);
 
 wire out;
 

 
 or(out, e[0], alb[0]);


 buf g[15:1] (S[15:1], 1'b0);

 
 mux4x1_1bit mux(out, 1'b1, 1'b0, out, sel, S[0]);
 

 endmodule