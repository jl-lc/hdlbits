module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    reg [3:0] out_reg;
    
    always @(posedge clk) begin
        if (~resetn)
            out_reg <= 4'h0;
        else
            out_reg <= {out_reg[2:0], in};
    end
    
    assign out = out_reg[3];

endmodule
