module comparator(clk,check,gen_bloom,bloom_filter,match);
		parameter d_size = 8;
		parameter bl_size = 32;
		input[bl_size-1:0] gen_bloom,bloom_filter;
		input clk,check;
		output reg match;
		reg match_1 ;
		integer i;
		
		always@(negedge clk)
		begin
			
			if(check == 1'b1)begin
				match_1 = 1'b1;
				//$display(" Compbl");
				for(i =0 ; i < bl_size;i = i+1)begin
					if(gen_bloom[i] == 1'b1) begin
					match_1 = match_1 & bloom_filter[i]; end
				end
				assign match = match_1;
				//$display(" i : %b |m : %b |", bloom_filter[i], match );
			end
		end
	endmodule
