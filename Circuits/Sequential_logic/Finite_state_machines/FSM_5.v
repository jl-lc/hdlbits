module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    
    parameter A=0, B=1, C=2, D=3;
    reg [1:0] state, next;
    
    // state transition logic
    always @(*)
        case (state)
            A: begin
                if (~|r)
                    next = A;
                else if (r[1])
                    next = B;
                else if (~r[1] & r[2])
                    next = C;
                else if (~r[1] & ~r[2] & r[3])
                    next = D;
                else
                    next = A;
            end
            B: next = r[1] ? B : A;
            C: next = r[2] ? C : A;
            D: next = r[3] ? D : A;
        endcase
    
    // state ff
    always @(posedge clk)
        state <= ~resetn ? A : next;
    
    // output logic
    assign g = {state == D, state == C, state == B};

endmodule
