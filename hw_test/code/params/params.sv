package fifo_package


    localparam DATA_WIDTH = 32;  // Width of the data bus 
    localparam DEPTH = 3;   // FIFO depth must be >= 2
    localparam ADDR_WIDTH = $clog2(DEPTH); // Address width based on FIFO depth

endpackage