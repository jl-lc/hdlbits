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
