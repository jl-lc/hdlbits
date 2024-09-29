module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    parameter s0=0, s1=1, s2=2;
    reg [1:0] state, next;
    
    // state transition logic
    always @(*) begin
        case (state)
            s0: next = x  ? s1 : s0; // 1
            s1: next = ~x ? s2 : s1; // 0
            s2: next = x  ? s1 : s0; // 1
            default: next = next;
        endcase
    end
    
    // state flip flops
    always @(posedge clk, negedge aresetn) 
        state <= ~aresetn ? s0 : next;
    
    // output logic
    assign z = state == s2 & x; // mealy

endmodule
