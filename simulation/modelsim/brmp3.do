onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MP3_tb/clk
add wave -noupdate /MP3_tb/mem_resp_a
add wave -noupdate /MP3_tb/mem_read_a
add wave -noupdate /MP3_tb/mem_write_a
add wave -noupdate /MP3_tb/mem_byte_enable_a
add wave -noupdate /MP3_tb/mem_address_a
add wave -noupdate /MP3_tb/mem_rdata_a
add wave -noupdate /MP3_tb/mem_wdata_a
add wave -noupdate /MP3_tb/mem_resp_b
add wave -noupdate /MP3_tb/mem_read_b
add wave -noupdate /MP3_tb/mem_write_b
add wave -noupdate /MP3_tb/mem_byte_enable_b
add wave -noupdate /MP3_tb/mem_address_b
add wave -noupdate /MP3_tb/mem_rdata_b
add wave -noupdate /MP3_tb/mem_wdata_b
add wave -noupdate /MP3_tb/clk
add wave -noupdate /MP3_tb/mem_resp_a
add wave -noupdate /MP3_tb/mem_read_a
add wave -noupdate /MP3_tb/mem_write_a
add wave -noupdate /MP3_tb/mem_byte_enable_a
add wave -noupdate /MP3_tb/mem_address_a
add wave -noupdate /MP3_tb/mem_rdata_a
add wave -noupdate /MP3_tb/mem_wdata_a
add wave -noupdate /MP3_tb/mem_resp_b
add wave -noupdate /MP3_tb/mem_read_b
add wave -noupdate /MP3_tb/mem_write_b
add wave -noupdate /MP3_tb/mem_byte_enable_b
add wave -noupdate /MP3_tb/mem_address_b
add wave -noupdate /MP3_tb/mem_rdata_b
add wave -noupdate /MP3_tb/mem_wdata_b
add wave -noupdate -radix hexadecimal /MP3_tb/clk
add wave -noupdate -radix hexadecimal /MP3_tb/dut/pipeline_dp/pc/out
add wave -noupdate -radix hexadecimal /MP3_tb/dut/pipeline_dp/pc/in
add wave -noupdate -radix hexadecimal -childformat {{{/MP3_tb/dut/pipeline_dp/regfile/data[7]} -radix hexadecimal} {{/MP3_tb/dut/pipeline_dp/regfile/data[6]} -radix hexadecimal} {{/MP3_tb/dut/pipeline_dp/regfile/data[5]} -radix hexadecimal} {{/MP3_tb/dut/pipeline_dp/regfile/data[4]} -radix hexadecimal} {{/MP3_tb/dut/pipeline_dp/regfile/data[3]} -radix hexadecimal} {{/MP3_tb/dut/pipeline_dp/regfile/data[2]} -radix hexadecimal} {{/MP3_tb/dut/pipeline_dp/regfile/data[1]} -radix hexadecimal} {{/MP3_tb/dut/pipeline_dp/regfile/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/MP3_tb/dut/pipeline_dp/regfile/data[7]} {-height 16 -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/regfile/data[6]} {-height 16 -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/regfile/data[5]} {-height 16 -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/regfile/data[4]} {-height 16 -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/regfile/data[3]} {-height 16 -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/regfile/data[2]} {-height 16 -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/regfile/data[1]} {-height 16 -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/regfile/data[0]} {-height 16 -radix hexadecimal}} /MP3_tb/dut/pipeline_dp/regfile/data
add wave -noupdate -radix hexadecimal -childformat {{/MP3_tb/dut/pipeline_dp/controlRom/control_word.load_pc -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.load_IF_ID -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.load_ID_EX -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.load_EX_MEM -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.load_MEM_WB -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.wbmux_sel -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.load_cc -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.mem_read -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.memAddr_mux_sel -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.mem_write -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.load_regfile -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.brmux_sel -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.pcmux_sel -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.storemux_sel -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.src2mux_sel -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.regfilemux_sel -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.alu_bmux_sel -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.alu_amux_sel -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.op2_sel -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.aluop -radix hexadecimal} {/MP3_tb/dut/pipeline_dp/controlRom/control_word.opcode -radix hexadecimal}} -subitemconfig {/MP3_tb/dut/pipeline_dp/controlRom/control_word.load_pc {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.load_IF_ID {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.load_ID_EX {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.load_EX_MEM {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.load_MEM_WB {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.wbmux_sel {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.load_cc {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.mem_read {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.memAddr_mux_sel {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.mem_write {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.load_regfile {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.brmux_sel {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.pcmux_sel {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.storemux_sel {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.src2mux_sel {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.regfilemux_sel {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.alu_bmux_sel {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.alu_amux_sel {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.op2_sel {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.aluop {-height 16 -radix hexadecimal} /MP3_tb/dut/pipeline_dp/controlRom/control_word.opcode {-height 16 -radix hexadecimal}} /MP3_tb/dut/pipeline_dp/controlRom/control_word
add wave -noupdate -radix hexadecimal /MP3_tb/dut/pipeline_dp/wbmux/sel
add wave -noupdate /MP3_tb/dut/pipeline_dp/control_word_EX_MEM
add wave -noupdate /MP3_tb/dut/pipeline_dp/control_word_ID_EX
add wave -noupdate -expand /MP3_tb/dut/pipeline_dp/control_word_MEM_WB
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/sel
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/a
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/b
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/c
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/d
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/f
add wave -noupdate /MP3_tb/dut/pipeline_dp/br_add/pc
add wave -noupdate /MP3_tb/dut/pipeline_dp/br_add/offset
add wave -noupdate /MP3_tb/dut/pipeline_dp/br_add/targetAddr
add wave -noupdate /MP3_tb/dut/pipeline_dp/brmux/sel
add wave -noupdate /MP3_tb/dut/pipeline_dp/brmux/a
add wave -noupdate /MP3_tb/dut/pipeline_dp/brmux/b
add wave -noupdate /MP3_tb/dut/pipeline_dp/brmux/c
add wave -noupdate /MP3_tb/dut/pipeline_dp/brmux/d
add wave -noupdate /MP3_tb/dut/pipeline_dp/brmux/f
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/clk
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/load
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/pc_out_IF_ID
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/sr1_out
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/sr2_out
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/op2_out
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/dest_IF_ID
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/offset11
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/control_word
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/branch_enable
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/sr1_out_ID_EX
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/sr2_out_ID_EX
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/dest_ID_EX
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/op2_out_ID_EX
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/offset11_ID_EX
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/offset9_ID_EX
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/control_word_ID_EX
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/branch_enable_ID_EX
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/pc_out_ID_EX
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/sr1_out_int
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/sr2_out_int
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/op2_out_int
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/branch_enable_int
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/control_word_int
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/pc_out_int
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/offset11_int
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/offset9_int
add wave -noupdate /MP3_tb/dut/pipeline_dp/ID_EX/dest_int
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/clk
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/load
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/control_word_ID_EX
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/pc_out_ID_EX
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/pc_out_EX_MEM
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/offset11_ID_EX
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/offset9_ID_EX
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/branch_enable_ID_EX
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/br_add_out
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/alu_out
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/sr1_out
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/dest_ID_EX
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/br_add_out_EX_MEM
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/alu_out_EX_MEM
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/offset11_EX_MEM
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/offset9_EX_MEM
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/dest_EX_MEM
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/control_word_EX_MEM
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/mem_wdata
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/mem_wdata_intermediate
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/br_add_out_intermediate
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/alu_out_intermediate
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/dest_intermediate
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/control_word_intermediate
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/offset9_intermediate
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/offset11_intermediate
add wave -noupdate /MP3_tb/dut/pipeline_dp/EX_MEM/pc_intermediate
add wave -noupdate /MP3_tb/dut/pipeline_dp/CCCOMP/a
add wave -noupdate /MP3_tb/dut/pipeline_dp/CCCOMP/cc
add wave -noupdate /MP3_tb/dut/pipeline_dp/CCCOMP/branch_enable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {139393 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 411
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {262500 ps}
