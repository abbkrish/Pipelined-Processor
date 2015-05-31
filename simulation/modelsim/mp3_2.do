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
add wave -noupdate /MP3_tb/dut/pipeline_dp/regfile/data
add wave -noupdate /MP3_tb/dut/pipeline_dp/pc_mem_read
add wave -noupdate /MP3_tb/dut/pipeline_dp/stall
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16197 ps} 0}
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
WaveRestoreZoom {0 ps} {262500 ps}
