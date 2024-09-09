// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="countone_countone,hls_ip_2021_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7z020-clg400-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=6.654000,HLS_SYN_LAT=774910,HLS_SYN_TPT=none,HLS_SYN_MEM=8,HLS_SYN_DSP=0,HLS_SYN_FF=582,HLS_SYN_LUT=1483,HLS_VERSION=2021_1}" *)

module countone (
// synthesis translate_off
    kernel_block,
// synthesis translate_on
        ap_clk,
        ap_rst_n,
        rand_in_TDATA,
        rand_in_TVALID,
        rand_in_TREADY,
        rslt_out_TDATA,
        rslt_out_TVALID,
        rslt_out_TREADY,
        freq_out_TDATA,
        freq_out_TVALID,
        freq_out_TREADY
);

parameter    ap_ST_fsm_state1 = 8'd1;
parameter    ap_ST_fsm_state2 = 8'd2;
parameter    ap_ST_fsm_state3 = 8'd4;
parameter    ap_ST_fsm_state4 = 8'd8;
parameter    ap_ST_fsm_state5 = 8'd16;
parameter    ap_ST_fsm_state6 = 8'd32;
parameter    ap_ST_fsm_state7 = 8'd64;
parameter    ap_ST_fsm_state8 = 8'd128;

// synthesis translate_off
output kernel_block;
// synthesis translate_on
input   ap_clk;
input   ap_rst_n;
input  [7:0] rand_in_TDATA;
input   rand_in_TVALID;
output   rand_in_TREADY;
output  [31:0] rslt_out_TDATA;
output   rslt_out_TVALID;
input   rslt_out_TREADY;
output  [15:0] freq_out_TDATA;
output   freq_out_TVALID;
input   freq_out_TREADY;

 reg    ap_rst_n_inv;
reg    rslt_out_TDATA_blk_n;
(* fsm_encoding = "none" *) reg   [7:0] ap_CS_fsm;
wire    ap_CS_fsm_state7;
wire    ap_CS_fsm_state8;
reg   [9:0] freq4_V_address0;
reg    freq4_V_ce0;
reg    freq4_V_we0;
reg   [12:0] freq4_V_d0;
wire   [12:0] freq4_V_q0;
reg   [11:0] freq5_V_address0;
reg    freq5_V_ce0;
reg    freq5_V_we0;
reg   [12:0] freq5_V_d0;
wire   [12:0] freq5_V_q0;
wire    grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_start;
wire    grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_done;
wire    grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_idle;
wire    grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_ready;
wire   [11:0] grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq5_V_address0;
wire    grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq5_V_ce0;
wire    grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq5_V_we0;
wire   [12:0] grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq5_V_d0;
wire   [9:0] grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq4_V_address0;
wire    grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq4_V_ce0;
wire    grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq4_V_we0;
wire   [12:0] grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq4_V_d0;
wire    grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_start;
wire    grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_done;
wire    grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_idle;
wire    grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_ready;
wire    grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq_out_TREADY;
wire    grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_rand_in_TREADY;
wire   [15:0] grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq_out_TDATA;
wire    grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq_out_TVALID;
wire   [9:0] grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq4_V_address0;
wire    grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq4_V_ce0;
wire    grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq4_V_we0;
wire   [12:0] grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq4_V_d0;
wire   [11:0] grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq5_V_address0;
wire    grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq5_V_ce0;
wire    grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq5_V_we0;
wire   [12:0] grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq5_V_d0;
wire    grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_start;
wire    grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_done;
wire    grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_idle;
wire    grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_ready;
wire   [11:0] grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_freq5_V_address0;
wire    grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_freq5_V_ce0;
wire   [9:0] grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_freq4_V_address0;
wire    grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_freq4_V_ce0;
wire   [33:0] grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_chsq_V_out;
wire    grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_chsq_V_out_ap_vld;
reg    grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_start_reg;
wire    ap_CS_fsm_state1;
wire    ap_CS_fsm_state2;
reg    grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_start_reg;
wire    ap_CS_fsm_state3;
wire    ap_CS_fsm_state4;
reg    grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_start_reg;
reg   [7:0] ap_NS_fsm;
wire    ap_NS_fsm_state5;
wire    ap_CS_fsm_state6;
wire   [0:0] tmp_fu_111_p3;
wire   [31:0] ret_fu_119_p4;
wire    ap_ST_fsm_state1_blk;
reg    ap_ST_fsm_state2_blk;
wire    ap_ST_fsm_state3_blk;
reg    ap_ST_fsm_state4_blk;
wire    ap_ST_fsm_state5_blk;
reg    ap_ST_fsm_state6_blk;
reg    ap_ST_fsm_state7_blk;
reg    ap_ST_fsm_state8_blk;
wire    regslice_both_rslt_out_U_apdone_blk;
wire    regslice_both_freq_out_U_apdone_blk;
reg    ap_block_state8;
wire    regslice_both_rand_in_U_apdone_blk;
wire   [7:0] rand_in_TDATA_int_regslice;
wire    rand_in_TVALID_int_regslice;
reg    rand_in_TREADY_int_regslice;
wire    regslice_both_rand_in_U_ack_in;
wire   [31:0] rslt_out_TDATA_int_regslice;
reg    rslt_out_TVALID_int_regslice;
wire    rslt_out_TREADY_int_regslice;
wire    regslice_both_rslt_out_U_vld_out;
wire    freq_out_TREADY_int_regslice;
wire    regslice_both_freq_out_U_vld_out;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 8'd1;
#0 grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_start_reg = 1'b0;
#0 grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_start_reg = 1'b0;
#0 grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_start_reg = 1'b0;
end

