module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    
    always @(posedge clk) begin
        if (reset)
            q <= {4{1'b0}};
        else if (slowena)
            if (q == 4'b1001)
            	q <= {4{1'b0}};
            else 
                q <= q + 1;
        else
            q <= q;
    end

endmodule
