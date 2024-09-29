module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    parameter init_zeros=0, init_one=1, flip=2;
    reg [1:0] state, next;
    reg in;
    
    // state transition logic
    always @(*)
        case (state)
            init_zeros: next = x ? init_one : init_zeros;
            init_one: next = flip;
            flip	: next = flip;
        endcase
    
    // state flip flops
    always @(posedge clk, posedge areset)
        state <= areset ? init_zeros : next;
    
    // reg input
    always @(posedge clk)
        in <= x;
    
    // output logic
    always @(*)
        z = state == flip ? ~in : state == init_zeros ? 0 : 1;

endmodule
