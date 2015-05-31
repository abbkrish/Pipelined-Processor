import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module icache_control
(
	input clk,

	/* Datapath controls */
	input				lru,
	input		 		hit_A, hit_B,
	
	input 		 		valid_A_dataout, valid_B_dataout,
	output logic 		valid_A_write, valid_B_write,
	output logic 		valid_A_datain, valid_B_datain,
	
	output logic		tag_A_write, tag_B_write,
	
	output logic 		data_A_write, data_B_write,
	
	output logic		lru_datain,
	output logic		lru_write,
	
	/* Memory signals */
	
	input 				icache_read,
	output logic		icache_resp,
	
	input				L2_resp,//L2_resp,
	output logic		L2_read//L2_read,
);

enum int unsigned {
	HIT,
	MISS,
	SET_STATUS_MISS
} state, next_state;

always_comb
begin : state_actions

	/* Default assignments */
	lru_datain = 1'b0;
	lru_write = 1'b0;
	
	valid_A_write = 1'b0;
	valid_B_write = 1'b0;
	valid_A_datain = 1'b0;
	valid_B_datain = 1'b0;
	
	tag_A_write = 1'b0;
	tag_B_write = 1'b0;
	
	data_A_write = 1'b0;
	data_B_write = 1'b0;
	
	L2_read = 1'b0;
	icache_resp = 1'b0;
		
	case(state)	
		
		HIT: begin
			if (hit_A || hit_B && icache_read)
			begin
				icache_resp = 1'b1;
			
				if (hit_A && valid_A_dataout)
				begin

					/* should be taken care of by hardware wire-y stuff */
					// data_write = 1'b1;	// write dat data
					
					lru_write = 1'b1;
					lru_datain = 1'b0; // wrote to A, least recent is now B
				end
				else if (hit_B && valid_B_dataout)
				begin
					
					/* should be taken care of by hardware wire-y stuff */
					// data_write = 1'b1;	// write dat data
					
					lru_write = 1'b1;
					lru_datain = 1'b1; // wrote to B, least recent is now A
				end
			end
		end
		
		MISS: begin
			L2_read = 1'b1;			// we want to read the new and exciting stuff from L2
			
			if (lru == 1'b1)
			begin
				data_A_write = 1'b1;		// write the data...
				tag_A_write = 1'b1;			// and the tag
			end
			
			if (lru == 1'b0)
			begin
				data_B_write = 1'b1;		// write the data...
				tag_B_write = 1'b1;			// and the tag
			end
		end
		
		SET_STATUS_MISS: begin
			if (lru == 1'b1)
			begin
				valid_A_write = 1'b1; // set valid bit of least recently used
				valid_A_datain = 1'b1;
			end
			if (lru == 1'b0)
			begin
				valid_B_write = 1'b1; // set valid bit of least recently used
				valid_B_datain = 1'b1;
			end
		end
		
		default: /* Do nothing */;
	endcase
end
	
always_comb
begin : next_state_logic
	next_state = state;
	case(state)
	
		HIT: begin
			if (lru == 1'b1 && !hit_B && icache_read)							// if we messed with B last...
			begin
				if (!hit_A) 	// if there's no hit on A
				begin
					next_state = MISS;					// It's a MISS
				end
			end
			else if (lru == 1'b0 && !hit_A && icache_read)						// if we messed with A last...
			begin
				if (!hit_B)
				begin // if there's no hit on B
					next_state = MISS;					// It's a MISS
				end
			end
			else next_state = HIT;
		end
		
		MISS: begin
			if (L2_resp)
			begin
				next_state = SET_STATUS_MISS;
			end
			else
			begin
				next_state = MISS;
			end
		end
	
		SET_STATUS_MISS: begin
			next_state = HIT;
		end
	
		default: begin next_state = HIT; end
	endcase
end

always_ff @(posedge clk)
begin : next_state_assignment
    state <= next_state;
end

endmodule : icache_control
