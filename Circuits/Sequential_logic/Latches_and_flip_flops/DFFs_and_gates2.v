module top_module (
    input clk,
    input x,
    output z
); 
    
    reg [2:0] Q;
    
    always @(posedge clk)
        Q <= {x | ~Q[2], x & ~Q[1], x ^ Q[0]};
    
    assign z = ~|Q;

endmodule
