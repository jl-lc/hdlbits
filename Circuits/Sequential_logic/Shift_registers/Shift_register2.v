module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //

    MUXDFF u0 (.clk(KEY[0]), .w(LEDR[1]), .R(SW[0]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[0]));
    MUXDFF u1 (.clk(KEY[0]), .w(LEDR[2]), .R(SW[1]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[1]));
    MUXDFF u2 (.clk(KEY[0]), .w(LEDR[3]), .R(SW[2]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[2]));
    MUXDFF u3 (.clk(KEY[0]), .w(KEY[3]),  .R(SW[3]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[3]));
    
endmodule

module MUXDFF (
    input clk,
    input w, R, E, L,
    output Q
);
    wire D;
    wire comb;
    
    assign comb = E ? w : Q;
    assign D = L ? R : comb;
    
    always @(posedge clk) 
        Q <= D;

endmodule

