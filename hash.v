module hash(clk,reset,insert,check,data,gen_bloom);
	parameter d_size =8;
	parameter bl_size = 32;
	input clk,reset,insert,check;
	input[d_size-1:0] data;
	output reg[bl_size-1:0] gen_bloom;
	reg[d_size-1:0] hash_key[2:0], temp[2:0];
	reg[(2*d_size):0] temp_pr[2:0];
	integer i;
	reg en;
   
	always@( negedge clk or posedge reset )
		begin
			hash_key[0] <= 8'd105;
			hash_key[1] <= 8'd61;
			hash_key[2] <= 8'd7;
			gen_bloom <= 0;
			en <= insert || check;
			temp[0] <= 0;temp[1] <= 0;temp[2] <= 0;
			if(reset)begin
				gen_bloom <= 0;
			end
			case(en)
			1'b1: begin
				for(i =0;i<3;i=i+1)begin
					temp_pr[i] = hash_key[i]*data;
					//temp[i] = (temp_pr[i][(2*d_size)-1:(d_size-1)])/(2**4);
					temp[i] = ((temp_pr[i][d_size-1:0])/(2**4));
					gen_bloom[temp[i]] = 1'b1;
				end
			end
			1'b0:gen_bloom <= gen_bloom;
			endcase
			//$display(" bl :%b", gen_bloom);
		end
		 
endmodule
					
					
				
	
	
		
