`timescale 1ns/1ps

module tb_d1p1();

    parameter INPUT_SIZE = 4658;

    logic clk;
    logic rst_n;
    logic [10:0] mem [0:INPUT_SIZE];
    logic [11:0] pwd;

    d1p1 #(INPUT_SIZE) dut(clk, rst_n, mem, pwd);

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_d1p1);
    end

    always #5 clk = ~clk;

    initial
        clk = 0;

    initial begin
        $readmemb("input_2.vmem", mem);
        #20
        rst_n = 1;
        #20
        rst_n = 0;
        #20
        rst_n = 1;
        #20
        $monitor("The password is: ", pwd);
        #500000
        $finish;
    end

endmodule