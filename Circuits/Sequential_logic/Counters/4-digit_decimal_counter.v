module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    reg [15:0] q_reg;
    
    assign q = q_reg;
    assign ena = {q_reg[11:8] == 4'h9 && q_reg[7:4] == 4'h9 && q_reg[3:0] == 4'h9, 
                  q_reg[7:4] == 4'h9 && q_reg[3:0] == 4'h9, 
                  q_reg[3:0] == 4'h9};
    
    dec_cntr u1 (.clk(clk), .reset(reset), .en(1'b1), .q(q_reg[3:0]));
    dec_cntr u2 (.clk(clk), .reset(reset), .en(ena[1]), .q(q_reg[7:4]));
    dec_cntr u3 (.clk(clk), .reset(reset), .en(ena[2]), .q(q_reg[11:8]));
    dec_cntr u4 (.clk(clk), .reset(reset), .en(ena[3]), .q(q_reg[15:12]));

endmodule

module dec_cntr (
    input clk,
    input reset,
    input en,
    output [3:0] q);
    
    always @(posedge clk) begin
        if (reset)
            q <= 4'h0;
        else if(en) begin 
            if (q == 4'h9)
                q <= 4'h0;
            else
                q <= q + 1;
        end
        else
            q <= q;
    end
endmodule
