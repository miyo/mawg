`default_nettype none

module singleportram#(parameter WIDTH=32, DEPTH=10, WORDS=1024, SOURCE="source.txt")
    (
     input wire 		    clk,
     input wire 		    reset,
     output wire [31:0] 	    length,
     input wire [DEPTH-1:0]  address,
     input wire [WIDTH-1:0]  din,
     output wire [WIDTH-1:0] dout,
     input wire 		    we,
     input wire 		    oe
     );
    
    (* ram_style = "block" *) reg [WIDTH-1:0] mem [WORDS-1:0];
    reg [WIDTH-1:0] 	    dout_r;
    assign dout = dout_r;
    
    assign length = WORDS;
    
    initial begin
        $readmemh(SOURCE, mem, 0, WORDS-1);
    end
    
    always@(posedge clk) begin
        if(we) begin
	    mem[address[DEPTH-1:0]] <= din;
        end
    end
    
    always@(posedge clk) begin
        dout_r <= mem[address[DEPTH-1:0]];
    end
    
endmodule

`default_nettype wire
