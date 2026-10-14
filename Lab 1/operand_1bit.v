module add_1bit(
  input wire a,
  input wire b,
  input wire cin,

  output wire s,
  output wire cout
);

wire a_xor_b;
wire cin_and_axb, a_and_b;

xor (a_xor_b, a, b);
xor (s, cin, a_xor_b);

and (cin_and_axb, cin, a_xor_b);
and (a_and_b, a, b);

or (cout, cin_and_axb, a_and_b);

endmodule


// // WIP
// module subtract_1bit(
//   input wire a,
//   input wire b,
//   input wire cin;

//   output wire S,
//   output wire cout,
// );

// wire a_xor_b;
// wire cin_and_axb, a_and_b;

// xor (a_xor_b, a, b);
// xor (s, cin, a_xor_b);

// and (cin_and_axb, cin, a_xor_b);

// endmodule


module shift(
  input wire a,
  input wire cin,

  output wire s,
  output wire cout
);

buf (cout, a);
buf (s, cin);

endmodule

module equal(
    input wire a,
    input wire b,
    input wire cin,
    
    output wire s
);

wire a_xnor_b;
    
xnor (a_xnor_b, a, b);
and (s, a_xnor_b, cin);

endmodule

module less(
    input wire a,
    input wire b,
    input wire cin,
    
    output wire s
);    

wire not_a, not_a_and_b;

not (not_a, a);
and (not_a_and_b, not_a, b);
or (s, not_a_and_b, cin);

endmodule
    