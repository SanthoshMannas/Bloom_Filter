module Bloom(data,clk,insert,check,match,reset);
	parameter d_size = 8;
	parameter bl_size = 32;
	input clk,insert,check,reset;
	input[d_size:0] data;
	reg[bl_size-1:0] gen_bloom,bloom_filter,b;
	wire[bl_size-1:0] gen_bl,bloom_fl,e;
	output match;
	
	//assign gen_bloom = gen_bl;
	//assign bloom_filter = bloom_fl;
	
	hash #(d_size,bl_size) 
	hash_block(.clk(clk),
				.reset(reset),
				.insert(insert),
				.check(check),
				.data(data),
				.gen_bloom(gen_bl));
	
	always@(negedge clk )
	begin
	
	bloom_filter <= gen_bl|bloom_filter;
	if(reset)begin
	bloom_filter <= 0;
	end
	
	end
	//or o1(bloom_fl,bloom_fl,gen_bl);
	
	assign bloom_fl = bloom_filter;
	comparator #(d_size,bl_size) 
		comparator_block(.clk(clk),.check(check),.gen_bloom(gen_bl),.bloom_filter(bloom_fl),.match(match));
		

	//gen_bloom <= gen_bl;
	

endmodule 