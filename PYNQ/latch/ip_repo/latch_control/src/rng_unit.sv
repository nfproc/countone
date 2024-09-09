// Latch-latch TRNG unit w/ dynamic feedback 2022.10.12 Naoki F., AIT

module RNG_UNIT (
    input  logic         CLK, RST_X,
    input  logic         RNG_EN,
    input  logic [31: 0] PARAM,  // used as the initial number of accum.
    output logic [31: 0] DATA_OUT,
    output logic         DATA_EN,
    output logic [31: 0] STATS);  // to reset output fifo

    parameter  NUM_LATCH = 32;
    localparam PASS_MIN  = 16'd2164;
    localparam PASS_MAX  = 16'd2836;
    localparam MONO_MIN  = 14'd7600;
    localparam MONO_MAX  = 14'd8400;

    // counter signals for number of accumulation
    // NOTE: num_accum value = actual number of times of accumulation minus one
    logic [ 5: 0] cnt_out, n_cnt_out;
    logic [ 4: 0] cnt_check, n_cnt_check;
    logic [ 4: 0] num_accum, n_num_accum, init_accum;
    logic [ 4: 0] num_margin;
    logic         mono_enable;

    assign STATS       = {27'h0, num_accum};
    assign init_accum  = PARAM[4:0];   // initial number of accumulation
    assign num_margin  = PARAM[12:8];  // margin between test and output
    assign mono_enable = PARAM[16];    // monobit test enable

    // instantiation of unit of TRNG (including S/P conversion)
    logic [31: 0] latch_data_out /* verilator public_flat */;
    logic         latch_data_en /* verilator public_flat */;

    RNG_LATCH # (
        .NUM_LATCH(NUM_LATCH))
    rng_inst (
        .CLK      (CLK),
        .RST_X    (RST_X),
        .RNG_EN   (RNG_EN),
        .DATA_OUT (latch_data_out),
        .DATA_EN  (latch_data_en));

    // instantiation of fifo between TRNG and output
    logic [31: 0] ofifo_data_w;
    logic [31: 0] ofifo_data_r;
    logic         ofifo_we, ofifo_re;
    logic         ofifo_full, ofifo_reject;

    fifo # (
        .WIDTH   (32),
        .SIZE    (512))
    fifo_out (
        .CLK     (CLK),
        .RST     (~RST_X),
        .DATA_W  (ofifo_data_w),
        .DATA_R  (ofifo_data_r),
        .WE      (ofifo_we),
        .RE      (ofifo_re),
        .EMPTY   (),
        .FULL    (ofifo_full),
        .SOFT_RST(ofifo_reject));
    
    assign ofifo_data_w = latch_data_out;
    assign ofifo_we     = latch_data_en && cnt_out == 5'd0;
    assign ofifo_re     = ofifo_full;
    assign DATA_OUT     = ofifo_data_r;
    assign DATA_EN      = ofifo_full;

    // instantiation of fifo between TRNG and quality check unit
    logic [31: 0] cfifo_data_w;
    logic [ 7: 0] cfifo_data_r;
    logic         cfifo_we, cfifo_re;
    logic         cfifo_empty, cfifo_full /* verilator public_flat */;

    rng_fifo fifo_check (
        .CLK     (CLK),
        .RST     (~RST_X),
        .DATA_W  (cfifo_data_w),
        .DATA_R  (cfifo_data_r),
        .WE      (cfifo_we),
        .RE      (cfifo_re),
        .EMPTY   (cfifo_empty),
        .FULL    (cfifo_full),
        .SOFT_RST(~RNG_EN));

    assign cfifo_data_w  = latch_data_out;
    assign cfifo_we      = latch_data_en && cnt_check == 5'd0 && ~ cfifo_full;

    // instantiation of on-line quality check unit (count the ones)
    logic [ 7: 0] check_in_tdata;
    logic         check_in_tvalid, check_in_tready;
    logic [31: 0] check_out_tdata /* verilator public_flat */;
    logic         check_out_tvalid /* verilator public_flat */, check_out_tready;
    logic         check_out_pass;
    logic [15: 0] check_mono_tdata /* verilator public_flat */;
    logic         check_mono_tvalid, check_mono_tready;
    logic         check_mono_pass, check_mono_fail /* verilator public_flat */;

    countone check_inst (
        .ap_clk         (CLK),
        .ap_rst_n       (RST_X & RNG_EN),
        .rand_in_TDATA  (check_in_tdata),
        .rand_in_TVALID (check_in_tvalid),
        .rand_in_TREADY (check_in_tready),
        .rslt_out_TDATA (check_out_tdata),
        .rslt_out_TVALID(check_out_tvalid),
        .rslt_out_TREADY(check_out_tready),
        .freq_out_TDATA (check_mono_tdata),
        .freq_out_TVALID(check_mono_tvalid),
        .freq_out_TREADY(check_mono_tready));
    
    assign check_in_tdata    = cfifo_data_r;
    assign check_in_tvalid   = ~ cfifo_empty;
    assign cfifo_re          = check_in_tready & ~ cfifo_empty;
    assign check_out_tready  = 1'b1;
    assign check_out_pass    = check_out_tdata[31:16] >= PASS_MIN &&
                               check_out_tdata[31:16] <= PASS_MAX;
    assign check_mono_tready = 1'b1;
    assign check_mono_pass   = check_mono_tdata >= MONO_MIN &&
                               check_mono_tdata <= MONO_MAX;
    assign check_mono_fail   = mono_enable & check_mono_tvalid & ~ check_mono_pass;
    assign ofifo_reject      = check_mono_fail;
    
    // control of counters for number of accumulation
    always_comb begin
        n_cnt_out   = cnt_out;
        n_cnt_check = cnt_check;
        n_num_accum = num_accum;
        if (~ RNG_EN) begin
            // initialize
            n_cnt_out   = init_accum + num_margin;
            n_cnt_check = init_accum;
            n_num_accum = init_accum;
        end else begin
            if (latch_data_en) begin
                n_cnt_out   = (cnt_out   == 6'd0) ? num_accum + num_margin : cnt_out - 1'd1;
                n_cnt_check = (cnt_check == 5'd0) ? num_accum : cnt_check - 1'd1;
            end
            if (check_out_tvalid | check_mono_fail) begin
                if (check_out_tvalid & check_out_pass) begin
                    n_num_accum = (num_accum != 5'd0) ? num_accum - 1'd1 : 5'd0;
                end else begin
                    n_num_accum = (num_accum != 5'd31) ? num_accum + 1'd1 : 5'd31;
                end
            end
        end
    end

    always_ff @ (posedge CLK) begin
        if (~ RST_X) begin
            cnt_out   <= 6'd0;
            cnt_check <= 5'd0;
            num_accum <= 5'd0;
        end else begin
            cnt_out   <= n_cnt_out;
            cnt_check <= n_cnt_check;
            num_accum <= n_num_accum;
        end
    end
endmodule