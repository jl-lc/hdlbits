module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    reg [7:0] q1, q2, q3 = 8'b0;
    my_dff8 u1 (.clk(clk), .d(d), .q(q1));
    my_dff8 u2 (.clk(clk), .d(q1), .q(q2));
    my_dff8 u3 (.clk(clk), .d(q2), .q(q3));
    
    always @(*)
    begin
        case (sel)
            0 : q <= d;
            1 : q <= q1;
            2 : q <= q2;
            3 : q <= q3;
        endcase
    end

endmodule
