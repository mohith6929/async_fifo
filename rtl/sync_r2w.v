module sync_r2w #(
    parameter a_size = 4
)
(
    input wire w_clk,
    input wire wrst_n,
    input wire [a_size:0] rptr,
    output reg [a_size:0] wq2_rptr
);

reg [a_size:0] wq1_rptr;

always @(posedge w_clk or negedge wrst_n)
begin
    if (!wrst_n) begin
        wq1_rptr <= 'b0;
        wq2_rptr <= 'b0;
    end
    else
    begin
        wq1_rptr <= rptr;
        wq2_rptr <= wq1_rptr;
    end
end

endmodule