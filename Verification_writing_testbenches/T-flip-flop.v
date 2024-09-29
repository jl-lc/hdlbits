module top_module ();
    reg clk = 0;
    reg reset, t;
    wire q;
    tff dut (.clk(clk), .reset(reset), .t(t), .q(q));
    initial
        forever
            #5 clk = ~clk;
    initial begin
        reset = 1;
        t = 0;
        #10 reset = 0;
        #10 t = 1;
    end
endmodule
