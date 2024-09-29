module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
                           // lazy here sry
    assign out = (~b&~c) | ((a|b)&c&d) | (~a&b&~d) | (~a&~b&~d);

endmodule
