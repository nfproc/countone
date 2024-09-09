// FIFO with data width conversion 2022.10.05 Naoki F., AIT
// ライセンス条件は COPYING ファイルを参照してください

module rng_fifo (
    input  logic         CLK, RST,
    input  logic [31: 0] DATA_W,
    output logic [ 7: 0] DATA_R,
    input  logic         WE, RE,
    output logic         EMPTY, FULL,
    input  logic         SOFT_RST);

    logic [31: 0] fifo_data_w, fifo_data_r;
    logic         fifo_we, fifo_re;
    logic         fifo_empty, fifo_full;
    logic [ 1: 0] cnt_byte, n_cnt_byte;

    fifo # (
        .WIDTH(32),
        .SIZE (512))
    fifo_inst (
        .CLK     (CLK),
        .RST     (RST),
        .DATA_W  (fifo_data_w),
        .DATA_R  (fifo_data_r),
        .WE      (fifo_we),
        .RE      (fifo_re),
        .EMPTY   (fifo_empty),
        .FULL    (fifo_full),
        .SOFT_RST(SOFT_RST));

    assign fifo_data_w = DATA_W;
    assign DATA_R      = (cnt_byte == 2'd0) ? fifo_data_r[31:24] :
                         (cnt_byte == 2'd1) ? fifo_data_r[23:16] :
                         (cnt_byte == 2'd2) ? fifo_data_r[15: 8] : fifo_data_r[ 7: 0];
    assign fifo_we     = WE;
    assign fifo_re     = RE && cnt_byte == 2'd3;
    assign EMPTY       = fifo_empty;
    assign FULL        = fifo_full;
    assign n_cnt_byte  = (SOFT_RST) ? 2'd0 :
                         (RE & ~EMPTY) ? cnt_byte + 1'd1 : cnt_byte;

    always_ff @ (posedge CLK) begin
        if (RST) begin
            cnt_byte <= 2'd0;
        end else begin
            cnt_byte <= n_cnt_byte;
        end
    end
endmodule