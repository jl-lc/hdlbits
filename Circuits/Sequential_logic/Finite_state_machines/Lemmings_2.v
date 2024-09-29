module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter LEFT=0, RIGHT=1, FALL_L=2, FALL_R=3;
    reg [1:0] state, next_state;
    
    always @(*) begin
        case (state)
            LEFT: begin
                if (~ground)
                    next_state = FALL_L;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (~ground)
                    next_state = FALL_R;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            FALL_L: begin
                if (ground)
                    next_state = LEFT;
                else
                    next_state = FALL_L;
            end
            FALL_R: begin
                if (ground)
                    next_state = RIGHT;
                else
                    next_state = FALL_R;
            end
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    
    assign walk_left = state == LEFT;
    assign walk_right = state == RIGHT;
    assign aaah = state == FALL_L | state == FALL_R;

endmodule
