onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib lps_opt

do {wave.do}

view wave
view structure
view signals

do {lps.udo}

run -all

quit -force
