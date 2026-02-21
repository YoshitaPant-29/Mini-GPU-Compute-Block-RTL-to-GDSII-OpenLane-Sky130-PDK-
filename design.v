`timescale 1ns/1ps
// Code your design here
module simd_add #(
    parameter WIDTH = 16
)(
    input  logic clk,
    input  logic rst,
    input  logic [WIDTH-1:0] a0, a1, a2, a3,
    input  logic [WIDTH-1:0] b0, b1, b2, b3,
    output logic [WIDTH-1:0] c0, c1, c2, c3
);

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        c0 <= 0; c1 <= 0; c2 <= 0; c3 <= 0;
    end else begin
        c0 <= a0 + b0;
        c1 <= a1 + b1;
        c2 <= a2 + b2;
        c3 <= a3 + b3;
    end
end

endmodule
