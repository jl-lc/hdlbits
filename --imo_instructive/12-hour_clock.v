module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    reg [6:0] en, enable;
    reg [7:0] res_val;
    reg ampm09, ampm12;
    assign ampm09 = hh == 8'h09;
    assign ampm12 = hh == 8'h12;
    assign en = {hh[7:4] == 4'h1 && &en[5:0],
                (ampm09 || ampm12) && &en[4:0],
                mm[7:4] == 4'h5 && &en[3:0],
                mm[3:0] == 4'h9 && &en[2:0],
                ss[7:4] == 4'h5 && &en[1:0],
                ss[3:0] == 4'h9 && en[0], 
                ena};
    assign enable = {7{reset}} | en;
    
    always @(*) begin
        if (reset)
            res_val = 8'h12;
        else if (ampm09)
            res_val = 8'h10;
        else if (ampm12) // for readability, shouldn't reach else{}
            res_val = 8'h01;
        else
            res_val = 8'h00;
    end
    always @(posedge clk) begin
        if (reset)
            pm <= 1'b0;
        else begin
            if (hh == 8'h11 && &en[4:0]) // 11:59:59
                pm <= ~pm;
            else
                pm <= pm;
        end
    end            
    
    bcd s0 (.clk(clk), .reset(enable[1]), .res_val(4'h0),         .en(enable[0]), .out(ss[3:0]));
    bcd s1 (.clk(clk), .reset(enable[2]), .res_val(4'h0),         .en(enable[1]), .out(ss[7:4]));
    bcd m0 (.clk(clk), .reset(enable[3]), .res_val(4'h0),         .en(enable[2]), .out(mm[3:0]));
    bcd m1 (.clk(clk), .reset(enable[4]), .res_val(4'h0),         .en(enable[3]), .out(mm[7:4]));
    bcd h0 (.clk(clk), .reset(enable[5]), .res_val(res_val[3:0]), .en(enable[4]), .out(hh[3:0]));
    bcd h1 (.clk(clk), .reset(enable[6]), .res_val(res_val[7:4]), .en(enable[5]), .out(hh[7:4]));

endmodule

module bcd (
    input clk,
    input reset,
    input [3:0] res_val,
    input en,
    output [3:0] out);
    
    always @(posedge clk) begin
        if (reset) 
            out <= res_val;
        else if (en)
            out <= out + 1;
        else
            out <= out;
    end
endmodule
