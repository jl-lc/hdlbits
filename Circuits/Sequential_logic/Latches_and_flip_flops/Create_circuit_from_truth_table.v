module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    
    always @(posedge clk) begin
        if (k & ~j)
            Q <= 1'b0;
        else if (~k & j)
            Q <= 1'b1;
        else if (j & k)
            Q <= ~Q;
        else
            Q <= Q;
    end

endmodule
