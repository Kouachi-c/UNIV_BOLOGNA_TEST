/*
@author Kouachi Corneille EKON
*/

`include "params.sv"

module tb;
import fifo_package::*;

    // Clock and reset signals
    reg clk;
    reg rst_n;

    // Input signals for the top module
    reg [DATA_WIDTH-1:0] data_i;
    reg valid_i;
    reg grant_i;

    // Output signals from the top module
    wire grant_o;
    wire [DATA_WIDTH-1:0] data_o;
    wire valid_o;

    // Instantiate the top module
    top_module dut (
        .clk(clk),
        .rst_n(rst_n),
        .data_i(data_i),
        .valid_i(valid_i),
        .grant_o(grant_o),
        .grant_i(grant_i),
        .data_o(data_o),
        .valid_o(valid_o)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        rst_n = 0;
        data_i = 0;
        valid_i = 0;
        grant_i = 0;

        // Apply reset
        #20 rst_n = 1;

        // Test case 1: Push data into FIFO and check outputs
        #10 data_i = 8'hA5; valid_i = 1; // Push data with parity bit (example)
        #10 valid_i = 0; // Deassert valid after push

        // Wait for some time to observe outputs
        #50;

        // Test case 2: Grant pop and check outputs
        #10 grant_i = 1; // Grant pop request
        #10 grant_i = 0; // Deassert grant after pop

        // Wait for some time to observe outputs
        #50;

        // Finish simulation
        $finish;
    end

endmodule