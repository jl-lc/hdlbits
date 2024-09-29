module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    assign q = state ? ~(a ^ b) : a ^ b;
    
    always @(posedge clk)
        state <= state ? a | b : a & b;

endmodule
