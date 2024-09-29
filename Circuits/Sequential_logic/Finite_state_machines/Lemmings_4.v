module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter FALL_L=0, FALL_R=1, DIG_L=2, DIG_R=3, LEFT=4, RIGHT=5, SPLAT=6;
    reg [2:0] state, next_state;
    reg [4:0] count;
    wire die;
    
    always @(*) begin
        case (state)
            FALL_L: begin
                if (die)
                    next_state = SPLAT;
                else if (ground)
                    next_state = LEFT;
                else
                    next_state = FALL_L;
            end
            FALL_R: begin
                if (die)
                    next_state = SPLAT;
                else if (ground)
                    next_state = RIGHT;
                else
                    next_state = FALL_R;
            end
            DIG_L: begin
                if (~ground)
                    next_state = FALL_L;
                else
                    next_state = DIG_L;
            end
            DIG_R: begin
                if (~ground)
                    next_state = FALL_R;
                else
                    next_state = DIG_R;
            end
            LEFT: begin
                if (~ground)
                    next_state = FALL_L;
                else if (dig)
                    next_state = DIG_L;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (~ground)
                    next_state = FALL_R;
                else if (dig)
                    next_state = DIG_R;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            SPLAT:
                next_state = SPLAT;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= LEFT;
            count <= 5'b00000;
        end
        else begin
            state <= next_state;
            if (count > 5'd20)
                count <= count;
            else if (next_state == FALL_L | next_state == FALL_R)
                count <= count + 1;
            else
                count <= 5'b00000;
        end
    end
    
    assign die = (areset | count <= 5'd20) ? 0 : ground;
    
    assign walk_left = state == LEFT;
    assign walk_right = state == RIGHT;
    assign aaah = state == FALL_L | state == FALL_R;
    assign digging = state == DIG_L | state == DIG_R;

endmodule
