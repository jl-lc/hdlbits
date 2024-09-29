module top_module (
    input c,
    input d,
    output [3:0] mux_in
); 
    wire w1, w2;
    
    assign w1 = d ? 1'b1 : 1'b0;
    assign mux_in[0] = c ? 1'b1 : w1;
    
    assign mux_in[1] = 1'b0;
    
    assign mux_in[2] = d ? 1'b0 : 1'b1;
    
    assign w2 = d ? 1'b1 : 1'b0;
    assign mux_in[3] = c ? w2 : 1'b0;
    

endmodule
