module wptr_full #(
    parameter a_size = 4
)(
    input wire w_clk,
    input wire w_en,
    input wire wrst_n,
    input wire [a_size:0] wq2_rptr,
    output reg w_full,
    output wire [a_size-1:0] w_addr,
    output reg [a_size:0] wptr
);

reg [a_size:0] wbin;
wire [a_size:0] wbin_nxt;
wire w_full_nxt;
wire [a_size:0] wgray_nxt;
wire winc;

always @(posedge w_clk or negedge wrst_n)
begin
    if (!wrst_n)
    begin
        w_full <= 'b0;
        wbin <= 'b0;
        wptr <= 'b0;
    end
    else begin
        wbin <= wbin_nxt;
        w_full <= w_full_nxt;
        wptr <= wgray_nxt;
    end
end

assign winc = w_en && !w_full;
assign wbin_nxt = wbin + winc;
assign w_full_nxt = (wq2_rptr[a_size-2:0] == wgray_nxt[a_size-2:0]) && (~wq2_rptr[a_size:a_size-1] == wgray_nxt[a_size:a_size-1]);
assign wgray_nxt = (wbin_nxt >> 1) ^ wbin_nxt;
assign w_addr = wbin[a_size-1:0];

endmodule