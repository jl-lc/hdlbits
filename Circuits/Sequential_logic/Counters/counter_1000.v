module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
    reg [3:0] q0, q1, q2;
    
    assign OneHertz = q2 == 4'h9 && q1 == 4'h9 && q0 == 4'h9;
    
    assign c_enable[0] = ~reset;
    assign c_enable[1] = ~reset && q0 == 4'h9;
    assign c_enable[2] = ~reset && q1 == 4'h9 && q0 == 4'h9;

    bcdcount counter0 (clk, reset, c_enable[0], q0);
    bcdcount counter1 (clk, reset, c_enable[1], q1);
    bcdcount counter2 (clk, reset, c_enable[2], q2);

endmodule
