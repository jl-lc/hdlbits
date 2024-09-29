module top_module (input x, input y, output z);
    
    wire [3:0] z_meta;
    
    A IA1 (.x(x), .y(y), .z(z_meta[0]));
    B IB1 (.x(x), .y(y), .z(z_meta[1]));
    A IA2 (.x(x), .y(y), .z(z_meta[2]));
    B IB2 (.x(x), .y(y), .z(z_meta[3]));
    
    assign z = (z_meta[0] | z_meta[1]) ^ (z_meta[2] & z_meta[3]);

endmodule

module A (input x, input y, output z);
    assign z = (x^y) & x;
endmodule

module B ( input x, input y, output z );
    assign z = ~(x ^ y);
endmodule


