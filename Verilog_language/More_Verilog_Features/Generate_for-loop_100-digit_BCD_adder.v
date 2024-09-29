module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire [100:0] carry;
    
    assign carry[0] = cin;
    assign cout = carry[100];
    
    genvar i;
    generate
        for (i = 0; i < 100; i++)
    	  begin : gen_bcd
            bcd_fadd u1 (.a(a[3+4*i:0+4*i]), .b(b[3+4*i:0+4*i]), .cin(carry[i]), .cout(carry[i+1]), .sum(sum[3+4*i:0+4*i]));
        end
    endgenerate

endmodule
