module async_fifo #(
    parameter a_size = 4,
    parameter d_size = 8
)(
    input wire w_clk,
    input wire w_en,
    input wire wrst_n,
    input wire r_clk,
    input wire r_en,
    input wire rrst_n,
    input wire [d_size-1:0] w_data,
    output wire [d_size-1:0] r_data,
    output wire w_full,
    output wire r_empty
);

wire [a_size-1:0] r_addr;
wire [a_size-1:0] w_addr;

fifo_mem #(
    .a_size(a_size),
    .d_size(d_size)
)memo(
    .r_clk(r_clk),
    .w_clk(w_clk),
    .w_en(w_en),
    .r_en(r_en),
    .w_data(w_data),
    .r_data(r_data),
    .r_addr(r_addr),
    .w_addr(w_addr)
);

wire [a_size:0] wq2_rptr;
wire [a_size:0] wptr;

wptr_full #(
    .a_size(a_size)
)wptr_full (
    .w_clk(w_clk),
    .w_en(w_en),
    .wrst_n(wrst_n),
    .w_full(w_full),
    .w_addr(w_addr),
    .wq2_rptr(wq2_rptr),
    .wptr(wptr)
);

wire [a_size:0] rq2_wptr;
wire [a_size:0] rptr;

rptr_empty #(
    .a_size(a_size)
)rptr_empty (
    .r_clk(r_clk),
    .r_en(r_en),
    .rrst_n(rrst_n),
    .r_empty(r_empty),
    .r_addr(r_addr),
    .rq2_wptr(rq2_wptr),
    .rptr(rptr)
);

sync_r2w #(
    .a_size(a_size)
)sync_r2w (
    .w_clk(w_clk),
    .wrst_n(wrst_n),
    .rptr(rptr),
    .wq2_rptr(wq2_rptr)
);

sync_w2r #(
    .a_size(a_size)
)sync_w2r (
    .r_clk(r_clk),
    .rrst_n(rrst_n),
    .wptr(wptr),
    .rq2_wptr(rq2_wptr)
);
endmodule