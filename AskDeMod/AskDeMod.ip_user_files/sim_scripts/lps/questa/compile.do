vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 "+incdir+../../../../AskDeMod.srcs/sources_1/ip/lps/cmodel" \
"../../../../AskDeMod.srcs/sources_1/ip/lps/lps_sim_netlist.v" \


vlog -work xil_defaultlib \
"glbl.v"

