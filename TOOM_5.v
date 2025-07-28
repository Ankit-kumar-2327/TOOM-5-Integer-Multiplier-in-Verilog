`timescale 1ns / 1ps
module TOOM_5(clk, D_in, E_in, mul_value);
    input clk;
    input  [1023:0] D_in;
    input  [1023:0] E_in;
    output reg [2047:0] mul_value;
  // adding one bit for making 1025 bits
    wire [1024:0] D ={1'b0 , D_in};
    wire [1024:0] E ={1'b0 , E_in};
    
    reg [1024:0] A;
    reg [1024:0] B;
    wire [2049:0] g0,g1,g2,g3,g4,g5,g6,g7,g8;
    
    wire [204:0] A0, A1, A2, A3, A4;
    wire [204:0] B0, B1, B2, B3, B4;

    always @(posedge clk) begin
        A <= D;
        B <= E;
        mul_value <= final_value[2047:0];
    end

    assign A0 = A[204:0];
    assign A1 = A[409:205];
    assign A2 = A[614:410];
    assign A3 = A[819:615];
    assign A4 = A[1023:820];

    assign B0 = B[204:0];
    assign B1 = B[409:205];
    assign B2 = B[614:410];
    assign B3 = B[819:615];
    assign B4 = B[1024:820];

    wire [205:0] A0_2 = {1'b0, A0};
    wire [205:0] A1_2 = {1'b0, A1};
    wire [205:0] A2_2 = {1'b0, A2};
    wire [205:0] A3_2 = {1'b0, A3};
    wire [205:0] A4_2 = {1'b0, A4};

    wire [205:0] B0_2 = {1'b0, B0};
    wire [205:0] B1_2 = {1'b0, B1};
    wire [205:0] B2_2 = {1'b0, B2};
    wire [205:0] B3_2 = {1'b0, B3};
    wire [205:0] B4_2 = {1'b0, B4};

    // Evaluation points
    wire signed [207:0] a0 = A0_2;
    wire signed [207:0] a1 = A0_2 + A1_2 + A2_2 + A3_2 + A4_2;
    wire signed [207:0] a2 = A0_2 - A1_2 + A2_2 - A3_2 + A4_2;
    wire signed [210:0] a3 = A0_2 + (A1_2<<<1) + (A2_2<<<2) + (A3_2<<<3) + (A4_2<<<4);
    wire signed [210:0] a4 = A0_2 - (A1_2<<<1) + (A2_2<<<2) - (A3_2<<<3) + (A4_2<<<4);
    wire signed [210:0] a5 = A0_2 + (A1_2<<<2) + (A2_2<<<4) + (A3_2<<<6) + (A4_2<<<8);
    wire signed [210:0] a6 = A0_2 - (A1_2<<<2) + (A2_2<<<4) - (A3_2<<<6) + (A4_2<<<8);
    wire signed [210:0] a7 = A0_2 + (A1_2<<<3) + (A2_2<<<6) + (A3_2<<<9) + (A4_2<<<12);
    wire signed [205:0] a8 = A4_2;

    wire signed [207:0] b0 = B0_2;
    wire signed [207:0] b1 = B0_2 + B1_2 + B2_2 + B3_2 + B4_2;
    wire signed [207:0] b2 = B0_2 - B1_2 + B2_2 - B3_2 + B4_2;
    wire signed [210:0] b3 = B0_2 + (B1_2<<<1) + (B2_2<<<2) + (B3_2<<<3) + (B4_2<<<4);
    wire signed [210:0] b4 = B0_2 - (B1_2<<<1) + (B2_2<<<2) - (B3_2<<<3) + (B4_2<<<4);
    wire signed [210:0] b5 = B0_2 + (B1_2<<<2) + (B2_2<<<4) + (B3_2<<<6) + (B4_2<<<8);
    wire signed [210:0] b6 = B0_2 - (B1_2<<<2) + (B2_2<<<4) - (B3_2<<<6) + (B4_2<<<8);
    wire signed [210:0] b7 = B0_2 + (B1_2<<<3) + (B2_2<<<6) + (B3_2<<<9) + (B4_2<<<12);
    wire signed [205:0] b8 = B4_2;

    wire signed [413:0] p0 = a0 * b0;
    wire signed [415:0] p1 = a1 * b1;
    wire signed [415:0] p2 = a2 * b2;
    wire signed [421:0] p3 = a3 * b3;
    wire signed [421:0] p4 = a4 * b4;
    wire signed [421:0] p5 = a5 * b5;
    wire signed [421:0] p6 = a6 * b6;
    wire signed [421:0] p7 = a7 * b7;
    wire signed [411:0] p8 = a8 * b8;

    wire [2049:0] c0 = p0;
    wire [2049:0] c8 = p8;

     wire [2049:0] c1 = (p1 - p2) >> 1;
     wire [2049:0] c2 = (p1 + p2 - 2*p0) >> 1;
     wire [2049:0] c3 = (p3 - p4) >> 1;
     wire [2049:0] c4 = (p3 + p4 - 2*p0) >> 1;
     wire [2049:0] c5 = (p5 - p6) >> 1;
     wire [2049:0] c6 = (p5 + p6 - 2*p0) >> 1;
     wire [2049:0] c7 = (p7 - p0) >> 3;
     

    wire [2047:0] final_value;
    assign final_value = c0 + (c1 << 205) + (c2 << 410) + (c3 << 615) +
                     (c4 << 820) + (c5 << 1025) + (c6 << 1230) +
                     (c7 << 1435) + (c8 << 1640);                                            
endmodule
