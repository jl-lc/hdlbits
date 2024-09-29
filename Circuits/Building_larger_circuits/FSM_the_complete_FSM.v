module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    parameter s=0, s1=1, s11=2, s110=3, b0=4, b1=5, b2=6, b3=7, count=8, waiting=9;
    reg [3:0] state, next;
    reg d;
    
    // state transition logic
    always @(*) 
        case (state)
            s    : next = data ? s1  : s;
            s1   : next = data ? s11 : s;
            s11  : next = data ? s11 : s110;
            s110 : next = data ? b0  : s;
            b0   : next = b1;
            b1   : next = b2;
            b2   : next = b3;
            b3	 : next = count;
            count: next = ~done_counting ? count : waiting;
            waiting: next = ack ? s : waiting;
            default: next = s;
        endcase
    
    // state flip flops
    always @(posedge clk)
        state <= reset ? s : next;
    
    // output logic
    assign shift_ena = state >= b0 & state <= b3;
    assign counting  = state == count;
    assign done = state == waiting;
    
endmodule

