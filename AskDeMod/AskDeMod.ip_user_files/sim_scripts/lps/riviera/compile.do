vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../AskDeMod.srcs/sources_1/ip/lps/cmodel" \
"../../../../AskDeMod.srcs/sources_1/ip/lps/lps_sim_netlist.v" \


vlog -work xil_defaultlib \
"glbl.v"

