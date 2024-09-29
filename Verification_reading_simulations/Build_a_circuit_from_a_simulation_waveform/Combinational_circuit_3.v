module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    // PoS
    assign q = (a | b) & (c | d); // Fix me

endmodule
