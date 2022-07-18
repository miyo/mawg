`timescale 1ns/1ns

module mawg_tb_1;

    localparam CTRL_DEPTH=4;
    localparam WAVE_DEPTH=16;
    localparam WAVE_WIDTH=16;

    reg clk;
    reg reset;
    reg [CTRL_DEPTH-1:0] ctrl_addr;
    reg [WAVE_DEPTH+WAVE_DEPTH+16-1:0] ctrl_data;
    reg ctrl_we;
    reg kick;
    wire busy;
    reg [15:0] repetition;
    reg [2**CTRL_DEPTH-1:0] ctrl_length;
    wire [WAVE_DEPTH-1:0] wave_addr;
    wire [WAVE_WIDTH-1:0] wave_data;
    wire wave_valid;
    wire [WAVE_WIDTH-1:0] wave_out;

    mawg#(.CTRL_DEPTH(CTRL_DEPTH), .WAVE_DEPTH(WAVE_DEPTH), .WAVE_WIDTH(WAVE_WIDTH), .WAVE_RAM_DELAY(1))
    dut(
        .clk(clk),
        .reset(reset),
        .ctrl_addr(ctrl_addr),
        .ctrl_data(ctrl_data),
        .ctrl_we(ctrl_we),
        .kick(kick),
        .busy(busy),
        .repetition(repetition),
        .ctrl_length(ctrl_length),
        .wave_addr(wave_addr),
        .wave_data(wave_data),
        .wave_valid(wave_valid),
        .wave_out(wave_out)
        );

    wire [WAVE_WIDTH-1:0] din = 0;
    singleportram#(.WIDTH(WAVE_WIDTH), .DEPTH(WAVE_DEPTH), .WORDS(2048), .SOURCE("mawg_tb_1.txt"))
    storage(
            .clk(clk),
            .reset(reset),
            .length(),
            .address(wave_addr),
            .din(din),
            .dout(wave_data),
            .we(1'b0),
            .oe(1'b1)
            );

    reg [31:0] counter;
    integer fd;

    initial begin
        clk = 0;
        reset = 0;
        ctrl_addr = 0;
        ctrl_data = 0;
        ctrl_we = 0;
        kick = 0;
        repetition = 0;
        ctrl_length = 0;
        counter = 0;
        fd = $fopen("mawg_tb_1_out.txt");
        $dumpfile("mawg_tb_1.vcd");
        $dumpvars;
    end

    always begin
        #5 clk = ~clk;
    end

    always @(posedge clk) begin
        if(wave_valid) $fdisplay(fd, "%06d %b %04x", counter, wave_valid, wave_out);
        case(counter)
            10: begin
                reset <= 1;
                counter <= counter + 1;
            end

            20: begin
                reset <= 0;
                counter <= counter + 1;
            end

            // repetition=1,ctrl_len=1,wave_len=1,wave_repetiton=1
            100: begin
                ctrl_we <= 1;
                ctrl_data <= {16'd1,16'd1,16'd0};
                ctrl_addr <= 4'd0;
                counter <= counter + 1;
            end
            101: begin
                ctrl_we <= 0;
                counter <= counter + 1;
            end
            102: begin
                kick <= 1'b1;
                repetition <= 16'd1;
                ctrl_length <= 16'd1;
                counter <= counter + 1;
            end
            103: begin
                kick <= 1'b0;
                counter <= counter + 1;
            end
            104: begin // 000f
                if(busy == 0) counter <= counter + 1;
            end

            // repetition=1,ctrl_len=1,wave_len=1,wave_repetiton=2
            200: begin
                ctrl_we <= 1;
                ctrl_data <= {16'd2,16'd1,16'd16};
                ctrl_addr <= 4'd0;
                counter <= counter + 1;
            end
            201: begin
                ctrl_we <= 0;
                counter <= counter + 1;
            end
            202: begin
                kick <= 1'b1;
                repetition <= 16'd1;
                ctrl_length <= 16'd1;
                counter <= counter + 1;
            end
            203: begin
                kick <= 1'b0;
                counter <= counter + 1;
            end
            204: begin // 010f 010f
                if(busy == 0) counter <= counter + 1;
            end

            // repetition=1,ctrl_len=1,wave_len=2,wave_repetiton=1
            300: begin
                ctrl_we <= 1;
                ctrl_data <= {16'd1,16'd2,16'd16};
                ctrl_addr <= 4'd0;
                counter <= counter + 1;
            end
            301: begin
                ctrl_we <= 0;
                counter <= counter + 1;
            end
            302: begin
                kick <= 1'b1;
                repetition <= 16'd1;
                ctrl_length <= 16'd1;
                counter <= counter + 1;
            end
            303: begin
                kick <= 1'b0;
                counter <= counter + 1;
            end
            304: begin // 010f 011f
                if(busy == 0) counter <= counter + 1;
            end

            // repetition=1,ctrl_len=1,wave_len=2,wave_repetiton=2
            400: begin
                ctrl_we <= 1;
                ctrl_data <= {16'd2,16'd2,16'd16};
                ctrl_addr <= 4'd0;
                counter <= counter + 1;
            end
            401: begin
                ctrl_we <= 0;
                counter <= counter + 1;
            end
            402: begin
                kick <= 1'b1;
                repetition <= 16'd1;
                ctrl_length <= 16'd1;
                counter <= counter + 1;
            end
            403: begin
                kick <= 1'b0;
                counter <= counter + 1;
            end
            404: begin // 010f 011f 010f 011f
                if(busy == 0) counter <= counter + 1;
            end

            // repetition=2,ctrl_len=1,wave_len=1,wave_repetiton=1
            500: begin
                ctrl_we <= 1;
                ctrl_data <= {16'd1,16'd1,16'd16};
                ctrl_addr <= 4'd0;
                counter <= counter + 1;
            end
            501: begin
                ctrl_we <= 0;
                counter <= counter + 1;
            end
            502: begin
                kick <= 1'b1;
                repetition <= 16'd2;
                ctrl_length <= 16'd1;
                counter <= counter + 1;
            end
            503: begin
                kick <= 1'b0;
                counter <= counter + 1;
            end
            504: begin // 010f 010f
                if(busy == 0) counter <= counter + 1;
            end

            // repetition=2,ctrl_len=1,wave_len=2,wave_repetiton=2
            600: begin
                ctrl_we <= 1;
                ctrl_data <= {16'd2,16'd2,16'd16};
                ctrl_addr <= 4'd0;
                counter <= counter + 1;
            end
            601: begin
                ctrl_we <= 0;
                counter <= counter + 1;
            end
            602: begin
                kick <= 1'b1;
                repetition <= 16'd2;
                ctrl_length <= 16'd1;
                counter <= counter + 1;
            end
            603: begin
                kick <= 1'b0;
                counter <= counter + 1;
            end
            604: begin // 010f 011f 010f 011f 010f 011f 010f 011f
                if(busy == 0) counter <= counter + 1;
            end

            // repetition=2,ctrl_len=2,wave_len=2,wave_repetiton=2
            700: begin
                ctrl_we <= 1;
                ctrl_data <= {16'd2,16'd2,16'd16};
                ctrl_addr <= 4'd0;
                counter <= counter + 1;
            end
            701: begin
                ctrl_we <= 1;
                ctrl_data <= {16'd2,16'd2,16'd32};
                ctrl_addr <= 4'd1;
                counter <= counter + 1;
            end
            702: begin
                ctrl_we <= 0;
                counter <= counter + 1;
            end
            703: begin
                kick <= 1'b1;
                repetition <= 16'd2;
                ctrl_length <= 16'd2;
                counter <= counter + 1;
            end
            704: begin
                kick <= 1'b0;
                counter <= counter + 1;
            end
            705: begin
                // 010f 011f 010f 011f 020f 021f 020f 021f
                // 010f 011f 010f 011f 020f 021f 020f 021f
                if(busy == 0) counter <= counter + 1;
            end

            default: begin
                counter <= counter + 1;
            end

        endcase

        if(counter == 2000) begin
            $fflush;
            $finish;
        end
    end

endmodule // mawg_tb_1
