/*
@author Kouachi Corneille EKON
*/

`include "params.sv"

//`timescale 1ns/1ps

module tb;
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
    initial clk = 1;
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
        #30;

        // Test 1: Envoi d'une donnée valide avec grant
        data_i  = 32'hA5A5A5A5; // Exemple de donnée
        valid_i = 1;
        #10;
        valid_i = 0; // Désactiver valid_i après l'envoi de la donnée
        grant_i = 1; // Accorder la demande
        #10;

        // Test 2: Envoi d'une donnée valide sans grant
        data_i  = 32'h5A5A5A5A; // Exemple de donnée
        valid_i = 1;
        #10;
        valid_i = 0; // Désactiver valid_i après l'envoi de la donnée
        grant_i = 0; // Ne pas accorder la demande
        #10;

        // Test 3: Envoi d'une donnée invalide avec grant
        data_i  = 32'hFFFFFFFF; // Exemple de donnée
        valid_i = 0;
        #10;
        grant_i = 1; // Accorder la demande
        #10;

        // Test 4: Envoi d'une donnée invalide sans grant
        data_i  = 32'h00000000; // Exemple de donnée
        valid_i = 0;
        #10;
        grant_i = 0; // Ne pas accorder la demande
        #10;

        // Fin du test
        #20;
        $finish;


    end



endmodule
