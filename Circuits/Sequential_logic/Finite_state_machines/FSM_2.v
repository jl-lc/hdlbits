module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;
    reg [2:0] state, next;
    
    // state transition logic
    always @(*) begin
        case (state)
            s0: next = x ? s1 : s0;
            s1: next = x ? s4 : s1;
            s2: next = x ? s1 : s2;
            s3: next = x ? s2 : s1;
            s4: next = x ? s4 : s3;
            default: next = next;
        endcase
    end
    
    // state flip flops
    always @(posedge clk)
        state = reset ? s0 : next;
    
    // output logic
    assign z = state == s3 | state == s4;

endmodule
