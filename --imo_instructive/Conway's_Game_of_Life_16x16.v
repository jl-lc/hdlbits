/*Conway's Game of Life is a two-dimensional cellular automaton.

The "game" is played on a two-dimensional grid of cells, where each cell is either 1 (alive) or 0 (dead). At each time step, each cell changes state depending on how many neighbours it has:

0-1 neighbour: Cell becomes 0.
2 neighbours: Cell state does not change.
3 neighbours: Cell becomes 1.
4+ neighbours: Cell becomes 0.
The game is formulated for an infinite grid. In this circuit, we will use a 16x16 grid. To make things more interesting, we will use a 16x16 toroid, where the sides wrap around to the other side of the grid. For example, the corner cell (0,0) has 8 neighbours: (15,1), (15,0), (15,15), (0,1), (0,15), (1,1), (1,0), and (1,15). The 16x16 grid is represented by a length 256 vector, where each row of 16 cells is represented by a sub-vector: q[15:0] is row 0, q[31:16] is row 1, etc. (This tool accepts SystemVerilog, so you may use 2D vectors if you wish.)

load: Loads data into q at the next clock edge, for loading initial state.
q: The 16x16 current state of the game, updated every clock cycle.
The game state should advance by one timestep every clock cycle.

John Conway, mathematician and creator of the Game of Life cellular automaton, passed away from COVID-19 on April 11, 2020.
*/

module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    
    int row_b, row_u, cel_l, cel_r;
    int neighbour;
    
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            for (int row = 0; row < 16; row++) begin // row
                for (int cel = 0; cel < 16; cel++) begin // cell
                    row_b = row == 0  ? 15 : row - 1;
                    row_u = row == 15 ? 0  : row + 1;
                    cel_r = cel == 0  ? 15 : cel - 1;
                    cel_l = cel == 15 ? 0  : cel + 1;
                    
                    neighbour = q[cel_l+row_u*16] +
                    			q[cel  +row_u*16] +
                    			q[cel_r+row_u*16] +
                    			q[cel_l+row  *16] +
                    			q[cel_r+row  *16] +
                    			q[cel_l+row_b*16] +
                    			q[cel  +row_b*16] +
                    			q[cel_r+row_b*16];
                    
                    case (neighbour)
                        2:
                            q[cel+row*16] <= q[cel+row*16];
                        3:
                            q[cel+row*16] <= 1'b1;
                        default:
                            q[cel+row*16] <= 1'b0;
                    endcase
                end
            end
    end
                    

endmodule
