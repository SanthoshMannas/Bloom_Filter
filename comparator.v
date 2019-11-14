module comparator(clk,check,gen_bloom,bloom_filter,match);
		parameter d_size = 8;
		parameter bl_size = 16;
		input[bl_size-1:0] gen_bloom,bloom_filter;
		input clk,check;
		output reg match;
		reg match_1 = 1'b1;
		integer i;
		always@(negedge clk)
		begin
			if(check ==1)begin
				for(i =0 ; i < bl_size;i = i+1)begin
					if(gen_bloom[i] == 1'b1)
					match_1 <= match_1 & bloom_filter[i];
				end
				match <= match_1;
			end
		end
	endmodule
