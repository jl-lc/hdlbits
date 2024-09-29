module top_module (
    input [3:1] y,
    input w,
    output Y2);
    
    parameter A=3'b000, B=3'b001, C=3'b010, D=3'b011, E=3'b100, F=3'b101;
    reg [3:1] next_y;
    
    // state transition logic
    always @(*)
        case (y)
            A: next_y = w ? A : B;
            B: next_y = w ? D : C;
            C: next_y = w ? D : E;
            D: next_y = w ? A : F;
            E: next_y = w ? D : E;
            F: next_y = w ? D : C;
            default: next_y = A;
        endcase  
    
    assign Y2 = next_y[2];

endmodule
