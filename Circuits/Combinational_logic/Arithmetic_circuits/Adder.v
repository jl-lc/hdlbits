module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    wire [4:0] carry;
    assign carry[0] = 1'b0;
    assign sum[4] = carry[4];
    
    genvar i;
    generate
        for (i = 0; i < 4; i++) begin : gen_adders
            fadd u1 (.a(x[i]), .b(y[i]), .cin(carry[i]), .cout(carry[i+1]), .sum(sum[i]));
        end
	  endgenerate

endmodule

module fadd( 
    input a, b, cin,
    output cout, sum );
    
    assign {cout, sum} = a + b + cin;

endmodule