countone_freq4_V #(
    .DataWidth( 13 ),
    .AddressRange( 625 ),
    .AddressWidth( 10 ))
freq4_V_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .address0(freq4_V_address0),
    .ce0(freq4_V_ce0),
    .we0(freq4_V_we0),
    .d0(freq4_V_d0),
    .q0(freq4_V_q0)
);

countone_freq5_V #(
    .DataWidth( 13 ),
    .AddressRange( 3125 ),
    .AddressWidth( 12 ))
freq5_V_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .address0(freq5_V_address0),
    .ce0(freq5_V_ce0),
    .we0(freq5_V_we0),
    .d0(freq5_V_d0),
    .q0(freq5_V_q0)
);

countone_countone_Pipeline_VITIS_LOOP_85_1 grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_start),
    .ap_done(grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_done),
    .ap_idle(grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_idle),
    .ap_ready(grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_ready),
    .freq5_V_address0(grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq5_V_address0),
    .freq5_V_ce0(grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq5_V_ce0),
    .freq5_V_we0(grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq5_V_we0),
    .freq5_V_d0(grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq5_V_d0),
    .freq4_V_address0(grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq4_V_address0),
    .freq4_V_ce0(grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq4_V_ce0),
    .freq4_V_we0(grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq4_V_we0),
    .freq4_V_d0(grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq4_V_d0)
);

countone_countone_Pipeline_VITIS_LOOP_93_2 grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_start),
    .ap_done(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_done),
    .ap_idle(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_idle),
    .ap_ready(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_ready),
    .freq_out_TREADY(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq_out_TREADY),
    .rand_in_TDATA(rand_in_TDATA_int_regslice),
    .rand_in_TVALID(rand_in_TVALID_int_regslice),
    .rand_in_TREADY(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_rand_in_TREADY),
    .freq_out_TDATA(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq_out_TDATA),
    .freq_out_TVALID(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq_out_TVALID),
    .freq4_V_address0(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq4_V_address0),
    .freq4_V_ce0(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq4_V_ce0),
    .freq4_V_we0(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq4_V_we0),
    .freq4_V_d0(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq4_V_d0),
    .freq4_V_q0(freq4_V_q0),
    .freq5_V_address0(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq5_V_address0),
    .freq5_V_ce0(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq5_V_ce0),
    .freq5_V_we0(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq5_V_we0),
    .freq5_V_d0(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq5_V_d0),
    .freq5_V_q0(freq5_V_q0)
);

countone_countone_Pipeline_VITIS_LOOP_139_3 grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_start),
    .ap_done(grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_done),
    .ap_idle(grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_idle),
    .ap_ready(grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_ready),
    .freq5_V_address0(grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_freq5_V_address0),
    .freq5_V_ce0(grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_freq5_V_ce0),
    .freq5_V_q0(freq5_V_q0),
    .freq4_V_address0(grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_freq4_V_address0),
    .freq4_V_ce0(grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_freq4_V_ce0),
    .freq4_V_q0(freq4_V_q0),
    .chsq_V_out(grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_chsq_V_out),
    .chsq_V_out_ap_vld(grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_chsq_V_out_ap_vld)
);

