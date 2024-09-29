module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    parameter s0=0, s1=1, s2=2, s3=3, s4=4;
    reg [2:0] state, next;
    
    // state transition logic
    always @(*)
        case (state)
            s0: next = data  ? s1 : s0;
            s1: next = data  ? s2 : s0;
            s2: next = ~data ? s3 : s2;
            s3: next = data  ? s4 : s0;
            s4: next = s4;
            default: next = s0;
        endcase
    
    // state flip flops
    always @(posedge clk)
        state <= reset ? s0 : next;
    
    // output logic
    assign start_shifting = state == s4;

endmodule
