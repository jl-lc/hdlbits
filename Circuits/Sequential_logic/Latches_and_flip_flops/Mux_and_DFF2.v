module top_module (
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
