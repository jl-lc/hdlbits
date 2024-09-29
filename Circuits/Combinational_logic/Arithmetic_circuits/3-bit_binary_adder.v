module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    wire [3:0] carry;
    assign carry[0] = cin;
    assign cout = carry[3:1];
    
    genvar i;
    generate
        for (i = 0; i < 3; i++) begin : gen_adders
            fadd u1 (.a(a[i]), .b(b[i]), .cin(carry[i]), .cout(carry[i+1]), .sum(sum[i]));
        end
	  endgenerate

endmodule

module fadd( 
    input a, b, cin,
    output cout, sum );
    
    assign {cout, sum} = a + b + cin;

endmodule

