`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Create Date: 11.04.2021 13:18:25
// Module Name: Synchronous
//
//Repetitive state order: 2, 7, 13, 6, 12, 14, 4, 3, 8, 1, 10, 5. Z active on state: 7.
//
//////////////////////////////////////////////////////////////////////////////////


module Synchronous(
    input JAM_A, 
    input JAM_B, 
    input JAM_C, 
    input JAM_D, 
    input JAM_Enable,
    input Clk_Set,
    input Clk_Reset,
    output reg Qa, 
    output reg Qb, 
    output reg Qc, 
    output reg Qd, 
    output Clk_Q,
    output Z
    );
    
    //clock
    reg Clk;

    //Z active at state 7, Code: 0100
    assign Z = ~Qd & Qc & ~Qb & ~Qa;

    //De-bounced clock circuit 
    always @(Clk_Set or Clk_Reset) 
        if( (Clk_Set | Clk_Reset)  == 1 )
            begin
                Clk = ~Clk_Set | ( Clk_Reset & Clk );
            end
    assign Clk_Q = Clk;


    always @(posedge Clk)
        begin
            // input lines JAM_A to JAM_D to be clocked onto the output pins
            if (JAM_Enable == 1)
                begin
                    Qa <= JAM_A;
                    Qb <= JAM_B;
                    Qc <= JAM_C;
                    Qd <= JAM_D;
                end
            
            else
                //Transition equations
                begin
                    Qa <= (~Qb & ~Qa) | (~Qd & ~Qc & ~Qb) | (Qc & Qb & Qa) | (Qd & Qb);
                    Qb <= (~Qd & ~Qb) | (~Qb & Qa) | (Qc & Qb);
                    Qc <= (~Qd & ~Qc) | (Qd & Qa);
                    Qd <= (~Qd & ~Qb) | (~Qc & ~Qa);
                end
        end
endmodule