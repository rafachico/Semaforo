onerror {quit -f}
vlib work
vlog -work work semaforo.vo
vlog -work work semaforo.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.semaforo_vlg_vec_tst
vcd file -direction semaforo.msim.vcd
vcd add -internal semaforo_vlg_vec_tst/*
vcd add -internal semaforo_vlg_vec_tst/i1/*
add wave /*
run -all
