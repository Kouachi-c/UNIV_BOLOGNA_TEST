# adding waves
add wave -position end  wave:/tb/dut/fifo_inst/clk
add wave -position end  wave:/tb/dut/fifo_inst/rst_n
add wave -position end  wave:/tb/dut/fifo_inst/push_data_i
add wave -position end  wave:/tb/dut/fifo_inst/push_valid_i
add wave -position end  wave:/tb/dut/fifo_inst/push_grant_o
add wave -position end  wave:/tb/dut/fifo_inst/pop_data_o
add wave -position end  wave:/tb/dut/fifo_inst/pop_valid_o
add wave -position end  wave:/tb/dut/fifo_inst/pop_grant_i

add wave -position end  wave:/tb/dut/fifo_inst/fifo_empty
add wave -position end  wave:/tb/dut/fifo_inst/fifo_full
add wave -position end  wave:/tb/dut/fifo_inst/read_ptr
add wave -position end  wave:/tb/dut/fifo_inst/write_ptr

add wave -position end  wave:/tb/dut/fifo_inst/fifo_we
add wave -position end  wave:/tb/dut/fifo_inst/fifo_re
