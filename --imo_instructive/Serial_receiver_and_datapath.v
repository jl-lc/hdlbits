module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
    parameter start=0, data=1, stop=2, error=3;
    reg [1:0] state, next_state;
    reg [3:0] count;
    
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
                if (count == 4'h9 && in)
                    next_state = stop;
                else if (count == 4'h9 && ~in)
                    next_state = error;
                else
                    next_state = data;
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
	assign done = state == stop;

    // New: Datapath to latch input bits.
    always @(posedge clk) begin
        if (count < 4'ha)
            out_byte[count-1] <= in;
    end

endmodule
