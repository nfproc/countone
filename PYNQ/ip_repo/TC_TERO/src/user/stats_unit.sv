// Blank Statistics Unit for TRNG IP Core for TC-TERO 2021.06.15 Naoki F., AIT
// ライセンス条件は COPYING ファイルを参照してください

module STATS_UNIT (
    input  logic         CLK, RST_X,
    input  logic         GO,
    input  logic         STOP,
    input  logic [15: 0] DATA_IN,
    input  logic         DATA_RE,
    input  logic [ 7: 0] STAT_ADDR,
    output logic [31: 0] STATS);

    ////// RAM block for occurrence frequency
    logic [255:0] ram_valid_array;
    logic         ram_valid_r, ram_valid_s;
    logic  [31:0] ram_data_array[0:255];
    logic   [7:0] ram_addr_r, ram_addr_w, d_ram_addr_w, ram_addr_s;
    logic  [31:0] ram_data_r, ram_data_w, d_ram_data_w, ram_data_s;
    logic         ram_we, d_ram_we;

    // ram_valid_array
    always_ff @ (posedge CLK) begin
        if (~ RST_X) begin
            ram_valid_array <= {256{1'b0}};
            ram_valid_r     <= 1'b0;
            ram_valid_s     <= 1'b0;
        end else begin
            if (GO) begin
                ram_valid_array <= {256{1'b0}};
            end else if (ram_we) begin
                ram_valid_array[ram_addr_w] <= 1'b1;
            end
            ram_valid_r     <= ram_valid_array[ram_addr_r];
            ram_valid_s     <= ram_valid_array[ram_addr_s];
        end
    end
    
    // ram_data_array
    always_ff @ (posedge CLK) begin
        ram_data_r <= ram_data_array[ram_addr_r];
        ram_data_s <= ram_data_array[ram_addr_s];
        if (ram_we) begin
            ram_data_array[ram_addr_w] <= ram_data_w;
        end
    end

    // other RAM signals
    assign ram_addr_r = DATA_IN[7:0];
    assign ram_addr_s = STAT_ADDR;
    assign ram_data_w = (((ram_valid_r) ? ram_data_r : 0) +
                         ((ram_addr_w == d_ram_addr_w && d_ram_we) ? 2'd2 : 1'b1));

    always_ff @ (posedge CLK) begin
        if (~ RST_X) begin
            ram_addr_w   <= 8'h00;
            d_ram_addr_w <= 8'h00;
            d_ram_data_w <= 0;
            ram_we       <= 1'b0;
            d_ram_we     <= 1'b0;
        end else begin
            ram_addr_w   <= ram_addr_r;
            d_ram_addr_w <= ram_addr_w;
            d_ram_data_w <= ram_data_w;
            ram_we       <= DATA_RE;
            d_ram_we     <= ram_we;
        end
    end

    ////// Counter for number of runs
    logic  [31:0] runs_count;
    logic         last_lsb;

    always_ff @ (posedge CLK) begin
        if (~ RST_X) begin
            runs_count <= 0;
            last_lsb   <= 1'b0;
        end else if (GO) begin
            runs_count <= 0;
            last_lsb   <= 1'b0;
        end else if (DATA_RE && last_lsb != DATA_IN[0]) begin
            runs_count <= runs_count + 1'b1;
            last_lsb   <= DATA_IN[0];
        end
    end

    ////// statistics output
    assign STATS = ((STAT_ADDR == 8'h00) ? runs_count :
                    (ram_valid_s) ? ram_data_s : 0);
    
endmodule