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
add wave -noupdate /MP3_tb/dut/pipeline_dp/pc/load
add wave -noupdate /MP3_tb/dut/pipeline_dp/pc/in
add wave -noupdate /MP3_tb/dut/pipeline_dp/pc/out
add wave -noupdate /MP3_tb/dut/pipeline_dp/pc/data
add wave -noupdate -expand /MP3_tb/dut/pipeline_dp/regfile/data
add wave -noupdate /MP3_tb/dut/pipeline_dp/pc_mem_read
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/sel
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/a
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/b
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/c
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/e
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/f
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/d
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/g
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/h
add wave -noupdate /MP3_tb/dut/pipeline_dp/pcmux/out
add wave -noupdate /MP3_tb/dut/pipeline_dp/zx8_trap/in
add wave -noupdate /MP3_tb/dut/pipeline_dp/zx8_trap/out
add wave -noupdate /MP3_tb/dut/pipeline_dp/OP2Mux/sel
add wave -noupdate /MP3_tb/dut/pipeline_dp/OP2Mux/a
add wave -noupdate /MP3_tb/dut/pipeline_dp/OP2Mux/b
add wave -noupdate /MP3_tb/dut/pipeline_dp/OP2Mux/c
add wave -noupdate /MP3_tb/dut/pipeline_dp/OP2Mux/d
add wave -noupdate /MP3_tb/dut/pipeline_dp/OP2Mux/e
add wave -noupdate /MP3_tb/dut/pipeline_dp/OP2Mux/f
add wave -noupdate /MP3_tb/dut/pipeline_dp/OP2Mux/g
add wave -noupdate /MP3_tb/dut/pipeline_dp/OP2Mux/h
add wave -noupdate /MP3_tb/dut/pipeline_dp/OP2Mux/out
add wave -noupdate /MP3_tb/dut/pipeline_dp/tv8_out
add wave -noupdate /MP3_tb/dut/pipeline_dp/ALU/aluop
add wave -noupdate /MP3_tb/dut/pipeline_dp/ALU/a
add wave -noupdate /MP3_tb/dut/pipeline_dp/ALU/b
add wave -noupdate /MP3_tb/dut/pipeline_dp/ALU/f
add wave -noupdate /MP3_tb/dut/pipeline_dp/controlRom/opcode
add wave -noupdate -expand /MP3_tb/dut/pipeline_dp/controlRom/control_word
add wave -noupdate /MP3_tb/dut/pipeline_dp/storemux/sel
add wave -noupdate /MP3_tb/dut/pipeline_dp/storemux/a
add wave -noupdate /MP3_tb/dut/pipeline_dp/storemux/b
add wave -noupdate /MP3_tb/dut/pipeline_dp/storemux/c
add wave -noupdate /MP3_tb/dut/pipeline_dp/storemux/d
add wave -noupdate /MP3_tb/dut/pipeline_dp/storemux/f
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7485000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 285
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
WaveRestoreZoom {7453306 ps} {7715806 ps}
