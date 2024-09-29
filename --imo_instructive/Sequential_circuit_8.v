module top_module (
    input clock,
    input a,
    output p,
    output q );
    
    always @(clock)
        p <= clock ? a : p; // latch
    always @(negedge clock)
        q <= p; // ff

endmodule
