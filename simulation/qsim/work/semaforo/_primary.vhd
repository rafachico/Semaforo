library verilog;
use verilog.vl_types.all;
entity semaforo is
    port(
        clk             : in     vl_logic;
        sd              : in     vl_logic;
        se              : in     vl_logic;
        sema            : out    vl_logic;
        semb            : out    vl_logic;
        teste           : out    vl_logic_vector(31 downto 0)
    );
end semaforo;
