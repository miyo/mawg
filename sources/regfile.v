module regfile#(parameter DEPTH=8, parameter WIDTH=16)
    (
     input wire clk,
     input wire reset,

     input wire [DEPTH-1:0] waddr,
     input wire [WIDTH-1:0] wdata,
     input wire we,

     input wire [DEPTH-1:0] raddr,
     output wire [WIDTH-1:0] rdata
     );

    reg [WIDTH-1:0] mem [2**DEPTH-1:0];

    integer i;
    integer SIZE = 2**DEPTH;
    always @(posedge clk) begin
	if(reset == 1) begin
	    for(i = 0; i < SIZE; i=i+1) begin
		mem[i] = 0;
	    end
	end else begin
	    if(we == 1) begin
		mem[waddr] <= wdata;
	    end
	end
    end

    assign rdata = mem[raddr];

endmodule // regfile
