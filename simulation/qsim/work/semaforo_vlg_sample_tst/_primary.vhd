library verilog;
use verilog.vl_types.all;
entity semaforo_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        sd              : in     vl_logic;
        se              : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end semaforo_vlg_sample_tst;
