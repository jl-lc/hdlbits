module top_module (
    input clk,
    input reset,     // synchronous active-high reset
    input w,
    output z);
    
    parameter A=3'b000, B=3'b001, C=3'b010, D=3'b011, E=3'b100, F=3'b101;
    reg [2:0] state, next;
    
    // state transition logic
    always @(*)
        case (state)
            A: next = ~w ? A : B;
            B: next = ~w ? D : C;
            C: next = ~w ? D : E;
            D: next = ~w ? A : F;
            E: next = ~w ? D : E;
            F: next = ~w ? D : C;
            default: next = A;
        endcase  
    
    // state ff
    always @(posedge clk)
        state <= reset ? A : next;
    
    // output
    assign z = state == E | state == F;

endmodule
