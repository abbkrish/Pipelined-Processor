import lc3b_types::*;

module MP3
(
    input clk,

	/* NOTE (mostly for Brandon, in which case it's a note to self):
		MUST CHANGE L1_line to L2_line when we hook up L2
	*/
	
    /* physical memory signals */
	input pmem_resp,
    input lc3b_L1_line pmem_rdata,
    output pmem_read,
    output pmem_write,
    output lc3b_word pmem_address,
    output lc3b_L1_line pmem_wdata
);


logic 			icache_resp;
logic 			icache_read;
lc3b_word 	icache_rdata;
lc3b_word		icache_address;

logic			dcache_resp;
logic			dcache_read;
logic			dcache_write;
lc3b_word		dcache_rdata;
lc3b_word		dcache_wdata;
lc3b_word		dcache_address;
lc3b_mem_wmask	mem_byte_enable;


pipeline_datapath pipeline_dp (
	.clk(clk),
	
	/* icache signals */
	.icache_resp(icache_resp),
	.icache_read(icache_read),
	.icache_rdata(icache_rdata),
	.icache_address(icache_address),
	
	/* dcache signals */
	.dcache_resp(dcache_resp),
	.dcache_read(dcache_read),
	.dcache_write(dcache_write),
	.dcache_rdata(dcache_rdata),
	.dcache_address(dcache_address),
	.dcache_wdata(dcache_wdata),
	.mem_byte_enable(mem_byte_enable)
);

cache_hierarchy CACHE_HIERARCHY(
	.clk(clk),
	
	/* icache signals */
	.icache_read(icache_read),
	.icache_address(icache_address),
	.icache_rdata(icache_rdata),
	.icache_resp(icache_resp),
	
	/* dcache signals */
    .dcache_read(dcache_read),
    .dcache_write(dcache_write),
    .mem_byte_enable(mem_byte_enable),
	.dcache_address(dcache_address),
    .dcache_wdata(dcache_wdata),
	.dcache_rdata(dcache_rdata),
	.dcache_resp(dcache_resp),
	
	/* physical memory signals */
	.pmem_read(pmem_read),
	.pmem_write(pmem_write),
	.pmem_address(pmem_address),
	.pmem_wdata(pmem_wdata),
	.pmem_resp(pmem_resp),
	.pmem_rdata(pmem_rdata)
);

endmodule