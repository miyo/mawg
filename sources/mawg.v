module mawg#(parameter CTRL_DEPTH=4,
             parameter WAVE_DEPTH=16,
             parameter WAVE_WIDTH=16,
             parameter WAVE_RAM_DELAY = 1
             )
    (
     input wire clk,
     input wire reset,
     
     input wire [CTRL_DEPTH-1:0] ctrl_addr,
     input wire [WAVE_DEPTH+WAVE_DEPTH+16-1:0] ctrl_data, // {repetition,length,offset}
     input wire ctrl_we,

     input wire kick,
     output wire busy,
     input wire force_stop,
     input wire [15:0] repetition,
     input wire [CTRL_DEPTH-1:0] ctrl_length,

     output wire [WAVE_DEPTH-1:0] wave_addr,
     input wire [WAVE_WIDTH-1:0] wave_data,

     output wire wave_valid,
     output wire [WAVE_WIDTH-1:0] wave_out
     );

    reg [CTRL_DEPTH-1:0] ctrl_raddr;
    wire [WAVE_DEPTH+WAVE_DEPTH+16-1:0] ctrl_rdata;

    regfile#(.DEPTH(CTRL_DEPTH), .WIDTH(WAVE_DEPTH+WAVE_DEPTH+16))
    regfile_i(
              .clk(clk),
              .reset(reset),
              .waddr(ctrl_addr),
              .wdata(ctrl_data),
              .we(ctrl_we),
              .raddr(ctrl_raddr),
              .rdata(ctrl_rdata)
              );

    reg [15:0] repetition_r;
    reg [CTRL_DEPTH-1:0] ctrl_length_r;
    reg [CTRL_DEPTH-1:0] ctrl_count;
    reg busy_r;
    reg wave_valid_r;

    reg [WAVE_DEPTH-1:0] wave_offset;
    reg [WAVE_DEPTH-1:0] wave_length;
    reg [16-1:0] wave_repetition;
    reg [WAVE_DEPTH-1:0] wave_addr_r;
    reg [WAVE_DEPTH-1:0] wave_count;

    assign busy = busy_r | kick;
    assign wave_addr = wave_addr_r;
    assign wave_out = wave_data;

    reg [3:0] state;
    localparam IDLE      = 0;
    localparam PREP      = 1;
    localparam RUN       = 2;

    always @(posedge clk) begin
        if(reset == 1) begin
            state <= IDLE;
            repetition_r <= 0;
            ctrl_raddr <= 0;
            ctrl_length_r <= 0;
            ctrl_count <= 0;
            busy_r <= 1;
            wave_offset <= 0;
            wave_length <= 0;
            wave_repetition <= 0;
            wave_addr_r <= 0;
            wave_count <= 0;
            wave_valid_r <= 0;
        end else begin
            case(state) 
                IDLE: begin
                    if(kick == 1 && repetition > 0 && force_stop == 0) begin
                        state <= PREP;
                        repetition_r <= repetition;
                        ctrl_length_r <= ctrl_length;
                        ctrl_count <= ctrl_length;
                        busy_r <= 1;
                    end else begin
                        busy_r <= 0;
                    end
                    ctrl_raddr <= 0;
                    wave_valid_r <= 0;
                    wave_addr_r <= 0;
                    wave_offset <= 0;
                    wave_length <= 0;
                    wave_repetition <= 0;
                    wave_addr_r <= 0;
                    wave_count <= 0;
                    wave_valid_r <= 0;
                end
                PREP: begin
                    wave_offset <= ctrl_rdata[WAVE_DEPTH-1:0];
                    wave_length <= ctrl_rdata[WAVE_DEPTH+WAVE_DEPTH-1:WAVE_DEPTH];
                    wave_repetition <= ctrl_rdata[WAVE_DEPTH+WAVE_DEPTH+16-1:WAVE_DEPTH+WAVE_DEPTH];
                    wave_addr_r <= ctrl_rdata[WAVE_DEPTH-1:0]; // wave_offset
                    wave_count <= ctrl_rdata[WAVE_DEPTH+WAVE_DEPTH-1:WAVE_DEPTH]; // wave_length
                    if(ctrl_raddr + 1 < ctrl_length) begin
                        ctrl_raddr <= ctrl_raddr + 1;
                    end else begin
                        ctrl_raddr <= 0;
                    end
                    wave_valid_r <= 1;
                    state <= RUN;
                end
                RUN: begin
		    if(force_stop == 1) begin
                        state <= IDLE;
                        wave_valid_r <= 0;
		    end else if(wave_count <= 1) begin
                        if(wave_repetition <= 1) begin
                            wave_offset <= ctrl_rdata[WAVE_DEPTH-1:0];
                            wave_length <= ctrl_rdata[WAVE_DEPTH+WAVE_DEPTH-1:WAVE_DEPTH];
                            wave_repetition <= ctrl_rdata[WAVE_DEPTH+WAVE_DEPTH+16-1:WAVE_DEPTH+WAVE_DEPTH];
                            wave_addr_r <= ctrl_rdata[WAVE_DEPTH-1:0]; // wave_offset
                            wave_count <= ctrl_rdata[WAVE_DEPTH+WAVE_DEPTH-1:WAVE_DEPTH]; // wave_length
                            if(ctrl_raddr + 1 < ctrl_length) begin
                                ctrl_raddr <= ctrl_raddr + 1;
                            end else begin
                                ctrl_raddr <= 0;
                            end
                            if(ctrl_count <= 1) begin
                                if(repetition_r <= 1) begin
                                    state <= IDLE;
                                    wave_valid_r <= 0;
                                end else begin
                                    repetition_r <= repetition_r - 1;
                                    ctrl_count <= ctrl_length_r;
                                end
                            end else begin
                                ctrl_count <= ctrl_count - 1;
                            end
                        end else begin
                            wave_repetition <= wave_repetition - 1;
                            wave_addr_r <= wave_offset;
                            wave_count <= wave_length;
                        end
                    end else begin
                        wave_addr_r <= wave_addr_r + 1;
                        wave_count <= wave_count - 1;
                    end
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

    wire [WAVE_RAM_DELAY:0] wave_valid_d;
    assign wave_valid_d[0] = wave_valid_r;
    generate
        genvar k;
        for(k = 0; k < WAVE_RAM_DELAY; k=k+1)
        begin: generate_delay
            delay delay_i(.clk(clk), .din(wave_valid_d[k]), .dout(wave_valid_d[k+1]));
        end
    endgenerate
    assign wave_valid = wave_valid_d[WAVE_RAM_DELAY];

endmodule // mawg
