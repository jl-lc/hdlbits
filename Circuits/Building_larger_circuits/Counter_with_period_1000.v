module top_module (
    input clk,
    input reset,
    output [9:0] q);
    
    always @(posedge clk)
        q <= reset | q == 10'd999 ? 0 : q + 1;

endmodule
