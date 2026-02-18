package fifo_package;

    localparam WIDTH       = 32             ;  // Width of the data bus
    localparam DATA_WIDTH  = WIDTH + 1      ;  // Width of the data bus including parity bit
    localparam DEPTH       = 5              ;   // FIFO depth must be >= 2
    localparam ADDR_WIDTH  = $clog2(DEPTH)  ; // Address width based on FIFO depth
    localparam PARITY_BIT  = "MSB"          ; // Parity bit position (MSB or LSB)
    localparam PARITY_TYPE = "EVEN"         ; // Parity type (EVEN or ODD)

endpackage