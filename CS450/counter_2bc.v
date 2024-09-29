module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    parameter SNT=0, WNT=1, WT=2, ST=3;
    reg [1:0] curr, next;
    
    // state transition logic
    always @(*)
        case (curr)
            SNT: next = train_taken ? WNT : SNT;
            WNT: next = train_taken ? WT  : SNT;
            WT : next = train_taken ? ST  : WNT;
            ST : next = train_taken ? ST  : WT ;
        endcase
    
    // state flip flops
    always @(posedge clk, posedge areset)
        curr <= areset ? WNT : train_valid ? next : curr;
    
    // output logic
    assign state = curr;

endmodule
