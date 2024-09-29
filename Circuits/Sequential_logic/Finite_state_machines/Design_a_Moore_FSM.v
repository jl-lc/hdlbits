module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    
    parameter s0=0, s1=1, s2=2, s3=3;
    reg [3:0] state, next_state;
    
    assign next_state[s0] = s == 3'b000;
    assign next_state[s1] = s == 3'b001;
    assign next_state[s2] = s == 3'b011;
    assign next_state[s3] = s == 3'b111;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 4'b0001;
            dfr <= 1'b1;
        end
        else begin
            state <= next_state;
            if (state > next_state)
                dfr <= 1'b1;
            else if (state < next_state)
                dfr <= 1'b0;
            else
                dfr <= dfr;
        end
    end
    
    always @(*) begin
        case (state)
            4'b0001: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b1;
            end
            4'b0010: begin
                fr1 = 1'b1;
                fr2 = 1'b1;
                fr3 = 1'b0;
            end
            4'b0100: begin
                fr1 = 1'b1;
                fr2 = 1'b0;
                fr3 = 1'b0;
            end
            default: begin
                fr1 = 1'b0;
                fr2 = 1'b0;
                fr3 = 1'b0;
            end
        endcase
    end
    

endmodule
