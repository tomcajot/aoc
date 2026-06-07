`timescale 1ns/1ps

module tb_d1p2();

    parameter INPUT_SIZE = 4483;

    logic clk;
    logic rst_n;
    logic [10:0] mem [0:INPUT_SIZE];
    logic [14:0] pwd;

    d1p2 #(INPUT_SIZE) dut(clk, rst_n, mem, pwd);

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_d1p2);
    end

    always #5 clk = ~clk;

    initial
        clk = 0;

    initial begin
        $readmemb("input_1.vmem", mem);
        #20
        rst_n = 1;
        #20
        rst_n = 0;
        #20
        rst_n = 1;
        #20
        $monitor("The password is: ", pwd);
        #300000
        $finish;
    end

endmodule