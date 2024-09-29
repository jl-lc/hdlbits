module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] in_reg;
    
    always @(posedge clk) begin
        for (int i = 0; i < 8; i++) begin
            in_reg[i] <= in[i];
            anyedge[i] <= in[i] - in_reg[i];
        end
    end
    

endmodule
