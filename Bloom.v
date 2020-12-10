module Bloom(data,clk,insert,check,match,reset,bl_out);
	parameter d_size = 8;
	parameter bl_size = 32;
	input clk,insert,check,reset;
	input[d_size-1:0] data;
	reg[bl_size-1:0] gen_bloom,bloom_filter,b;
	wire[bl_size-1:0] gen_bl,bloom_fl,e;
	output reg[bl_size-1:0] bl_out;
	output match;
	
	//assign gen_bloom = gen_bl;
	//assign bloom_filter = bloom_fl;
	always@(negedge clk or posedge reset )
	begin
	if(reset)begin
	bloom_filter <= 0;
	end
	if(insert) begin
	bloom_filter <= gen_bl|bloom_filter;
	bl_out <= bloom_filter; end
	
	end

	hash #(d_size,bl_size) 
	hash_block(.clk(clk),
				.reset(reset),
				.insert(insert),
				.check(check),
				.data(data),
				.gen_bloom(gen_bl));
	
	//add#(bl_size) a1(bloom_fl,gen_bl,bloom_fl);
	
	
	assign bloom_fl = bloom_filter;
	comparator #(d_size,bl_size) 
	comparator_block(.clk(clk),
				.check(check),
				.gen_bloom(gen_bl),
				.bloom_filter(bl_out),
				.match(match));
		

	//gen_bloom <= gen_bl;
	

endmodule 