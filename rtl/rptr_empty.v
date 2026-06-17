module rptr_empty #(
    parameter a_size = 4
)
(
    input wire r_clk,
    input wire rrst_n,
    input wire r_en,
    input wire [a_size:0] rq2_wptr,
    output reg r_empty,
    output reg [a_size-1:0] r_addr,
    output reg [a_size:0] rptr
);

wire r_empty_nxt;
wire rinc;
reg [a_size:0] rbin;
wire [a_size:0] rbin_nxt;
wire [a_size:0] rgray_nxt;

always @(posedge r_clk or negedge rrst_n)
begin
    if (!rrst_n) begin
        rbin <= 'b0;
        r_addr <= 'b0;
        rptr <= 'b0;
        r_empty <= 1'b1;
    end
    else begin
        rbin <= rbin_nxt;
        rptr <= rgray_nxt;
        r_empty <= r_empty_nxt;
        r_addr <= rbin [a_size-1:0];
        
    end
end

assign rinc = r_en & !r_empty;
assign rgray_nxt = (rbin_nxt >> 1) ^ rbin_nxt;
assign r_empty_nxt = (rgray_nxt == rq2_wptr);
assign rbin_nxt = rbin + rinc;


endmodule