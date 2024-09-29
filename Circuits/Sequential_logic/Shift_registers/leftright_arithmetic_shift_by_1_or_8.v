module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
    
    always @(posedge clk) begin
        if (load)
            q <= data;
        else if (ena)
            case (amount)
                2'b00 : // asl 1
                    q <= {q[62:0], 1'b0};
                2'b01 : // asl 8
                    q <= {q[55:0], 8'h00};
                2'b10 : // asr 1
                    q <= {q[63], q[63:1]};
                default : // asr 8
                    q <= {{8{q[63]}}, q[63:8]};
        	endcase
        else
            q <= q;
    end

endmodule
