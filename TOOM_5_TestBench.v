`timescale 10ns / 1ns

module TOOM_5TB;

    reg clk;
    reg [1023:0] D_in, E_in;
    wire [2047:0] mul_value;

    TOOM_5 uut (.clk(clk),.D_in(D_in),.E_in(E_in),.mul_value(mul_value));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        #10;

        D_in = 1024'd123456781234567812345678876543211234567812345678;
        E_in = 1024'd876543218765432187654321123456781234567812345678;
        #20;
        $dumpfile("output.vcd");
        $dumpvars(0,TOOM_5TB);

        $monitor($time," " , "D_in = %0d, E_in = %0d, mul_value = %0d",D_in,E_in,mul_value);
        
        #20;
        $finish;
    end

endmodule
