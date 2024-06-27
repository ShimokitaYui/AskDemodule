vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../AskDeMod.srcs/sources_1/ip/lps/cmodel" \
"../../../../AskDeMod.srcs/sources_1/ip/lps/lps_sim_netlist.v" \


vlog -work xil_defaultlib \
"glbl.v"

