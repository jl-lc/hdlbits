module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    reg [3:0] counter;
    
    always @(posedge clk) begin
        if (reset)
            counter <= 4'b0;
        else
            counter <= {counter[2:0], 1'b1};
    end
    
   	assign shift_ena = counter != 4'b1111;

endmodule
