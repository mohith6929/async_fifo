module sync_w2r #(
    parameter a_size = 4
)
(
    input wire r_clk,
    input wire rrst_n,
    input wire [a_size:0] wptr,
    output reg [a_size:0] rq2_wptr
);

reg [a_size:0] rq1_wptr;

always @(posedge r_clk or negedge rrst_n)
begin
    if (!rrst_n) begin
        rq1_wptr <= 'b0;
        rq2_wptr <= 'b0;
    end
    else
    begin
        rq1_wptr <= wptr;
        rq2_wptr <= rq1_wptr;
    end
end

endmodule