module SR_FF (
    input clk,
    input reset,   // Add reset to ensure proper initialization
    input s,
    input r,
    output reg q
);

initial q = 0; // Initialize q to 0

always @(posedge clk or posedge reset) begin
    if (reset) 
        q <= 0; // Reset q to 0 when reset is high
    else if (s == 1 && r == 0) 
        q <= 1; // Set
    else if (s == 0 && r == 1) 
        q <= 0; // Reset
    else if (s == 0 && r == 0) 
        q <= q; // Hold state
    else 
        q <= 0; // Instead of X, force q to 0 on invalid input
end

endmodule
