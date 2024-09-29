module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    parameter s0=0, s1=1, s2=2, s3=3, s4=4, s5=5, s6=6, d=7, f=8, e=9;
    reg [3:0] state, next;
    
    // state transition logic
    always @(*) begin
        case (state)
            s0: next = in ? s1 : s0;
            s1: next = in ? s2 : s0;
            s2: next = in ? s3 : s0;
            s3: next = in ? s4 : s0;
            s4: next = in ? s5 : s0;
            s5: next = in ? s6 : d ;
            s6: next = in ? e  : f ;
            d : next = in ? s1 : s0;
            f : next = in ? s1 : s0;
            e : next = in ? e  : s0;
        endcase
    end
    
    // state flip flops
    always @(posedge clk) 
        state <= reset ? s0 : next;
    
    // output
    assign disc = state == d;
    assign flag = state == f;
    assign err = state == e;

endmodule
