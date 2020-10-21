library verilog;
use verilog.vl_types.all;
entity semaforo_vlg_check_tst is
    port(
        sema            : in     vl_logic;
        semb            : in     vl_logic;
        teste           : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end semaforo_vlg_check_tst;
