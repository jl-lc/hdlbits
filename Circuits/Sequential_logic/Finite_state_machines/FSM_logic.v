module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    
    always @(*) begin
        case (y)
            3'b000: begin
                Y0 = x;
                z  = 0;
            end
            3'b001: begin
                Y0 = ~x;
                z  = 0;
            end
            3'b010: begin
                Y0 = x;
                z  = 0;
            end
            3'b011: begin
                Y0 = ~x;
                z  = 1;
            end
            3'b100: begin
                Y0 = ~x;
                z  = 1;
            end
            default: begin
                Y0 = 0;
                z  = 0;
            end
        endcase
    end

endmodule
