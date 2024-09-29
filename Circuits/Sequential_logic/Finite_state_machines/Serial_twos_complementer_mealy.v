module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    parameter a=0, b=1;
    reg state, next;
    
    // state transition
    always @(*)
        case (state)
            a: next = x ? b : a;
            b: next = b;
        endcase
    
    // state flip flops
    always @(posedge clk, posedge areset)
        state <= areset ? a : next;
    
    // output logic
    always @(*)
        case (state)
            a: z = x;
            b: z = ~x;
        endcase

endmodule