countone_regslice_both #(
    .DataWidth( 8 ))
regslice_both_rand_in_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(rand_in_TDATA),
    .vld_in(rand_in_TVALID),
    .ack_in(regslice_both_rand_in_U_ack_in),
    .data_out(rand_in_TDATA_int_regslice),
    .vld_out(rand_in_TVALID_int_regslice),
    .ack_out(rand_in_TREADY_int_regslice),
    .apdone_blk(regslice_both_rand_in_U_apdone_blk)
);

countone_regslice_both #(
    .DataWidth( 32 ))
regslice_both_rslt_out_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(rslt_out_TDATA_int_regslice),
    .vld_in(rslt_out_TVALID_int_regslice),
    .ack_in(rslt_out_TREADY_int_regslice),
    .data_out(rslt_out_TDATA),
    .vld_out(regslice_both_rslt_out_U_vld_out),
    .ack_out(rslt_out_TREADY),
    .apdone_blk(regslice_both_rslt_out_U_apdone_blk)
);

countone_regslice_both #(
    .DataWidth( 16 ))
regslice_both_freq_out_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq_out_TDATA),
    .vld_in(grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq_out_TVALID),
    .ack_in(freq_out_TREADY_int_regslice),
    .data_out(freq_out_TDATA),
    .vld_out(regslice_both_freq_out_U_vld_out),
    .ack_out(freq_out_TREADY),
    .apdone_blk(regslice_both_freq_out_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_start_reg <= 1'b0;
    end else begin
        if (((1'b1 == ap_NS_fsm_state5) & (1'b1 == ap_CS_fsm_state4))) begin
            grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_start_reg <= 1'b1;
        end else if ((grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_ready == 1'b1)) begin
            grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state1)) begin
            grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_start_reg <= 1'b1;
        end else if ((grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_ready == 1'b1)) begin
            grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state3)) begin
            grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_start_reg <= 1'b1;
        end else if ((grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_ready == 1'b1)) begin
            grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_start_reg <= 1'b0;
        end
    end
end

assign ap_ST_fsm_state1_blk = 1'b0;

always @ (*) begin
    if ((grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_done == 1'b0)) begin
        ap_ST_fsm_state2_blk = 1'b1;
    end else begin
        ap_ST_fsm_state2_blk = 1'b0;
    end
end

assign ap_ST_fsm_state3_blk = 1'b0;

always @ (*) begin
    if ((grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_done == 1'b0)) begin
        ap_ST_fsm_state4_blk = 1'b1;
    end else begin
        ap_ST_fsm_state4_blk = 1'b0;
    end
end

assign ap_ST_fsm_state5_blk = 1'b0;

always @ (*) begin
    if ((grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_done == 1'b0)) begin
        ap_ST_fsm_state6_blk = 1'b1;
    end else begin
        ap_ST_fsm_state6_blk = 1'b0;
    end
end

always @ (*) begin
    if ((rslt_out_TREADY_int_regslice == 1'b0)) begin
        ap_ST_fsm_state7_blk = 1'b1;
    end else begin
        ap_ST_fsm_state7_blk = 1'b0;
    end
end

always @ (*) begin
    if (((rslt_out_TREADY_int_regslice == 1'b0) | (regslice_both_freq_out_U_apdone_blk == 1'b1) | (regslice_both_rslt_out_U_apdone_blk == 1'b1))) begin
        ap_ST_fsm_state8_blk = 1'b1;
    end else begin
        ap_ST_fsm_state8_blk = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state6)) begin
        freq4_V_address0 = grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_freq4_V_address0;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        freq4_V_address0 = grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq4_V_address0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        freq4_V_address0 = grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq4_V_address0;
    end else begin
        freq4_V_address0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state6)) begin
        freq4_V_ce0 = grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_freq4_V_ce0;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        freq4_V_ce0 = grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq4_V_ce0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        freq4_V_ce0 = grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq4_V_ce0;
    end else begin
        freq4_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        freq4_V_d0 = grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq4_V_d0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        freq4_V_d0 = grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq4_V_d0;
    end else begin
        freq4_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        freq4_V_we0 = grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq4_V_we0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        freq4_V_we0 = grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq4_V_we0;
    end else begin
        freq4_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state6)) begin
        freq5_V_address0 = grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_freq5_V_address0;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        freq5_V_address0 = grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq5_V_address0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        freq5_V_address0 = grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq5_V_address0;
    end else begin
        freq5_V_address0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state6)) begin
        freq5_V_ce0 = grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_freq5_V_ce0;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        freq5_V_ce0 = grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq5_V_ce0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        freq5_V_ce0 = grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq5_V_ce0;
    end else begin
        freq5_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        freq5_V_d0 = grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq5_V_d0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        freq5_V_d0 = grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq5_V_d0;
    end else begin
        freq5_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        freq5_V_we0 = grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq5_V_we0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        freq5_V_we0 = grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_freq5_V_we0;
    end else begin
        freq5_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        rand_in_TREADY_int_regslice = grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_rand_in_TREADY;
    end else begin
        rand_in_TREADY_int_regslice = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state7))) begin
        rslt_out_TDATA_blk_n = rslt_out_TREADY_int_regslice;
    end else begin
        rslt_out_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((rslt_out_TREADY_int_regslice == 1'b1) & (1'b1 == ap_CS_fsm_state7))) begin
        rslt_out_TVALID_int_regslice = 1'b1;
    end else begin
        rslt_out_TVALID_int_regslice = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            if (((grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state4;
        end
        ap_ST_fsm_state4 : begin
            if (((grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state5;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        ap_ST_fsm_state5 : begin
            ap_NS_fsm = ap_ST_fsm_state6;
        end
        ap_ST_fsm_state6 : begin
            if (((1'b1 == ap_CS_fsm_state6) & (grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_done == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state7;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state6;
            end
        end
        ap_ST_fsm_state7 : begin
            if (((rslt_out_TREADY_int_regslice == 1'b1) & (1'b1 == ap_CS_fsm_state7))) begin
                ap_NS_fsm = ap_ST_fsm_state8;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state7;
            end
        end
        ap_ST_fsm_state8 : begin
            if ((~((rslt_out_TREADY_int_regslice == 1'b0) | (regslice_both_freq_out_U_apdone_blk == 1'b1) | (regslice_both_rslt_out_U_apdone_blk == 1'b1)) & (1'b1 == ap_CS_fsm_state8))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state8;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

assign ap_CS_fsm_state6 = ap_CS_fsm[32'd5];

assign ap_CS_fsm_state7 = ap_CS_fsm[32'd6];

assign ap_CS_fsm_state8 = ap_CS_fsm[32'd7];

assign ap_NS_fsm_state5 = ap_NS_fsm[32'd4];

always @ (*) begin
    ap_block_state8 = ((rslt_out_TREADY_int_regslice == 1'b0) | (regslice_both_freq_out_U_apdone_blk == 1'b1) | (regslice_both_rslt_out_U_apdone_blk == 1'b1));
end

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign freq_out_TVALID = regslice_both_freq_out_U_vld_out;

assign grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_start = grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_ap_start_reg;

assign grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_start = grp_countone_Pipeline_VITIS_LOOP_85_1_fu_75_ap_start_reg;

assign grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_start = grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_ap_start_reg;

assign grp_countone_Pipeline_VITIS_LOOP_93_2_fu_83_freq_out_TREADY = (freq_out_TREADY_int_regslice & ap_CS_fsm_state4);

assign rand_in_TREADY = regslice_both_rand_in_U_ack_in;

assign ret_fu_119_p4 = {{grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_chsq_V_out[33:2]}};

assign rslt_out_TDATA_int_regslice = ((tmp_fu_111_p3[0:0] == 1'b1) ? 32'd4294967295 : ret_fu_119_p4);

assign rslt_out_TVALID = regslice_both_rslt_out_U_vld_out;

assign tmp_fu_111_p3 = grp_countone_Pipeline_VITIS_LOOP_139_3_fu_97_chsq_V_out[32'd33];


// synthesis translate_off
`include "countone_hls_deadlock_kernel_monitor_top.vh"
// synthesis translate_on

endmodule //countone

