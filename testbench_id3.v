module tb();
  reg [31:0] mem [0:14];
  wire [7:0] dataout;
  reg sin;
  reg [7:0] datain;
  reg c2, c1, c0;
  reg clk;
  
  initial clk = 0;
  always #10 clk = ~clk;

  fpga F1(datain, dataout, c2, c1, c0, sin, clk);

  initial begin
    $readmemh("configure_id3.mem", mem);
    F1.A1.mem = {1'b0,mem[0]};
    F1.A2.mem = {1'b0,mem[8]};
    F1.A3.mem = {1'b0,mem[9]};
    
    F1.A4.mem = {1'b0,mem[0]};
    F1.A5.mem = {1'b0,mem[7]};
    F1.A6.mem = {1'b0,mem[9]};
    
    F1.A7.mem = {1'b0,mem[0]};
    F1.A8.mem = {1'b0,mem[6]};
    F1.A9.mem = {1'b0,mem[9]};
    
    F1.A10.mem = {1'b0,mem[0]};
    F1.A11.mem = {1'b0,mem[5]};
    F1.A12.mem = {1'b0,mem[9]};
    
    F1.A13.mem = {1'b0,mem[0]};
    F1.A14.mem = {1'b0,mem[4]};
    F1.A15.mem = {1'b0,mem[9]};
    
    F1.A16.mem = {1'b0,mem[0]};
    F1.A17.mem = {1'b0,mem[3]};
    F1.A18.mem = {1'b0,mem[9]};
    
    F1.A19.mem = {1'b0,mem[0]};
    F1.A20.mem = {1'b0,mem[2]};
    F1.A21.mem = {1'b0,mem[9]};
    
    F1.A22.mem = {1'b0,mem[0]};
    F1.A23.mem = {1'b0,mem[1]};
    F1.A24.mem = {1'b0,mem[9]};
    
    F1.L1.mem = {1'b0,mem[11]};
    
    F1.B1.configure = mem[10];
    F1.B2.configure = mem[10];
    F1.B3.configure = mem[10];
    F1.B4.configure = mem[10];
    F1.B5.configure = mem[10];
    F1.B6.configure = mem[10];
    F1.B7.configure = mem[10];
    F1.B8.configure = mem[10];
    
    F1.C1.configure = mem[12];
    F1.C2.configure = mem[12];
    F1.C3.configure = mem[12];
    F1.C4.configure = mem[12];
    F1.C5.configure = mem[12];
    F1.C6.configure = mem[12];
    F1.C7.configure = mem[12];
    F1.C8.configure = mem[12];
    
    F1.E1.configure = mem[13];
    
    F1.D1.configure = mem[14];
  end
  
  initial begin
    datain = 8'b01010011;
    c2 = 1'b0;
    c1 = 1'b0;
    c0 = 1'b0;
    #5
    $display("1.  datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
    
    c2 = 1'b0;
    c1 = 1'b0;
    c0 = 1'b1;
    #5
    $display("2.  datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
    
    c2 = 1'b0;
    c1 = 1'b1;
    c0 = 1'b0;
    #5
    $display("3.  datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
    
    c2 = 1'b0;
    c1 = 1'b1;
    c0 = 1'b1;
    #5
    $display("4.  datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
    
    c2 = 1'b1;
    c1 = 1'b0;
    c0 = 1'b0;
    #5
    $display("5.  datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
    
    c2 = 1'b1;
    c1 = 1'b0;
    c0 = 1'b1;
    #5
    $display("6.  datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
    
    c2 = 1'b1;
    c1 = 1'b1;
    c0 = 1'b0;
    #5
    $display("7.  datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
    
    c2 = 1'b1;
    c1 = 1'b1;
    c0 = 1'b1;
    #5
    $display("8.  datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
    
    $display("datain changed!");
    
    datain = 8'b10101100;
    c2 = 1'b0;
    c1 = 1'b0;
    c0 = 1'b0;
    #5
    $display("9.  datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
    
    c2 = 1'b0;
    c1 = 1'b0;
    c0 = 1'b1;
    #5
    $display("10. datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
    
    c2 = 1'b0;
    c1 = 1'b1;
    c0 = 1'b0;
    #5
    $display("11. datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
    
    c2 = 1'b0;
    c1 = 1'b1;
    c0 = 1'b1;
    #5
    $display("12. datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
    
    c2 = 1'b1;
    c1 = 1'b0;
    c0 = 1'b0;
    #5
    $display("13. datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
    
    c2 = 1'b1;
    c1 = 1'b0;
    c0 = 1'b1;
    #5
    $display("14. datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
    
    c2 = 1'b1;
    c1 = 1'b1;
    c0 = 1'b0;
    #5
    $display("15. datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
    
    c2 = 1'b1;
    c1 = 1'b1;
    c0 = 1'b1;
    #5
    $display("16. datain : %b, c2 : %b, c1 : %b, c0 : %b, mux_output : %b", datain, c2, c1, c0, dataout[7]);
  end
  
  initial
    begin
      $dumpfile("ha3.vcd");
      $dumpvars;
      
    end
  
  initial
    #100  $finish;
endmodule
/*
0000FF00
00000100
00000200
00000400
00000800
00001000
00002000
00004000
00008000
FFFFFF00
0000
00000000
0814
0248
0001
*/