module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    parameter A=0, out_f=1, x_patt_1=2, x_patt_2=3, x_patt_3=4, y_cnt_1=5, y_cnt_2=6, fin=7;
    reg [2:0] state, next;
    reg [1:0] y_count;
    
    // state transition logic
    always @(*) begin
        case (state)
            A	  	: next = out_f;
            out_f	: next = x_patt_1;
            x_patt_1: next = x  ? x_patt_2 : x_patt_1;
            x_patt_2: next = ~x ? x_patt_3 : x_patt_2;
            x_patt_3: next = x  ? y_cnt_1  : x_patt_1;
            y_cnt_1 : next = y_cnt_2;
            y_cnt_2 : next = fin;
			fin     : next = fin;
            default	: next = A;
        endcase
    end
    
    always @(posedge clk) begin
        case (state)
            A: y_count <= 3'b000;
            y_cnt_1: y_count <= y_count + y;
            y_cnt_2: y_count <= y_count + y;
            default: y_count <= y_count;
        endcase
    end
    
    // state flip flops
    always @(posedge clk) 
        state <= ~resetn ? A : next;
    
    // output logic
	assign f = 	state == out_f;
    assign g = 	state == fin ? y_count >= 1 : state >= y_cnt_1 ? 1 : 0;

endmodule
