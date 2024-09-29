module top_module();
    reg clk = 0;
    reg in;
    reg [2:0] s;
    wire out;
    q7 dut (.clk(clk), .in(in), .s(s), .out(out));
	initial
        for (int i = 0; i < 20; i++)
            #5 clk <= ~clk;
    initial begin
        s = 3'h2; in = 0;
        #10 s = 3'h6;
        #10 s = 3'h2; in = 1;
        #10 s = 3'h7; in = 0;
        #10 s = 3'b0; in = 1;
        #30 in = 0;
    end
endmodule
