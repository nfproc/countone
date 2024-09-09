-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity countone_countone_Pipeline_VITIS_LOOP_65_2 is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    rand_in_TDATA : IN STD_LOGIC_VECTOR (7 downto 0);
    rand_in_TVALID : IN STD_LOGIC;
    rand_in_TREADY : OUT STD_LOGIC;
    freq4_V_address0 : OUT STD_LOGIC_VECTOR (9 downto 0);
    freq4_V_ce0 : OUT STD_LOGIC;
    freq4_V_we0 : OUT STD_LOGIC;
    freq4_V_d0 : OUT STD_LOGIC_VECTOR (12 downto 0);
    freq4_V_q0 : IN STD_LOGIC_VECTOR (12 downto 0);
    freq5_V_address0 : OUT STD_LOGIC_VECTOR (11 downto 0);
    freq5_V_ce0 : OUT STD_LOGIC;
    freq5_V_we0 : OUT STD_LOGIC;
    freq5_V_d0 : OUT STD_LOGIC_VECTOR (12 downto 0);
    freq5_V_q0 : IN STD_LOGIC_VECTOR (12 downto 0) );
end;


architecture behav of countone_countone_Pipeline_VITIS_LOOP_65_2 is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (2 downto 0) := "001";
    constant ap_ST_fsm_pp0_stage1 : STD_LOGIC_VECTOR (2 downto 0) := "010";
    constant ap_ST_fsm_pp0_stage2 : STD_LOGIC_VECTOR (2 downto 0) := "100";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv18_0 : STD_LOGIC_VECTOR (17 downto 0) := "000000000000000000";
    constant ap_const_lv6_0 : STD_LOGIC_VECTOR (5 downto 0) := "000000";
    constant ap_const_lv18_3E804 : STD_LOGIC_VECTOR (17 downto 0) := "111110100000000100";
    constant ap_const_lv18_1 : STD_LOGIC_VECTOR (17 downto 0) := "000000000000000001";
    constant ap_const_lv18_4 : STD_LOGIC_VECTOR (17 downto 0) := "000000000000000100";
    constant ap_const_lv32_C : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001100";
    constant ap_const_lv13_1 : STD_LOGIC_VECTOR (12 downto 0) := "0000000000001";
    constant ap_const_lv13_1000 : STD_LOGIC_VECTOR (12 downto 0) := "1000000000000";
    constant ap_const_lv12_2 : STD_LOGIC_VECTOR (11 downto 0) := "000000000010";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (2 downto 0) := "001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_CS_fsm_pp0_stage2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage2 : signal is "none";
    signal ap_block_state3_pp0_stage2_iter0 : BOOLEAN;
    signal ap_block_state6_pp0_stage2_iter1 : BOOLEAN;
    signal ap_block_pp0_stage2_subdone : BOOLEAN;
    signal icmp_ln1057_reg_395 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_condition_exit_pp0_iter0_stage2 : STD_LOGIC;
    signal ap_loop_exit_ready : STD_LOGIC;
    signal ap_ready_int : STD_LOGIC;
    signal char2letter_V_address0 : STD_LOGIC_VECTOR (7 downto 0);
    signal char2letter_V_ce0 : STD_LOGIC;
    signal char2letter_V_q0 : STD_LOGIC_VECTOR (2 downto 0);
    signal rand_in_TDATA_blk_n : STD_LOGIC;
    signal ap_CS_fsm_pp0_stage1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage1 : signal is "none";
    signal ap_block_pp0_stage1 : BOOLEAN;
    signal icmp_ln1057_fu_142_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state4_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal index4_V_load_reg_399 : STD_LOGIC_VECTOR (11 downto 0);
    signal icmp_ln1061_fu_157_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln1061_reg_405 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln1061_reg_405_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal freq4_V_addr_reg_409 : STD_LOGIC_VECTOR (9 downto 0);
    signal ap_block_state2_pp0_stage1_iter0 : BOOLEAN;
    signal ap_block_state5_pp0_stage1_iter1 : BOOLEAN;
    signal ap_block_pp0_stage1_11001 : BOOLEAN;
    signal select_ln76_fu_192_p3 : STD_LOGIC_VECTOR (12 downto 0);
    signal select_ln76_reg_419 : STD_LOGIC_VECTOR (12 downto 0);
    signal index5_V_fu_235_p2 : STD_LOGIC_VECTOR (11 downto 0);
    signal index5_V_reg_424 : STD_LOGIC_VECTOR (11 downto 0);
    signal ap_block_pp0_stage2_11001 : BOOLEAN;
    signal freq5_V_addr_reg_429 : STD_LOGIC_VECTOR (11 downto 0);
    signal select_ln78_fu_355_p3 : STD_LOGIC_VECTOR (12 downto 0);
    signal select_ln78_reg_434 : STD_LOGIC_VECTOR (12 downto 0);
    signal ap_enable_reg_pp0_iter0_reg : STD_LOGIC := '0';
    signal zext_ln573_1_fu_163_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal zext_ln68_fu_173_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln573_2_fu_337_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal i_V_2_fu_64 : STD_LOGIC_VECTOR (17 downto 0);
    signal ap_loop_init : STD_LOGIC;
    signal ap_sig_allocacmp_i_V : STD_LOGIC_VECTOR (17 downto 0);
    signal i_V_3_fu_148_p2 : STD_LOGIC_VECTOR (17 downto 0);
    signal index4_V_fu_68 : STD_LOGIC_VECTOR (11 downto 0);
    signal index_buf_fu_241_p2 : STD_LOGIC_VECTOR (11 downto 0);
    signal phi_ln1525_2_fu_72 : STD_LOGIC_VECTOR (11 downto 0);
    signal phitmp_fu_279_p2 : STD_LOGIC_VECTOR (11 downto 0);
    signal ap_block_pp0_stage2 : BOOLEAN;
    signal phi_ln1525_1_fu_76 : STD_LOGIC_VECTOR (7 downto 0);
    signal phitmp15_fu_293_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal phi_ln1525_fu_80 : STD_LOGIC_VECTOR (5 downto 0);
    signal phitmp16_fu_311_p2 : STD_LOGIC_VECTOR (5 downto 0);
    signal tmp_fu_178_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal add_ln223_fu_186_p2 : STD_LOGIC_VECTOR (12 downto 0);
    signal zext_ln1525_fu_218_p1 : STD_LOGIC_VECTOR (11 downto 0);
    signal add_ln223_5_fu_230_p2 : STD_LOGIC_VECTOR (11 downto 0);
    signal shl_ln1525_fu_213_p2 : STD_LOGIC_VECTOR (11 downto 0);
    signal zext_ln1057_fu_209_p1 : STD_LOGIC_VECTOR (8 downto 0);
    signal zext_ln223_1_fu_226_p1 : STD_LOGIC_VECTOR (8 downto 0);
    signal index_buf_1_fu_247_p2 : STD_LOGIC_VECTOR (8 downto 0);
    signal zext_ln223_fu_222_p1 : STD_LOGIC_VECTOR (5 downto 0);
    signal index_buf_2_fu_257_p2 : STD_LOGIC_VECTOR (5 downto 0);
    signal p_shl3_fu_267_p3 : STD_LOGIC_VECTOR (10 downto 0);
    signal p_shl3_cast_fu_275_p1 : STD_LOGIC_VECTOR (11 downto 0);
    signal zext_ln48_fu_253_p1 : STD_LOGIC_VECTOR (11 downto 0);
    signal p_shl2_fu_285_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal zext_ln48_1_fu_263_p1 : STD_LOGIC_VECTOR (7 downto 0);
    signal p_shl1_fu_299_p3 : STD_LOGIC_VECTOR (4 downto 0);
    signal p_shl1_cast_fu_307_p1 : STD_LOGIC_VECTOR (5 downto 0);
    signal tmp_4_fu_341_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal add_ln223_1_fu_349_p2 : STD_LOGIC_VECTOR (12 downto 0);
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_continue_int : STD_LOGIC;
    signal ap_done_int : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (2 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_idle_pp0_1to1 : STD_LOGIC;
    signal ap_block_pp0_stage1_subdone : BOOLEAN;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_start_int : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component countone_countone_Pipeline_VITIS_LOOP_65_2_char2letter_V IS
    generic (
        DataWidth : INTEGER;
        AddressRange : INTEGER;
        AddressWidth : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR (7 downto 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR (2 downto 0) );
    end component;


    component countone_flow_control_loop_pipe_sequential_init IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_start_int : OUT STD_LOGIC;
        ap_loop_init : OUT STD_LOGIC;
        ap_ready_int : IN STD_LOGIC;
        ap_loop_exit_ready : IN STD_LOGIC;
        ap_loop_exit_done : IN STD_LOGIC;
        ap_continue_int : OUT STD_LOGIC;
        ap_done_int : IN STD_LOGIC );
    end component;



begin
    char2letter_V_U : component countone_countone_Pipeline_VITIS_LOOP_65_2_char2letter_V
    generic map (
        DataWidth => 3,
        AddressRange => 256,
        AddressWidth => 8)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        address0 => char2letter_V_address0,
        ce0 => char2letter_V_ce0,
        q0 => char2letter_V_q0);

    flow_control_loop_pipe_sequential_init_U : component countone_flow_control_loop_pipe_sequential_init
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => ap_start,
        ap_ready => ap_ready,
        ap_done => ap_done,
        ap_start_int => ap_start_int,
        ap_loop_init => ap_loop_init,
        ap_ready_int => ap_ready_int,
        ap_loop_exit_ready => ap_condition_exit_pp0_iter0_stage2,
        ap_loop_exit_done => ap_done_int,
        ap_continue_int => ap_continue_int,
        ap_done_int => ap_done_int);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_done_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_done_reg <= ap_const_logic_0;
            else
                if ((ap_continue_int = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif (((ap_loop_exit_ready = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage2_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter0_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter0_reg <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) then 
                    ap_enable_reg_pp0_iter0_reg <= ap_start_int;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_condition_exit_pp0_iter0_stage2)) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage2_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2))) then 
                    ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
                end if; 
            end if;
        end if;
    end process;


    i_V_2_fu_64_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                if (((icmp_ln1057_fu_142_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1))) then 
                    i_V_2_fu_64 <= i_V_3_fu_148_p2;
                elsif ((ap_loop_init = ap_const_logic_1)) then 
                    i_V_2_fu_64 <= ap_const_lv18_0;
                end if;
            end if; 
        end if;
    end process;

    phi_ln1525_fu_80_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1))) then 
                phi_ln1525_fu_80 <= ap_const_lv6_0;
            elsif (((icmp_ln1057_reg_395 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage2_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2))) then 
                phi_ln1525_fu_80 <= phitmp16_fu_311_p2;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln1057_fu_142_p2 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (icmp_ln1061_fu_157_p2 = ap_const_lv1_1))) then
                freq4_V_addr_reg_409 <= zext_ln573_1_fu_163_p1(10 - 1 downto 0);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (icmp_ln1061_reg_405 = ap_const_lv1_1))) then
                freq5_V_addr_reg_429 <= zext_ln573_2_fu_337_p1(12 - 1 downto 0);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                icmp_ln1057_reg_395 <= icmp_ln1057_fu_142_p2;
                icmp_ln1061_reg_405_pp0_iter1_reg <= icmp_ln1061_reg_405;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln1057_fu_142_p2 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                icmp_ln1061_reg_405 <= icmp_ln1061_fu_157_p2;
                index4_V_load_reg_399 <= index4_V_fu_68;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln1057_reg_395 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage2_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2))) then
                index4_V_fu_68 <= index_buf_fu_241_p2;
                phi_ln1525_1_fu_76 <= phitmp15_fu_293_p2;
                phi_ln1525_2_fu_72 <= phitmp_fu_279_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln1057_reg_395 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage2_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2))) then
                index5_V_reg_424 <= index5_V_fu_235_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln1057_reg_395 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (icmp_ln1061_reg_405 = ap_const_lv1_1))) then
                select_ln76_reg_419 <= select_ln76_fu_192_p3;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1) and (icmp_ln1061_reg_405_pp0_iter1_reg = ap_const_lv1_1))) then
                select_ln78_reg_434 <= select_ln78_fu_355_p3;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_block_pp0_stage2_subdone, ap_block_pp0_stage0_subdone, ap_idle_pp0_1to1, ap_block_pp0_stage1_subdone, ap_start_int)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_pp0_stage0 => 
                if ((not(((ap_start_int = ap_const_logic_0) and (ap_idle_pp0_1to1 = ap_const_logic_1))) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_pp0_stage1 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage1_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage2;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                end if;
            when ap_ST_fsm_pp0_stage2 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage2_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage2;
                end if;
            when others =>  
                ap_NS_fsm <= "XXX";
        end case;
    end process;
    add_ln223_1_fu_349_p2 <= std_logic_vector(unsigned(freq5_V_q0) + unsigned(ap_const_lv13_1));
    add_ln223_5_fu_230_p2 <= std_logic_vector(unsigned(zext_ln1525_fu_218_p1) + unsigned(index4_V_load_reg_399));
    add_ln223_fu_186_p2 <= std_logic_vector(unsigned(freq4_V_q0) + unsigned(ap_const_lv13_1));
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
    ap_CS_fsm_pp0_stage1 <= ap_CS_fsm(1);
    ap_CS_fsm_pp0_stage2 <= ap_CS_fsm(2);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage1 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage1_11001_assign_proc : process(ap_enable_reg_pp0_iter0, icmp_ln1057_reg_395, rand_in_TVALID)
    begin
                ap_block_pp0_stage1_11001 <= ((rand_in_TVALID = ap_const_logic_0) and (icmp_ln1057_reg_395 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1));
    end process;


    ap_block_pp0_stage1_subdone_assign_proc : process(ap_enable_reg_pp0_iter0, icmp_ln1057_reg_395, rand_in_TVALID)
    begin
                ap_block_pp0_stage1_subdone <= ((rand_in_TVALID = ap_const_logic_0) and (icmp_ln1057_reg_395 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1));
    end process;

        ap_block_pp0_stage2 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage2_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage2_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state1_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state2_pp0_stage1_iter0_assign_proc : process(icmp_ln1057_reg_395, rand_in_TVALID)
    begin
                ap_block_state2_pp0_stage1_iter0 <= ((rand_in_TVALID = ap_const_logic_0) and (icmp_ln1057_reg_395 = ap_const_lv1_0));
    end process;

        ap_block_state3_pp0_stage2_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state4_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state5_pp0_stage1_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state6_pp0_stage2_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_condition_exit_pp0_iter0_stage2_assign_proc : process(ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage2, ap_block_pp0_stage2_subdone, icmp_ln1057_reg_395)
    begin
        if (((icmp_ln1057_reg_395 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage2_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2))) then 
            ap_condition_exit_pp0_iter0_stage2 <= ap_const_logic_1;
        else 
            ap_condition_exit_pp0_iter0_stage2 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_int_assign_proc : process(ap_CS_fsm_pp0_stage2, ap_block_pp0_stage2_subdone, ap_loop_exit_ready, ap_done_reg)
    begin
        if (((ap_loop_exit_ready = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage2_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2))) then 
            ap_done_int <= ap_const_logic_1;
        else 
            ap_done_int <= ap_done_reg;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);

    ap_enable_reg_pp0_iter0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0_reg, ap_start_int)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) then 
            ap_enable_reg_pp0_iter0 <= ap_start_int;
        else 
            ap_enable_reg_pp0_iter0 <= ap_enable_reg_pp0_iter0_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_idle_pp0, ap_start_int)
    begin
        if (((ap_start_int = ap_const_logic_0) and (ap_idle_pp0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_1to1_assign_proc : process(ap_enable_reg_pp0_iter1)
    begin
        if ((ap_enable_reg_pp0_iter1 = ap_const_logic_0)) then 
            ap_idle_pp0_1to1 <= ap_const_logic_1;
        else 
            ap_idle_pp0_1to1 <= ap_const_logic_0;
        end if; 
    end process;

    ap_loop_exit_ready <= ap_condition_exit_pp0_iter0_stage2;

    ap_ready_int_assign_proc : process(ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage2, ap_block_pp0_stage2_subdone)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage2_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2))) then 
            ap_ready_int <= ap_const_logic_1;
        else 
            ap_ready_int <= ap_const_logic_0;
        end if; 
    end process;


    ap_sig_allocacmp_i_V_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, i_V_2_fu_64, ap_loop_init)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1))) then 
            ap_sig_allocacmp_i_V <= ap_const_lv18_0;
        else 
            ap_sig_allocacmp_i_V <= i_V_2_fu_64;
        end if; 
    end process;

    char2letter_V_address0 <= zext_ln68_fu_173_p1(8 - 1 downto 0);

    char2letter_V_ce0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage1, ap_block_pp0_stage1_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
            char2letter_V_ce0 <= ap_const_logic_1;
        else 
            char2letter_V_ce0 <= ap_const_logic_0;
        end if; 
    end process;


    freq4_V_address0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage2, freq4_V_addr_reg_409, zext_ln573_1_fu_163_p1, ap_block_pp0_stage0, ap_block_pp0_stage2)
    begin
        if ((ap_enable_reg_pp0_iter0 = ap_const_logic_1)) then
            if (((ap_const_boolean_0 = ap_block_pp0_stage2) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2))) then 
                freq4_V_address0 <= freq4_V_addr_reg_409;
            elsif (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                freq4_V_address0 <= zext_ln573_1_fu_163_p1(10 - 1 downto 0);
            else 
                freq4_V_address0 <= "XXXXXXXXXX";
            end if;
        else 
            freq4_V_address0 <= "XXXXXXXXXX";
        end if; 
    end process;


    freq4_V_ce0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage2, ap_block_pp0_stage0_11001, ap_block_pp0_stage2_11001)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((ap_const_boolean_0 = ap_block_pp0_stage2_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2)))) then 
            freq4_V_ce0 <= ap_const_logic_1;
        else 
            freq4_V_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    freq4_V_d0 <= select_ln76_reg_419;

    freq4_V_we0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage2, icmp_ln1057_reg_395, icmp_ln1061_reg_405, ap_block_pp0_stage2_11001)
    begin
        if (((icmp_ln1057_reg_395 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage2_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2) and (icmp_ln1061_reg_405 = ap_const_lv1_1))) then 
            freq4_V_we0 <= ap_const_logic_1;
        else 
            freq4_V_we0 <= ap_const_logic_0;
        end if; 
    end process;


    freq5_V_address0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_CS_fsm_pp0_stage2, freq5_V_addr_reg_429, ap_block_pp0_stage0, zext_ln573_2_fu_337_p1, ap_block_pp0_stage2)
    begin
        if ((ap_enable_reg_pp0_iter1 = ap_const_logic_1)) then
            if (((ap_const_boolean_0 = ap_block_pp0_stage2) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2))) then 
                freq5_V_address0 <= freq5_V_addr_reg_429;
            elsif (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                freq5_V_address0 <= zext_ln573_2_fu_337_p1(12 - 1 downto 0);
            else 
                freq5_V_address0 <= "XXXXXXXXXXXX";
            end if;
        else 
            freq5_V_address0 <= "XXXXXXXXXXXX";
        end if; 
    end process;


    freq5_V_ce0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_CS_fsm_pp0_stage2, ap_block_pp0_stage0_11001, ap_block_pp0_stage2_11001)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((ap_const_boolean_0 = ap_block_pp0_stage2_11001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2)))) then 
            freq5_V_ce0 <= ap_const_logic_1;
        else 
            freq5_V_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    freq5_V_d0 <= select_ln78_reg_434;

    freq5_V_we0_assign_proc : process(ap_enable_reg_pp0_iter1, ap_CS_fsm_pp0_stage2, icmp_ln1061_reg_405_pp0_iter1_reg, ap_block_pp0_stage2_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage2_11001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage2) and (icmp_ln1061_reg_405_pp0_iter1_reg = ap_const_lv1_1))) then 
            freq5_V_we0 <= ap_const_logic_1;
        else 
            freq5_V_we0 <= ap_const_logic_0;
        end if; 
    end process;

    i_V_3_fu_148_p2 <= std_logic_vector(unsigned(ap_sig_allocacmp_i_V) + unsigned(ap_const_lv18_1));
    icmp_ln1057_fu_142_p2 <= "1" when (ap_sig_allocacmp_i_V = ap_const_lv18_3E804) else "0";
    icmp_ln1061_fu_157_p2 <= "1" when (unsigned(ap_sig_allocacmp_i_V) > unsigned(ap_const_lv18_4)) else "0";
    index5_V_fu_235_p2 <= std_logic_vector(unsigned(add_ln223_5_fu_230_p2) + unsigned(shl_ln1525_fu_213_p2));
    index_buf_1_fu_247_p2 <= std_logic_vector(unsigned(zext_ln1057_fu_209_p1) + unsigned(zext_ln223_1_fu_226_p1));
    index_buf_2_fu_257_p2 <= std_logic_vector(unsigned(phi_ln1525_fu_80) + unsigned(zext_ln223_fu_222_p1));
    index_buf_fu_241_p2 <= std_logic_vector(unsigned(phi_ln1525_2_fu_72) + unsigned(zext_ln1525_fu_218_p1));
    p_shl1_cast_fu_307_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(p_shl1_fu_299_p3),6));
    p_shl1_fu_299_p3 <= (char2letter_V_q0 & ap_const_lv2_0);
    p_shl2_fu_285_p3 <= (index_buf_2_fu_257_p2 & ap_const_lv2_0);
    p_shl3_cast_fu_275_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(p_shl3_fu_267_p3),12));
    p_shl3_fu_267_p3 <= (index_buf_1_fu_247_p2 & ap_const_lv2_0);
    phitmp15_fu_293_p2 <= std_logic_vector(unsigned(p_shl2_fu_285_p3) + unsigned(zext_ln48_1_fu_263_p1));
    phitmp16_fu_311_p2 <= std_logic_vector(unsigned(p_shl1_cast_fu_307_p1) + unsigned(zext_ln223_fu_222_p1));
    phitmp_fu_279_p2 <= std_logic_vector(unsigned(p_shl3_cast_fu_275_p1) + unsigned(zext_ln48_fu_253_p1));

    rand_in_TDATA_blk_n_assign_proc : process(ap_enable_reg_pp0_iter0, icmp_ln1057_reg_395, rand_in_TVALID, ap_CS_fsm_pp0_stage1, ap_block_pp0_stage1)
    begin
        if (((icmp_ln1057_reg_395 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
            rand_in_TDATA_blk_n <= rand_in_TVALID;
        else 
            rand_in_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    rand_in_TREADY_assign_proc : process(ap_enable_reg_pp0_iter0, icmp_ln1057_reg_395, ap_CS_fsm_pp0_stage1, ap_block_pp0_stage1_11001)
    begin
        if (((icmp_ln1057_reg_395 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
            rand_in_TREADY <= ap_const_logic_1;
        else 
            rand_in_TREADY <= ap_const_logic_0;
        end if; 
    end process;

    select_ln76_fu_192_p3 <= 
        ap_const_lv13_1000 when (tmp_fu_178_p3(0) = '1') else 
        add_ln223_fu_186_p2;
    select_ln78_fu_355_p3 <= 
        ap_const_lv13_1000 when (tmp_4_fu_341_p3(0) = '1') else 
        add_ln223_1_fu_349_p2;
    shl_ln1525_fu_213_p2 <= std_logic_vector(shift_left(unsigned(index4_V_load_reg_399),to_integer(unsigned('0' & ap_const_lv12_2(12-1 downto 0)))));
    tmp_4_fu_341_p3 <= freq5_V_q0(12 downto 12);
    tmp_fu_178_p3 <= freq4_V_q0(12 downto 12);
    zext_ln1057_fu_209_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(phi_ln1525_1_fu_76),9));
    zext_ln1525_fu_218_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(char2letter_V_q0),12));
    zext_ln223_1_fu_226_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(char2letter_V_q0),9));
    zext_ln223_fu_222_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(char2letter_V_q0),6));
    zext_ln48_1_fu_263_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(index_buf_2_fu_257_p2),8));
    zext_ln48_fu_253_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(index_buf_1_fu_247_p2),12));
    zext_ln573_1_fu_163_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(index4_V_fu_68),64));
    zext_ln573_2_fu_337_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(index5_V_reg_424),64));
    zext_ln68_fu_173_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(rand_in_TDATA),64));
end behav;