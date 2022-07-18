`timescale 1ns/1ns

module mawg_tb_2;

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
    reg force_stop;
    reg [15:0] repetition;
    reg [CTRL_DEPTH-1:0] ctrl_length;
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
        .force_stop(force_stop),
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
        force_stop = 0;
        repetition = 0;
        ctrl_length = 0;
        counter = 0;
        fd = $fopen("mawg_tb_2_out.txt");
        $dumpfile("mawg_tb_2.vcd");
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

            100: begin
                ctrl_we <= 1;
                ctrl_data <= {16'd1,16'd10,16'd0};
                ctrl_addr <= 4'd0;
                counter <= counter + 1;
            end
            101: begin
                ctrl_we <= 0;
                counter <= counter + 1;
            end
            102: begin
                kick <= 1'b1;
                repetition <= 16'd10;
                ctrl_length <= 1;
                counter <= counter + 1;
            end
            103: begin
                kick <= 1'b0;
                counter <= counter + 1;
            end
	    104: begin
		if(busy == 0) counter <= counter + 1;
	    end

            200: begin
                ctrl_we <= 1;
                ctrl_data <= {16'd1,16'd10,16'd0};
                ctrl_addr <= 4'd0;
                counter <= counter + 1;
            end
            201: begin
                ctrl_we <= 0;
                counter <= counter + 1;
            end
            202: begin
                kick <= 1'b1;
                repetition <= 16'd10;
                ctrl_length <= 1;
                counter <= counter + 1;
            end
            203: begin
                kick <= 1'b0;
                counter <= counter + 1;
            end
            220: begin
                force_stop <= 1;
                counter <= counter + 1;
            end
            221: begin
                force_stop <= 0;
                counter <= counter + 1;
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
