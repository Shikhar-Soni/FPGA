module tb();
  reg [31:0] mem [0:7];
  wire [7:0] dataout;
  reg sin;
  reg [7:0] datain;
  reg shl, shr, l;
  reg clk;
  
  initial clk = 0;
  always #10 clk = ~clk;

  fpga F1(datain, dataout, shl, shr, l, sin, clk);

  initial begin
    $readmemh("configure_id7.mem", mem);
    F1.A1.mem = {1'b0,mem[0]};
    F1.A2.mem = {1'b0,mem[1]};
    F1.A3.mem = {1'b1,mem[2]};
    
    F1.A4.mem = {1'b0,mem[0]};
    F1.A5.mem = {1'b0,mem[1]};
    F1.A6.mem = {1'b1,mem[2]};
    
    F1.A7.mem = {1'b0,mem[0]};
    F1.A8.mem = {1'b0,mem[1]};
    F1.A9.mem = {1'b1,mem[2]};
    
    F1.A10.mem = {1'b0,mem[0]};
    F1.A11.mem = {1'b0,mem[1]};
    F1.A12.mem = {1'b1,mem[2]};
    
    F1.A13.mem = {1'b0,mem[0]};
    F1.A14.mem = {1'b0,mem[1]};
    F1.A15.mem = {1'b1,mem[2]};
    
    F1.A16.mem = {1'b0,mem[0]};
    F1.A17.mem = {1'b0,mem[1]};
    F1.A18.mem = {1'b1,mem[2]};
    
    F1.A19.mem = {1'b0,mem[0]};
    F1.A20.mem = {1'b0,mem[1]};
    F1.A21.mem = {1'b1,mem[2]};
    
    F1.A22.mem = {1'b0,mem[0]};
    F1.A23.mem = {1'b0,mem[1]};
    F1.A24.mem = {1'b1,mem[2]};
    
    F1.L1.mem = {1'b0, mem[3]};
    
    F1.B1.configure = mem[4];
    F1.B2.configure = mem[4];
    F1.B3.configure = mem[4];
    F1.B4.configure = mem[4];
    F1.B5.configure = mem[4];
    F1.B6.configure = mem[4];
    F1.B7.configure = mem[4];
    F1.B8.configure = mem[4];
    
    F1.C1.configure = mem[5];
    F1.C2.configure = mem[5];
    F1.C3.configure = mem[5];
    F1.C4.configure = mem[5];
    F1.C5.configure = mem[5];
    F1.C6.configure = mem[5];
    F1.C7.configure = mem[5];
    F1.C8.configure = mem[5];
    
    F1.E1.configure = mem[6];
    
    F1.D1.configure = mem[7];
  end
  
  initial begin
    //shl = 1, shift left
    //shr = 1, shift right
    //l = 1, load data
    //all of the above 0, retain
    
    datain = 8'b10101011;
    shl = 1'b0;
    shr = 1'b0;
    l = 1'b1; //data loads
    sin = 1'b1;
    #11
    //one posedge encountered, data loads into the register
    $display("1. dataout : %b", dataout);
    l = 1'b0;
    shr = 1'b1;
    #100
    //5 posedges here, shift right by 5 places
    $display("2. dataout : %b", dataout);
    #60
    //3 more posedges, shift right by 3 places, it's filled with sin bits
    $display("3. dataout : %b", dataout);
    
    datain = 8'b10110111;
    l = 1'b1;
    shr = 1'b0;
    #20
    //one posedge, data loads onto the register
    $display("4. dataout : %b", dataout);
    shl = 1'b1;
    l = 1'b0;
    #80
    //4 posedges, shifts left by 4 places
    shl = 1'b0;
    $display("5. dataout : %b", dataout);
    #20
    //one posedge, retains register info
    $display("6. dataout : %b", dataout);
  end
  
  initial
    begin
      $dumpfile("ha7.vcd");
      $dumpvars;
      
    end
  
  initial
    #300  $finish;
endmodule
/*
14041000
03010200
17140300
00000000
0048
0814
0248
0001
*/