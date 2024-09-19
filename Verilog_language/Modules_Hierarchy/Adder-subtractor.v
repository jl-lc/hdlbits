module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire cout;
    wire [31:0] bmux;
    assign bmux = b ^ {32{sub}};
    add16 u1 (.a(a[15:0]), .b(bmux[15:0]), .cin(sub), .sum(sum[15:0]), .cout(cout));
    add16 u2 (.a(a[31:16]), .b(bmux[31:16]), .cin(cout), .sum(sum[31:16]), .cout());

endmodule
