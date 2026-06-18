module fifo_mem #(
    parameter a_size = 4,
    parameter d_size = 8
)
(
    input wire w_clk,
    input wire w_en,
    input wire r_clk,
    input wire r_en,
    input wire [a_size-1:0] w_addr,
    input wire [d_size-1:0] w_data,
    input wire [a_size-1:0] r_addr,
    output reg [d_size-1:0] r_data
);

reg [d_size-1:0] mem [0:(1<<a_size)-1];

always @(posedge w_clk) begin
    if (w_en) begin
        mem[w_addr] <= w_data;
    end
end

always @(posedge r_clk)
begin
    if (r_en) begin
        r_data <= mem[r_addr];
    end
end

endmodule