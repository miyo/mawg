module delay
  (
   input wire clk,
   input wire din,
   output reg dout
   );

    always @(posedge clk) begin
        dout <= din;
    end
endmodule // delay

