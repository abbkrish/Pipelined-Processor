import lc3b_types::*;

module cache_hierarchy
(
	input clk,
	
	/* icache signals */
	input icache_read,
	input lc3b_word icache_address,
	output lc3b_word icache_rdata,
	output logic icache_resp,
	
	/* dcache signals */
    input dcache_read,
    input dcache_write,
    input lc3b_mem_wmask mem_byte_enable,
	input lc3b_word dcache_address,
    input lc3b_word dcache_wdata,
	output lc3b_word dcache_rdata,
	output logic dcache_resp,
	
	/* physical memory signals */
	output logic pmem_read,
	output logic pmem_write,
	output lc3b_word pmem_address,
	/* TODO TODO TODO CHANGE THIS TO L2 CACHE LINE YOU SON OF A BITCH (when we hook up L2)
		CHANGE PHYS MEM APPROPRIATELY */
	output lc3b_L1_line pmem_wdata,
	input pmem_resp,
	/* TODO TODO TODO CHANGE THIS TO L2 CACHE LINE YOU SON OF A BITCH (when we hook up L2)
		CHANGE PHYS MEM APPROPRIATELY */
	input lc3b_L1_line pmem_rdata
);

/* We'll use these later with the L2 cache */
logic L2inst_rd_req;
logic L2data_rd_req;
logic L2data_wr_req;
logic L2_resp;
logic arb_inst_resp;
logic arb_data_resp;
logic L2_read;
logic L2_write;

lc3b_word L2_address;
lc3b_word L2inst_address;
lc3b_word L2data_address;
lc3b_L1_line L2_rdata;
lc3b_L1_line L2_wdata;

/***************************************/
/* REMOVE THIS STUFF WHEN WE PUT IN L2 */
/***************************************/
assign pmem_read = L2_read;
assign L2_rdata = pmem_rdata;
assign L2_resp = pmem_resp;
assign pmem_wdata = L2_wdata;
assign pmem_write = L2_write;
assign pmem_address = L2_address;

icache ICACHE
(
	.clk(clk),
	
    .icache_read(icache_read),
	.icache_address(icache_address),
	.icache_rdata(icache_rdata),
	.icache_resp(icache_resp),
	
	.L2_resp(arb_inst_resp),
	.L2_rdata(L2_rdata),
	.L2_read(L2inst_rd_req),
	.L2_address(L2inst_address)
);
/*		A
		|
		|
		|
		|
		V		*/
arbiter ARBITER
(
	.clk(clk),
	.L2inst_rd_req(L2inst_rd_req),
	.L2inst_address(L2inst_address),
	.L2data_rd_req(L2data_rd_req),
	.L2data_wr_req(L2data_wr_req),
	.L2data_address(L2data_address),
	.L2_resp(L2_resp),				// The response from L2
	.arb_inst_resp(arb_inst_resp), 	// this gets sent to the instruction cache to let it know that its memory request is finished
	.L2_read(L2_read),
	.L2_write(L2_write),
	.arb_data_resp(arb_data_resp), 	// this gets sent to the data cache to let it know that its memory request is finished
	.L2_address(L2_address)
);
/*		A
		|
		|
		|
		|
		V		*/
dcache DCACHE
(
	.clk(clk),
	
    .dcache_read(dcache_read),
    .dcache_write(dcache_write),
    .mem_byte_enable(mem_byte_enable),
	.dcache_address(dcache_address),
    .dcache_wdata(dcache_wdata),
	.dcache_rdata(dcache_rdata),
	.dcache_resp(dcache_resp),
	
	.L2_resp(arb_data_resp),
	.L2_rdata(L2_rdata),
	.L2_read(L2data_rd_req),
	.L2_write(L2data_wr_req),
	.L2_address(L2data_address),
	.L2_wdata(L2_wdata)
);

endmodule: cache_hierarchy