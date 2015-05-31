import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module arbiter
(
	input clk,
	input L2inst_rd_req,
	input lc3b_word L2inst_address,
	input L2data_rd_req,
	input L2data_wr_req,
	input lc3b_word L2data_address,
	input L2_resp,				// The response from L2
	output logic arb_inst_resp, // this gets sent to the instruction cache to let it know that its memory request is finished
	output logic L2_read,
	output logic L2_write,
	output logic arb_data_resp, // this gets sent to the data cache to let it know that its memory request is finished
	output lc3b_word L2_address
);

enum int unsigned {	
	L2I_RD_GRANT,
	L2I_RESP,
	L2D_RD_GRANT,
	L2D_WR_GRANT,
	L2D_RESP
} state, next_state;
	
always_comb
begin : next_state_logic
	next_state = state;
	case(state)		
		// instruction read from L2 is granted
		L2I_RD_GRANT: begin
			// when we get a response from L2...
			if ( L2_resp )
				// we check if there's also a request from the data cache
				next_state = L2I_RESP;
			else if ( L2data_rd_req && !L2inst_rd_req )
				// keep waiting for a request
				next_state = L2D_RD_GRANT;
			else if ( L2data_wr_req && !L2inst_rd_req )
				next_state = L2D_WR_GRANT;
			else
				next_state = L2I_RD_GRANT;
		end
		
		L2I_RESP: begin
			if ( L2data_rd_req )
				next_state = L2D_RD_GRANT;
			else if ( L2data_wr_req )
				next_state = L2D_WR_GRANT;
			else
				next_state = L2I_RD_GRANT;
		end
		
		// data read from L2 is granted
		L2D_RD_GRANT: begin
			// when we get a response from L2...
			if ( L2_resp )
				next_state = L2D_RESP;
				// we check if there's also a read request from the instruction cache
			else
				next_state = L2D_RD_GRANT;
		end
		
		// data write to L2 is granted
		L2D_WR_GRANT: begin
			if ( L2_resp )
				next_state = L2D_RESP;
			else
				next_state = L2D_WR_GRANT;
		end
		
		L2D_RESP: begin
			next_state = L2I_RD_GRANT;
		end
		
		default: begin
			next_state = L2I_RD_GRANT;
		end
	endcase
end

always_comb
begin : state_actions

	/* Default assignments */
	L2_read = 1'b0;
	L2_write= 1'b0;
	arb_inst_resp = 1'b0;
	arb_data_resp = 1'b0;
	
	L2_address = L2inst_address;
	
	case(state)
		L2I_RD_GRANT: begin
			if ( L2inst_rd_req ) 	
				L2_read = 1'b1;
		end
		
		L2I_RESP: begin
			arb_inst_resp = 1'b1;
		end
		
		L2D_RD_GRANT: begin
			L2_read = 1'b1;
			L2_address = L2data_address;
		end
		
		L2D_WR_GRANT: begin
			L2_write= 1'b1;
			L2_address = L2data_address;
		end
		
		L2D_RESP: begin
			arb_data_resp = 1'b1;
		end
		
		default: begin
			// nothin'
		end
	endcase
end

always_ff @(posedge clk)
begin : next_state_assignment
    state <= next_state;
end

endmodule : arbiter
