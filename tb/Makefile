SOURCES=../sources/regfile.v ../sources/mawg.v ../sources/delay.v

.PHONY: all

all:
	ruby mawg_tb_1.rb > mawg_tb_1.txt
	iverilog mawg_tb_1.v singleportram.v $(SOURCES)
	./a.out
	diff -q mawg_tb_1_golden.txt mawg_tb_1_out.txt

