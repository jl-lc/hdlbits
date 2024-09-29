module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    wire x;
    always @(*) begin // q = 1 when even # of inputs 
        x = 1;
        x = a ? ~x : x;
        x = b ? ~x : x;
        x = c ? ~x : x;
        x = d ? ~x : x;
    end

    assign q = x; // Fix me

endmodule