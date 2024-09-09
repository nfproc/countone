// Latch-Latch TRNG Unit 2022.10.05 Naoki F., AIT
// (derived from base IP in 2021.03 and ELEX version in 2018.03)
// ライセンス条件は COPYING ファイルを参照してください

module RNG_LATCH (
    input  logic         CLK, RST_X,
    input  logic         RNG_EN,
    output logic [31: 0] DATA_OUT,
    output logic         DATA_EN);

    localparam T_DEASSERT = 8'd4;
    localparam T_ASSERT   = 8'd4;
    parameter  NUM_LATCH  = 32;

    logic [31: 0] data_reg, n_data_reg;
    logic         n_data_en;
    logic [ 4: 0] cnt_bit, n_cnt_bit;
    logic [ 7: 0] cnt_osc, n_cnt_osc;
    logic         asrt_x, n_asrt_x;
    (* DONT_TOUCH = "true" *)
    logic [NUM_LATCH-1:0] out;
    logic         out_xor, en_xor;
    logic         d_out_xor, d_en_xor;
    genvar        i;

    always_comb begin
        if (cnt_osc == 8'd1) begin
            if (RNG_EN) begin
                n_cnt_osc = 8'd2;
            end else begin
                n_cnt_osc = 8'd1;
            end
        end else if (cnt_osc < T_DEASSERT + T_ASSERT - 8'd1) begin
            n_cnt_osc = cnt_osc + 1'b1;
        end else begin
            n_cnt_osc = 8'd0;
        end
    end
    assign n_asrt_x   = (n_cnt_osc < T_DEASSERT);
    assign out_xor    = ^out;
    assign en_xor     = (cnt_osc == 8'd0);

    assign DATA_OUT   = n_data_reg;
    assign n_data_reg = (~d_en_xor) ? data_reg : {data_reg[30:0], data_reg[31] ^ d_out_xor};
    assign DATA_EN    = (~d_en_xor) ? 1'b0     : (cnt_bit == 5'd0);
    assign n_cnt_bit  = (~en_xor)   ? cnt_bit  : cnt_bit + 1'd1;

    generate for (i = 0; i < NUM_LATCH; i = i + 1) begin
        rng1 rng_inst (CLK, ~RST_X, asrt_x, out[i]);
    end endgenerate

    always_ff @ (posedge CLK) begin
        if (~ RST_X) begin
            data_reg  <= 32'h0;
            cnt_bit   <= 5'd0;
            cnt_osc   <= 8'd1;
            asrt_x    <= 1'b1;
            d_out_xor <= 1'b0;
            d_en_xor  <= 1'b0;
        end else begin
            data_reg  <= n_data_reg;
            cnt_bit   <= n_cnt_bit;
            cnt_osc   <= n_cnt_osc;
            asrt_x    <= n_asrt_x;
            d_out_xor <= out_xor;
            d_en_xor  <= en_xor;
        end
    end

endmodule

module rng1 (CLK, RST, ASRT_X, OUT);
    input  logic CLK, RST, ASRT_X;
    output logic OUT;

    (* ALLOW_COMBINATORIAL_LOOPS = "true", DONT_TOUCH = "true" *)
    logic [1:0] nand_o, not_o;

    (* HU_SET = "rng", RLOC = "X0Y0" *)
    LUT1 #(.INIT(2'b01)) NOT_S0 (.O(not_o[0]), .I0(nand_o[1]));
    (* HU_SET = "rng", RLOC = "X0Y0" *)
    LUT1 #(.INIT(2'b01)) NOT_R0 (.O(not_o[1]), .I0(nand_o[0]));
    (* HU_SET = "rng", RLOC = "X0Y0" *)
    LDCE AND_S0 (.D(not_o[0]), .Q(nand_o[0]), .CLR(ASRT_X), .GE(1'b1), .G(1'b1));
    (* HU_SET = "rng", RLOC = "X0Y0" *)
    LDCE AND_R0 (.D(not_o[1]), .Q(nand_o[1]), .CLR(ASRT_X), .GE(1'b1), .G(1'b1));

    FDCE OUTFF_S0 (.Q(OUT)  , .C(CLK), .CE(1'b1), .CLR(RST), .D(nand_o[0]));
    
endmodule