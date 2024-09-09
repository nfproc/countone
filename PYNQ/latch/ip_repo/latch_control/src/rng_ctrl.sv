// TRNG Core Controller for 32-bit data input sequence 2022.10.05 Naoki F., AIT
// Derived from Controller of TRNG IP Core 2021.03.05 Naoki F., AIT
// ライセンス条件は COPYING ファイルを参照してください

module RNG_CTRL (
    input  logic         CLK, RST_X,
    // from RNG_UNIT
    input  logic [31: 0] DATA_IN,
    input  logic         DATA_RE,
    // to FIFO
    output logic [32: 0] DATA_OUT,
    output logic         DATA_WE,
    input  logic         FIFO_FULL,
    // from AXI_ctrl
    input  logic         GO,
    input  logic         STOP,
    output logic         RUN,
    output logic         OVER,
    input  logic [31: 0] SEND_BYTES,
    output logic [31: 0] SENT_BYTES,
    input  logic [31: 0] DMA_BYTES);

    logic [31: 0] sent_dma, n_sent_dma;
    logic         n_run, n_over;
    logic [31: 0] n_sent;
    logic         dma_last;

    assign DATA_OUT = {dma_last, DATA_IN};
    assign DATA_WE  = RUN && DATA_RE && ~FIFO_FULL;

    // control logic
    always_comb begin
        n_run      = RUN;
        n_over     = OVER;
        n_sent     = SENT_BYTES;
        n_sent_dma = sent_dma;
        dma_last   = 1'b0;

        if (STOP) begin
            n_run      = 1'b0;
            n_over     = 1'b0;
            n_sent     = 0;
            n_sent_dma = 0;
        end else if (GO) begin
            n_run      = 1'b1;
        end else if (RUN & DATA_RE) begin
            if (FIFO_FULL) begin 
                n_over     = 1'b1;
            end else begin
                n_sent     = SENT_BYTES + 3'd4;
                n_sent_dma = sent_dma + 3'd4;
                n_run      = (n_sent < SEND_BYTES || SEND_BYTES == 0);
                if (sent_dma + 3'd4 >= DMA_BYTES) begin
                    n_sent_dma = 0;
                    dma_last   = 1'b1;
                end
            end
        end
    end 
    
    always_ff @ (posedge CLK) begin
        if (~ RST_X) begin
            RUN        <= 1'b0;
            OVER       <= 1'b0;
            SENT_BYTES <= 0;
            sent_dma   <= 0;
        end else begin
            RUN        <= n_run;
            OVER       <= n_over;
            SENT_BYTES <= n_sent;
            sent_dma   <= n_sent_dma;
        end
    end
endmodule