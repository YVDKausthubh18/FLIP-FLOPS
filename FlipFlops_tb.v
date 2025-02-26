`timescale 1ns / 1ps

module FlipFlops_tb;

    reg clk, reset;
    reg d, t, j, k, s, r;
    wire q_d, q_t, q_jk, q_sr;

    // Instantiate D Flip-Flop
    D_FF d_ff (.clk(clk), .reset(reset), .d(d), .q(q_d));

    // Instantiate T Flip-Flop
    T_FF t_ff (.clk(clk), .reset(reset), .t(t), .q(q_t));  // ✅ Fixed case sensitivity

    // Instantiate JK Flip-Flop
    JK_FF jk_ff (.clk(clk), .reset(reset), .j(j), .k(k), .q(q_jk));

    // Instantiate SR Flip-Flop
    SR_FF sr_ff (.clk(clk), .s(s), .r(r), .q(q_sr));

    // Clock Generation (Period = 10ns)
    always #5 clk = ~clk;

    // Test Sequence
    initial begin
        clk = 0; reset = 1;
        d = 0; t = 0; j = 0; k = 0; s = 0; r = 0;  // Initialize all inputs
        #10 reset = 0; // Release reset
        
        // Test D Flip-Flop
        #10 d = 1;
        #10 d = 0;

        // Test T Flip-Flop
        #10 t = 1;
        #10 t = 0;
        #10 t = 1;

        // Test JK Flip-Flop
        #10 j = 1; k = 0;  // Set
        #10 j = 0; k = 1;  // Reset
        #10 j = 1; k = 1;  // Toggle
        #10 j = 0; k = 0;  // Hold state

        // Test SR Flip-Flop
        #10 s = 1; r = 0;  // Set
        #10 s = 0; r = 1;  // Reset
        #10 s = 1; r = 1;  // Invalid state
        #10 s = 0; r = 0;  // Hold state

        #10 reset = 1; // Reset all flip-flops again
        #10 reset = 0;

        #50 $finish; // End simulation
    end

    // Monitor Outputs
    initial begin
        $monitor("Time=%0d | D=%b, Q_D=%b | T=%b, Q_T=%b | J=%b, K=%b, Q_JK=%b | S=%b, R=%b, Q_SR=%b", 
                 $time, d, q_d, t, q_t, j, k, q_jk, s, r, q_sr);
    end

endmodule
