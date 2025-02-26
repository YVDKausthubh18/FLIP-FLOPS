module JK_FF (
    input clk,         
    input reset,       
    input j,          
    input k,          
    output reg q      
);
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 0;       
    else if (j == 0 && k == 0)
        q <= q;       
    else if (j == 0 && k == 1)
        q <= 0;       
    else if (j == 1 && k == 0)
        q <= 1;       
    else
        q <= ~q;      
end
endmodule
