module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
    // State transition logic (combinational)
	parameter stall=0, byte1=1, byte2=2, byte3=3;
    reg [1:0] state, next_state;
    always @(*) begin
        case (state)
            stall:
                next_state = in[3] ? byte2 : stall;
            byte1:
                next_state = in[3] ? byte2 : stall;
            byte2:
                next_state = byte3;
            byte3:
                next_state = byte1;
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset)
            state <= stall;
		else
            state <= next_state;
    end
 
    // Output logic
    assign done = state == byte1;

    // New: Datapath to store incoming bytes.
    always @(posedge clk) begin
        case (state)
            stall:
                out_bytes[23:16] = in;
            byte1:
                out_bytes[23:16] = in;
            byte2:
                out_bytes[15:8] = in;
            byte3:
                out_bytes[7:0] = in;
        endcase        
    end

endmodule
