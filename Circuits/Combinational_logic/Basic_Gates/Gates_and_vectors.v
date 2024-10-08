module top_module( 
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different );
    
    always @(*) begin
        for (int i = 0; i < 3; i++)
            out_both[i] = in[i] & in[i+1];
        
        for (int i = 1; i < 4; i++)
            out_any[i] = in[i] | in[i-1];
        
        for (int i = 0; i < 3; i++)
            out_different[i] = in[i] ^ in[i+1];
        out_different[3] = in[3] ^ in[0];
    end
endmodule
