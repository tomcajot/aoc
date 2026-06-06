## Running

iverilog -g2012 -o d1p1.out d1p1.sv tb_d1p1.sv  
vvp d1p1.out
gtkwave dump.vcd
