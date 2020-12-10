module bloom_tb;
    // inputs----------------------
     reg[7:0] data;
     reg clk,insert,check,reset;
    //outputs----------------------
     wire[31:0] bl_out;
     wire match;
    // Instantiate Bloom -----------
     Bloom #(8,32)
     bloom_dut(.data(data),
               .clk(clk),
               .insert(insert),
               .check(check),
               .match(match),
               .reset(reset),
               .bl_out(bl_out));
    // clock-------------------------
     always 
        #10 clk = ~clk;
    //initial ------------------------
     initial
     begin
         $display("                                                  ");
         $display($time, "      << Starting the Simulation >>     ");
         //$display($time, "  Bloom : %b", bl_out);
         clk = 1'b0;
         reset = 1'b0;
         #10 reset = 1'b1;
         #20 reset = 1'b0;
         //$display($time, "  Bloom : %b", bl_out);
         insert = 1'b0;
         check =1'b0;
         #10 insert = 1'b1;
         //#10 insert = 1'b0; 
         #40 data = 8'd10;
         //#40 insert = 1'b1;
         #40 data = 8'd52;
         #40 data = 8'd200;
         #40 data = 8'd79;
         #40 insert = 1'b0;
         #40 data = 8'd60;
         #40 check = 1'b1;
         #40 check = 1'b0;
         #20 data = 8'd52;
         #40 check = 1'b1;
         #40 check = 1'b0;
         
         //#40 data = 8'd60;
     end  
     initial
     begin
         $monitor($time, " | Data : %d | Insert: %b | Check: %b | Bloom : %b | Match: %b",data,insert,check,bl_out,match);
     end
endmodule

