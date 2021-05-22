module logic_tile(out, clock, in1, in2, in3, in4, in5);
  output out;
  input in1, in2, in3, in4, in5;//address
  input clock;
  
  reg out1, q, qbar;
  
  //LUT data
  reg [32:0] mem;
  
  initial q = 1'b0; //initialise to 0
  
  always @ (*)
    begin
      case({in5,in4,in3,in2,in1})
        5'b00000 : out1 <= mem[0];
        5'b00001 : out1 <= mem[1];
        5'b00010 : out1 <= mem[2];
        5'b00011 : out1 <= mem[3];
        5'b00100 : out1 <= mem[4];
        5'b00101 : out1 <= mem[5];
        5'b00110 : out1 <= mem[6];
        5'b00111 : out1 <= mem[7];
        5'b01000 : out1 <= mem[8];
        5'b01001 : out1 <= mem[9];
        5'b01010 : out1 <= mem[10];
        5'b01011 : out1 <= mem[11];
        5'b01100 : out1 <= mem[12];
        5'b01101 : out1 <= mem[13];
        5'b01110 : out1 <= mem[14];
        5'b01111 : out1 <= mem[15];
        5'b10000 : out1 <= mem[16];
        5'b10001 : out1 <= mem[17];
        5'b10010 : out1 <= mem[18];
        5'b10011 : out1 <= mem[19];
        5'b10100 : out1 <= mem[20];
        5'b10101 : out1 <= mem[21];
        5'b10110 : out1 <= mem[22];
        5'b10111 : out1 <= mem[23];
        5'b11000 : out1 <= mem[24];
        5'b11001 : out1 <= mem[25];
        5'b11010 : out1 <= mem[26];
        5'b11011 : out1 <= mem[27];
        5'b11100 : out1 <= mem[28];
        5'b11101 : out1 <= mem[29];
        5'b11110 : out1 <= mem[30];
        5'b11111 : out1 <= mem[31];
      endcase
    end
  //flip flop
  always @ (posedge clock)
    begin
      q <= out1;
    end
  //0->out1 and 1->q
  assign out = (~mem[32] & out1) | (mem[32] & q);
endmodule

module switch_box_4x4(out, in);
  output [3:0] out;
  input [3:0] in;
  
  //configuration data
  reg [15:0] configure;
  
  //out[0]
  assign out[0] = (in[0] & configure[0]) | (in[1] & configure[1]) | (in[2] & configure[2]) | (in[3] & configure[3]); 
  //out[1]
  assign out[1] = (in[0] & configure[4]) | (in[1] & configure[5]) | (in[2] & configure[6]) | (in[3] & configure[7]);
  //out[2]
  assign out[2] = (in[0] & configure[8]) | (in[1] & configure[9]) | (in[2] & configure[10]) | (in[3] & configure[11]);
  //out[3]
  assign out[3] = (in[0] & configure[12]) | (in[1] & configure[13]) | (in[2] & configure[14]) | (in[3] & configure[15]);
  
endmodule

