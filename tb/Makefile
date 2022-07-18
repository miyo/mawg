SOURCES=../sources/regfile.v ../sources/mawg.v ../sources/delay.v

.PHONY: all

all:
	-rm -f a.out
	-rm -f mawg_tb_1_out.txt
	ruby mawg_tb_1.rb > mawg_tb_1.txt
	iverilog mawg_tb_1.v singleportram.v $(SOURCES)
	./a.out
	diff -q mawg_tb_1_golden.txt mawg_tb_1_out.txt
	-rm -f a.out
	-rm -f mawg_tb_2_out.txt
	iverilog mawg_tb_2.v singleportram.v $(SOURCES)
	./a.out
	diff -q mawg_tb_2_golden.txt mawg_tb_2_out.txt
