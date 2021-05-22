module tb();
  reg [31:0] mem [0:9];
  wire [7:0] dataout;
  reg [7:0] datain;
  reg cin, c0, c1, sin;
  reg clk;
  reg [3:0] a;
  reg [3:0] b;
  
  initial clk = 0;
  always #10 clk = ~clk;

  fpga F1(.datain(datain), .dataout(dataout), .c2(cin), .c1(c1), .c0(c0), .sin(sin), .clock(clk));

  initial begin
    $readmemh("configure_id2.mem", mem);
    F1.A1.mem = {1'b0,mem[0]};
    F1.A2.mem = {1'b0,mem[1]};
    F1.A3.mem = {1'b0,mem[2]};
    
    F1.A4.mem = {1'b0,mem[0]};
    F1.A5.mem = {1'b0,mem[1]};
    F1.A6.mem = {1'b0,mem[2]};
    
    F1.A7.mem = {1'b0,mem[0]};
    F1.A8.mem = {1'b0,mem[1]};
    F1.A9.mem = {1'b0,mem[2]};
    
    F1.A10.mem = {1'b0,mem[0]};
    F1.A11.mem = {1'b0,mem[1]};
    F1.A12.mem = {1'b0,mem[2]};
    
    F1.A13.mem = {1'b0,mem[0]};
    F1.A14.mem = {1'b0,mem[1]};
    F1.A15.mem = {1'b0,mem[2]};
    
    F1.A16.mem = {1'b0,mem[0]};
    F1.A17.mem = {1'b0,mem[1]};
    F1.A18.mem = {1'b0,mem[2]};
    
    F1.A19.mem = {1'b0,mem[0]};
    F1.A20.mem = {1'b0,mem[1]};
    F1.A21.mem = {1'b0,mem[2]};
    
    F1.A22.mem = {1'b0,mem[0]};
    F1.A23.mem = {1'b0,mem[1]};
    F1.A24.mem = {1'b0,mem[2]};
    
    F1.L1.mem = {1'b0, mem[7]};
    
    F1.B1.configure = mem[3];
    F1.B2.configure = mem[3];
    F1.B3.configure = mem[3];
    F1.B4.configure = mem[3];
    F1.B5.configure = mem[3];
    F1.B6.configure = mem[3];
    F1.B7.configure = mem[3];
    F1.B8.configure = mem[3];
    
    F1.C1.configure = mem[4];
    F1.C2.configure = mem[5];
    F1.C3.configure = mem[5];
    F1.C4.configure = mem[5];
    
    F1.C5.configure = mem[8];
    F1.C6.configure = mem[8];
    F1.C7.configure = mem[8];
    F1.C8.configure = mem[8];
    
    F1.E1.configure = mem[6];
    
    F1.D1.configure = mem[9];
  end
  
  initial begin
    a = 4'b1001; b = 4'b0100;
    datain = {a,b};
    cin = 1'b1;
    #5
    $display("1.  A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b1001; b = 4'b1001;
    datain = {a,b};
    cin = 1'b1;
    #5
    $display("2.  A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b1000; b = 4'b1000;
    datain = {a,b};
    cin = 1'b0;
    #5
    $display("3.  A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b0111; b = 4'b0101;
    datain = {a,b};
    cin = 1'b1;
    #5
    $display("4.  A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b0111; b = 4'b0111;
    datain = {a,b};
    cin = 1'b1;
    #5
    $display("5.  A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b0101; b = 4'b0000;
    datain = {a,b};
    cin = 1'b1;
    #5
    $display("6.  A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b0001; b = 4'b1000;
    datain = {a,b};
    cin = 1'b0;
    #5
    $display("7.  A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b0100; b = 4'b0101;
    datain = {a,b};
    cin = 1'b0;
    #5
    $display("8.  A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b0010; b = 4'b0110;
    datain = {a,b};
    cin = 1'b0;
    #5
    $display("9.  A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b1001; b = 4'b0111;
    datain = {a,b};
    cin = 1'b1;
    #5
    $display("10. A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b0100; b = 4'b0101;
    datain = {a,b};
    cin = 1'b1;
    #5
    $display("11. A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b0111; b = 4'b0111;
    datain = {a,b};
    cin = 1'b0;
    #5
    $display("12. A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b0001; b = 4'b0011;
    datain = {a,b};
    cin = 1'b0;
    #5
    $display("13. A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b0110; b = 4'b0010;
    datain = {a,b};
    cin = 1'b1;
    #5
    $display("14. A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b0100; b = 4'b0001;
    datain = {a,b};
    cin = 1'b1;
    #5
    $display("15. A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b0101; b = 4'b1000;
    datain = {a,b};
    cin = 1'b0;
    #5
    $display("16. A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b0001; b = 4'b0001;
    datain = {a,b};
    cin = 1'b0;
    #5
    $display("17. A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b0111; b = 4'b0110;
    datain = {a,b};
    cin = 1'b0;
    #5
    $display("18. A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b0100; b = 4'b0100;
    datain = {a,b};
    cin = 1'b0;
    #5
    $display("19. A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
    
    a = 4'b1001; b = 4'b0001;
    datain = {a,b};
    cin = 1'b1;
    #5
    $display("20. A : %b, B : %b, cin : %b, cout : %b, BCD-sum : %b", datain[3:0], datain[7:4], cin, dataout[0], dataout[7:4]);
  end
  
  initial
    begin
      $dumpfile("ha2.vcd");
      $dumpvars;
      
    end
  
  initial
    #100  $finish;
endmodule
/*
FFF0F000
F00F0FF0
FF00FF00
0011
0884
0882
0100
FFE0FFE0
0220
0002
*/