module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    
    parameter a=0, b=1;
    reg state, next;
    reg [1:0] clk_cnt, cnt;
    
    // state transition logic
    always @(*)
        case (state)
            a: next = s ? b : a;
            b: next = b;
            default: next = a;
        endcase
    
    // state flip flops
    always @(posedge clk)
        state <= reset ? a : next;
    
    // counter
    always @(posedge clk) begin
        case (state)
            a: begin
                clk_cnt <= 0;
                cnt <= 0;
            end
            b: begin
                if (reset || clk_cnt == 3) begin
                    clk_cnt <= 1;
                    cnt <= w;
                end
                else begin
                    clk_cnt <= clk_cnt + 1;
                    cnt <= cnt + w;
                end
            end
            default: begin
                clk_cnt <= clk_cnt;
                cnt <= cnt;
            end
        endcase
    end
    
    assign z = clk_cnt == 3 & cnt == 2;

endmodule
