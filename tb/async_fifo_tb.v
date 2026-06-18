module async_fifo_tb;
reg w_clk;
reg w_en;
reg wrst_n;
reg r_clk;
reg r_en;
reg rrst_n;
reg [7:0] w_data;
wire [7:0] r_data;
wire w_full;
wire r_empty;

async_fifo dut (
    .w_clk(w_clk),
    .w_en(w_en),
    .wrst_n(wrst_n),
    .r_clk(r_clk),
    .r_en(r_en),
    .rrst_n(rrst_n),
    .w_data(w_data),
    .r_data(r_data),
    .w_full(w_full),
    .r_empty(r_empty)
);

always #5 w_clk = ~w_clk;
always #13 r_clk = ~r_clk;

initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0, async_fifo_tb);

    
    w_clk = 0;
    r_clk = 0;

    wrst_n = 0;
    rrst_n = 0;

    w_en = 0;
    r_en = 0;

    w_data = 'b0;


    #20 wrst_n = 1; rrst_n = 1;

    @(negedge w_clk);
    w_en = 1;
    w_data = 8'h07;
    @(negedge w_clk);
    w_en = 1;
    w_data = 8'hA5;
    @(negedge w_clk);
    w_en = 1;
    w_data = 8'hB5;
    @(negedge w_clk);
    w_en = 1;
    w_data = 8'hC5;
    @(negedge w_clk);
    w_en = 0;

    @(negedge r_clk);
    r_en = 1;
    @(negedge r_clk);
    r_en = 1;
    @(negedge r_clk);
    r_en = 1;
    @(negedge r_clk);
    r_en = 1;
    @(negedge r_clk);
    r_en = 1;
    @(negedge r_clk);
    r_en = 0;

    


    #1000;
    $finish;
end

endmodule