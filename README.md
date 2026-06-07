# Advent Of Code In SystemVerilog

In this repo I try to solve all the 2025 Advent Of Code challenges using SystemVerilog!

## Running

To run any challenge folder, navigate to it and run the following in the terminal:

```
iverilog -g2012 -o d1p1.out d1p1.sv tb_d1p1.sv
vvp d1p1.out
gtkwave dump.vcd
```
