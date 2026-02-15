/*
@author Kouachi Corneille EKON
*/

`include "params.sv"

`timescale 1ns/1ps

module tb_top;
import fifo_package::*;

    // -------------------------
    // Signaux TB
    // -------------------------
    logic clk;
    logic rst_n;

    logic [DATA_WIDTH:0] data_i;   // adapte la largeur si besoin
    logic valid_i;
    logic grant_o;

    logic grant_i;
    logic [DATA_WIDTH:0] data_o;   // adapte la largeur si besoin
    logic valid_o;

    // -------------------------
    // DUT
    // -------------------------
    top_module dut (
        .clk     (clk),
        .rst_n   (rst_n),
        .data_i  (data_i),
        .valid_i (valid_i),
        .grant_o (grant_o),
        .grant_i (grant_i),
        .data_o  (data_o),
        .valid_o (valid_o)
    );

    // -------------------------
    // Horloge : 100 MHz
    // -------------------------
    initial clk = 0;
    always #5 clk = ~clk;

    // -------------------------
    // Reset
    // -------------------------
    initial begin
        rst_n = 0;
        #20;
        rst_n = 1;
    end

    // -------------------------
    // Stimulus
    // -------------------------
    initial begin
        // valeurs initiales
        data_i  = 0;
        valid_i = 0;
        grant_i = 0;

        // attendre la fin du reset
        @(posedge rst_n);
        @(posedge clk);

        // Envoi d’une donnée
        data_i  = 8'hA5;
        valid_i = 1;

        // attendre que le DUT accepte
        wait (grant_o == 1);
        @(posedge clk);

        valid_i = 0;

        // Simuler que le récepteur est prêt
        #20;
        grant_i = 1;
        @(posedge clk);
        grant_i = 0;

        // nouvelle donnée
        #20;
        data_i  = 8'h3C;
        valid_i = 1;

        wait (grant_o == 1);
        @(posedge clk);
        valid_i = 0;

        // fin simulation
        #100;
        $finish;
    end

    // -------------------------
    // Monitor debug
    // -------------------------
    initial begin
        $display("time | valid_i grant_o | valid_o grant_i | data_i data_o");
        $monitor("%4t |    %0b       %0b   |    %0b       %0b   |  %h    %h",
                 $time, valid_i, grant_o, valid_o, grant_i, data_i, data_o);
    end

endmodule
