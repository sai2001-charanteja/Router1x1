vlib work
vdel -all
vlib work

vlog -f $1.list +acc
#vlog inheritance.sv

vsim work.top
add wave -r *
run -all
