`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Create Date: 11.04.2021 13:18:25
// Module Name: Synchronous_Test

//Repetitive state order: 2, 7, 13, 6, 12, 14, 4, 3, 8, 1, 10, 5. Z active on state: 7.
// 
//////////////////////////////////////////////////////////////////////////////////


module Synchronous_Test();
    reg JAM_A;
    reg JAM_B;
    reg JAM_C; 
    reg JAM_D; 
    reg JAM_Enable;
     
    wire Qa;
    wire Qb;
    wire Qc; 
    wire Qd;
    wire Z;
    
    reg Clk_Set;
    reg Clk_Reset;
    wire Clk_Q;
    
    //generate clock
    initial begin
       Clk_Set = 0;
       Clk_Reset = 1;
       forever 
           begin
               #5 Clk_Set <= ~Clk_Set;
                Clk_Reset <= ~Clk_Reset;
           end
    end

    initial begin
    $display("Start from state 2, repetive state order: 2, 7, 13, 6, 12, 14, 4, 3, 8, 1, 10, 5."); 
    $monitor ("JAM_Enable = %b, Qd = %b, Qb = %b, Qc = %b, Qa = %b",JAM_Enable, Qd, Qc, Qb, Qa);
    // initialization of States, start from state 2
        JAM_Enable <= 0;
        JAM_A <= 1; 
        JAM_B <= 1; 
        JAM_C <= 0;
        JAM_D <= 0;
        #7 JAM_Enable <= 1;
        #7 JAM_Enable <= 0;
        #300;
        $finish;
    end
    
    initial begin
    $display("Not allowed state 9 should transit to allowed state 4"); 
        // after 100ns, force into not allowed state 9(code:1101), will transit to allowed state 4(code: 0110)
        #100;
        JAM_Enable <= 0;
        JAM_A <= 1; 
        JAM_B <= 0; 
        JAM_C <= 1;
        JAM_D <= 1;
        #7 JAM_Enable <= 1;
        #7 JAM_Enable <= 0;
        #200;
        $finish;
    end
    
    initial begin
    $display("Not allowed state 9 should transit to allowed state 4"); 
        // after 200ns, force into not allowed state 11(code:1110), will transit to allowed state 2(code: 0011)
        #200;
        JAM_Enable <= 0;
        JAM_A <= 0; 
        JAM_B <= 1; 
        JAM_C <= 1;
        JAM_D <= 1;
        #7 JAM_Enable <= 1;
        #7 JAM_Enable <= 0;
        #100;
        $finish;
        end



    Synchronous PhilModule(
        .Clk_Set(Clk_Set), .Clk_Reset(Clk_Reset), .Clk_Q(Clk_Q), .JAM_A(JAM_A), .JAM_B(JAM_B), .JAM_C(JAM_C), .JAM_D(JAM_D), .JAM_Enable(JAM_Enable),
        .Qa(Qa), .Qb(Qb), .Qc(Qc), .Qd(Qd), .Z(Z)); 

endmodule
