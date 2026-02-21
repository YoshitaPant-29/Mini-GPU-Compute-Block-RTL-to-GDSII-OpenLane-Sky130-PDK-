// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module tb_simd_add;

parameter WIDTH = 16;

// Testbench signals
reg clk;
reg rst;

reg  [WIDTH-1:0] a0, a1, a2, a3;
reg  [WIDTH-1:0] b0, b1, b2, b3;

wire [WIDTH-1:0] c0, c1, c2, c3;

// Instantiate DUT
simd_add #(WIDTH) dut (
    .clk(clk),
    .rst(rst),
    .a0(a0), .a1(a1), .a2(a2), .a3(a3),
    .b0(b0), .b1(b1), .b2(b2), .b3(b3),
    .c0(c0), .c1(c1), .c2(c2), .c3(c3)
);

//////////////////////////////////////////////
// Clock Generation (10ns period)
//////////////////////////////////////////////
always #5 clk = ~clk;

//////////////////////////////////////////////
// Test Sequence
//////////////////////////////////////////////
initial begin

    // Dump waveform
    $dumpfile("simd_wave.vcd");
    $dumpvars(0, tb_simd_add);

    // Initialize
    clk = 0;
    rst = 1;

    a0=0; a1=0; a2=0; a3=0;
    b0=0; b1=0; b2=0; b3=0;

    #20;
    rst = 0;

    //////////////////////////////////////////////////
    // Test Case 1
    //////////////////////////////////////////////////
    a0=10; a1=20; a2=30; a3=40;
    b0=1;  b1=2;  b2=3;  b3=4;

    #10;   // Wait 1 clock cycle
if (c0 !== a0+b0 ||
    c1 !== a1+b1 ||
    c2 !== a2+b2 ||
    c3 !== a3+b3)
    $display("SIMD ERROR at time %t", $time);
else
    $display("SIMD PASS at time %t", $time);
    //////////////////////////////////////////////////
    // Test Case 2
    //////////////////////////////////////////////////
    a0=100; a1=200; a2=300; a3=400;
    b0=10;  b1=20;  b2=30;  b3=40;

    #10;
// Check results AFTER clock edge

    //////////////////////////////////////////////////
    // Test Case 3 (Random)
    //////////////////////////////////////////////////
    a0=$random; a1=$random; a2=$random; a3=$random;
    b0=$random; b1=$random; b2=$random; b3=$random;

    #20;

    $finish;
end

endmodule
