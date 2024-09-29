module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    parameter s0=0, s1=1, s2=2, s3=3, s4=4, s5=5, s6=6, s7=7, s8=8, s9=9;
    
    assign next_state[s0] = |{state[s9:s7], state[s4:s0]} & ~in ? 1 : 0;
    assign next_state[s1] = |{state[s9:s8], state[s0]} & in ? 1 : 0;
    assign next_state[s2] = state[s1] & in ? 1 : 0;
    assign next_state[s3] = state[s2] & in ? 1 : 0;
    assign next_state[s4] = state[s3] & in ? 1 : 0;
    assign next_state[s5] = state[s4] & in ? 1 : 0;
    assign next_state[s6] = state[s5] & in ? 1 : 0;
    assign next_state[s7] = |state[s7:s6] & in ? 1 : 0;
    assign next_state[s8] = state[s5] & ~in ? 1 : 0;
    assign next_state[s9] = state[s6] & ~in ? 1 : 0;
    
    assign out1 = state[8] | state[9];
    assign out2 = state[7] | state[9];

endmodule
