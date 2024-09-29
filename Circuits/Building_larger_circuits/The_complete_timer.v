module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    parameter s=0, s1=1, s11=2, s110=3, b0=4, b1=5, b2=6, b3=7, cnt=8, waiting=9;
    reg [3:0] state, next;
    wire shift_ena, count_ena, done_counting;
    reg [3:0] delay;
    reg [9:0] count_1k;
    
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
            b3	 : next = cnt;
            cnt  : next = ~done_counting ? cnt : waiting;
            waiting: next = ack ? s : waiting;
            default: next = s;
        endcase
    
    // state flip flops
    always @(posedge clk)
        state <= reset ? s : next;
    
    // delay logic
    assign shift_ena = state >= b0 & state <= b3;
    always @(posedge clk) begin
        if (shift_ena)
            delay <= {delay[2:0], data};
        else if (count_ena)
            delay <= delay - 1;
        else
            delay <= delay;
    end
    always @(posedge clk)
        count_1k <= state != cnt | reset | count_1k == 10'd999 ? 0 : count_1k + 1;
    assign count_ena = count_1k == 10'd999;
    assign done_counting = delay == 4'h0 & count_ena;
    
    // output logic
    assign counting  = state == cnt;
    assign done = state == waiting;    
    assign count = delay;

endmodule