//circuit id7 takes it's input as 8 parallel-in, 3 control
//and one for serial-in, that's 12 input pins, and max output
//for 8 output pins for id-7 (parallel-out), we can therefore have an input of
//maximum 12 pins and output of 8 pins
module fpga(datain, dataout, c2, c1, c0, sin, clock);
  output [7:0] dataout;
  input [7:0] datain;
  input c2, c1, c0;
  //c2 -> shl //used as cin for BCD adder
  //c1 -> shr
  //c0 -> load data(l)
  input sin; //for right shift id-7
  input clock;
  
  wire spec;//indicates when sum exceeds 1
  wire diverter; //inserted for carry out of BCD adder
  wire [7:0] hold;
  wire [7:0] hold2;
  wire [3:0] out1, out9;
  wire [3:0] out2, out10;
  wire [3:0] out3, out11;
  wire [3:0] out4, out12;
  wire [3:0] out5, out13;
  wire [3:0] out6, out14;
  wire [3:0] out7, out15;
  wire [3:0] out8, out16;
  wire [3:0] out0;
  wire [2:0] filler;
  
  //out, clock, i1, i2 ...
  switch_box_4x4 E1(out0, {c0, c1, c2, spec});
  
  switch_box_4x4 B8(out8, {dataout[7], sin, c2, hold2[3]});
  
  switch_box_4x4 C8(out16, {datain[7], c2, hold[6], dataout[6]});
  
  logic_tile A1(hold[7], clock, out0[0], out0[1], out16[0], out16[1], out8[1]);
  logic_tile A2(hold2[7], clock, out0[0], out0[1], out16[0], out16[2], out8[0]);
  logic_tile A3(dataout[7], clock, out0[0], out0[1], c2, hold2[7], hold[7]);
  
  switch_box_4x4 B7(out7, {dataout[6], dataout[7], c2, hold2[2]});
  
  switch_box_4x4 C7(out15, {datain[6], c2, hold[5], dataout[5]});
  
  logic_tile A4(hold[6], clock, out0[0], out0[1], out0[2], out15[1], out7[1]);
  logic_tile A5(hold2[6], clock, out0[0], out0[1], out0[2], out15[2], out7[0]);
  logic_tile A6(dataout[6], clock, out0[0], out0[1], c2, hold2[6], hold[6]);
  
  switch_box_4x4 B6(out6, {dataout[5], dataout[6], c2, hold2[1]});
  
  switch_box_4x4 C6(out14, {datain[5], c2, 1'b0, dataout[4]});
  
  logic_tile A7(hold[5], clock, out0[0], out0[1], out0[2], out14[1], out6[1]);
  logic_tile A8(hold2[5], clock, out0[0], out0[1], out0[2], out14[2], out6[0]);
  logic_tile A9(dataout[5], clock, out0[0], out0[1], c2, hold2[5], hold[5]);
  
  switch_box_4x4 B5(out5, {dataout[4], dataout[5], c2, hold2[0]});
  
  switch_box_4x4 C5(out13, {datain[4], c2, 1'b0, dataout[3]});
  
  logic_tile A10(hold[4], clock, out0[0], out0[1], out13[0], out13[1], out5[1]);
  logic_tile A11(hold2[4], clock, out0[0], out0[1], out13[0], out13[2], out5[0]);
  logic_tile A12(dataout[4], clock, out0[0], out0[1], c2, hold2[4], hold[4]);
  
  //using the part below to make a 4-bit adder
  switch_box_4x4 B4(out4, {dataout[3], dataout[4], c2, datain[7]});
  
  switch_box_4x4 C4(out12, {datain[3], c2, hold[2], dataout[2]});
  
  logic_tile A13(hold[3], clock, out0[0], out0[1], out12[0], out12[1], out4[1]);
  logic_tile A14(hold2[3], clock, out0[0], out0[1], out12[0], out12[2], out4[0]);
  logic_tile A15(dataout[3], clock, out0[0], out0[1], c2, hold2[3], hold[3]);
  
  switch_box_4x4 B3(out3, {dataout[2], dataout[3], c2, datain[6]});
  
  switch_box_4x4 C3(out11, {datain[2], c2, hold[1], dataout[1]});
  
  logic_tile A16(hold[2], clock, out0[0], out0[1], out11[0], out11[1], out3[1]);
  logic_tile A17(hold2[2], clock, out0[0], out0[1], out11[0], out11[2], out3[0]);
  logic_tile A18(dataout[2], clock, out0[0], out0[1], c2, hold2[2], hold[2]);
  
  switch_box_4x4 B2(out2, {dataout[1], dataout[2], c2, datain[5]});
  
  switch_box_4x4 C2(out10, {datain[1], c2, hold[0], dataout[0]});
  
  logic_tile A19(hold[1], clock, out0[0], out0[1], out10[0], out10[1], out2[1]);
  logic_tile A20(hold2[1], clock, out0[0], out0[1], out10[0], out10[2], out2[0]);
  logic_tile A21(dataout[1], clock, out0[0], out0[1], c2, hold2[1], hold[1]);
  
  switch_box_4x4 B1(out1, {dataout[0], dataout[1], 1'b0, datain[4]});
  
  switch_box_4x4 C1(out9, {datain[0], c2, 1'b0, 1'b0});

  logic_tile A22(hold[0], clock, out0[0], out0[1], out9[0], out9[1], out1[1]);
  logic_tile A23(hold2[0], clock, out0[0], out0[1], out9[0], out9[2], out1[0]);
  logic_tile A24(diverter, clock, out0[0], out0[1], c2, hold2[0], hold[0]);
  
  //the purpose of this logic tile is to find if the number is greater than 9
  logic_tile L1(spec, clock, hold2[1], hold2[2], hold2[3], hold[3], 1'b0);
  
  //carry-out
  switch_box_4x4 D1({filler, dataout[0]}, {1'b0, 1'b0, spec, diverter});
  
endmodule