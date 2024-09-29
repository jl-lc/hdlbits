module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
    // Use FSM from Fsm_serial
    parameter start=0, data=1, parity=2, stop=3, error=4;
    reg [2:0] state, next_state;
    reg [3:0] count;
    wire odd, reset_p;
    
    // state transition logic
    always @(*) begin
        case (state) 
            start: begin
                if (~in)
                	next_state = data;
            	else
                    next_state = start;
            end
            data: begin
                if (count == 4'h9)
                    next_state = parity;
                else
                    next_state = data;
            end
            parity: begin
                if (in)
                    next_state = stop;
                else
                    next_state = error;
            end
            stop: begin
                if (~in)
                    next_state = data;
                else
                    next_state = start;
            end
            error: begin
                if (in)
                	next_state = start;
            	else
                	next_state = error;
            end
            default:
                next_state = start;
        endcase
    end
    
    // state ffs
    always @(posedge clk) begin
        if (reset) begin
            state <= start;
            count = 4'h0;
        end
        else begin
            state <= next_state;
            if (next_state == data && count < 4'hF) // no overflow
                count = count + 1;
            else
                count = 4'h0;
        end
    end
    
    // output logic
	assign done = state == stop & ~odd;

    // New: Datapath to latch input bits.
    always @(posedge clk) begin
        if (count < 4'ha)
            out_byte[count-1] <= in;
    end

    // New: Add parity checking.
    assign reset_p = state != data & state != parity;
    parity p1 (.clk(clk), .reset(reset_p), .in(in), .odd(odd));

endmodule
