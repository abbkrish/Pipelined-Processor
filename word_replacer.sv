import lc3b_types::*; /* Import types defined in lc3b_types.sv */


// CHANGELY GANCHETLY LKJDJFKJA
module word_replacer
(
	input lc3b_word mem_address,
	input lc3b_mem_wmask byte_enable,
	input lc3b_L1_line data_block,
	input lc3b_word data_word,
	input enable,
	output lc3b_L1_line data_out
);

always_comb
begin
	if (enable)
	begin
		data_out = data_block;
		
		if (byte_enable[1])
		begin
			case(mem_address[3:1])
				0: data_out[15:8] = data_word[15:8];
				1: data_out[31:24] = data_word[15:8];
				2: data_out[47:40] = data_word[15:8];
				3: data_out[63:56] = data_word[15:8];
				4: data_out[79:72] = data_word[15:8];
				5: data_out[95:88] = data_word[15:8];
				6: data_out[111:104] = data_word[15:8];
				7: data_out[127:120] = data_word[15:8];
				default: /* nothing */;
			endcase
		end
		if (byte_enable[0])
		begin
			case(mem_address[3:1])
				0: data_out[7:0] = data_word[7:0];
				1: data_out[23:16] = data_word[7:0];
				2: data_out[39:32] = data_word[7:0];
				3: data_out[55:48] = data_word[7:0];
				4: data_out[71:64] = data_word[7:0];
				5: data_out[87:80] = data_word[7:0];
				6: data_out[103:96] = data_word[7:0];
				7: data_out[119:112] = data_word[7:0];
				default: /* nothing */;
			endcase
		end
	end
	else
		data_out = 128'hzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
end

endmodule: word_replacer
