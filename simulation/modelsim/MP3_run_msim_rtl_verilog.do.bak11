transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/lc3b_types.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/data_selector.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/comparator.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/icache_control.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/dcache_control.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/plus2.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/register.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/mux8.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/mux4.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/mux2.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/addr_splitter.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/word_replacer.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/cache_hierarchy.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/icache_datapath.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/dcache_datapath.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/arbiter.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/shift.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/cccomp.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/EX_MEM_register.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/branchAdder.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/regfile.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/signextend.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/gencc.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/array.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/alu.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/adj.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/MP3.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/pipeline_datapath.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/IF_ID_register.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/control_rom.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/ID_EX_register.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/MEM_MEMWB_register.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/zeroextShift.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/icache.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/dcache.sv}

vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/MP3_tb.sv}
vlog -sv -work work +incdir+/home/roros2/ece411/dat-cache {/home/roros2/ece411/dat-cache/physical_memory.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  MP3_tb

add wave *
view structure
view signals
run 200 ns
