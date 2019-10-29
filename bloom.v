module bloom(clk,data,rst,insert,check,match, out);
	
	parameter size = 8;
	input[size-1:0]  data;
	wire[size-1:0]  data_l;
	input wire clk,rst,insert,check;
	output match;
	reg[size-1:0] gen_bl, bloom_f, chk;
	reg match_1;
	output wire[size-1:0] out;
	wire[size-1:0] ck,bf,gen;
	integer i;
	
	assign data_l = data;
	
	always@(negedge clk or posedge rst )
	begin
		
		if(rst)
		begin 
			gen_bl <= 0;
			bloom_f <= 0;
		end
		
		else if(insert == 1) 
			begin
				gen_bl <= data_l;
				bloom_f <= gen_bl|bloom_f;
				 
			end
			
		else if(check==1)
			begin
				gen_bl <= data_l;
				chk <= gen_bl&bloom_f;
				for(i =0 ; i < size;i = i+1)begin
					if(gen_bl[i] == 1'b1)
					match_1 = match_1 & chk[i];
				end 
				
			
			//comparator comp_inst(clk ,	gen_bl ,bloom_f ,match);	
			end
	end
	
	assign match = match_1;
	assign out = bloom_f;
	
endmodule
	
	