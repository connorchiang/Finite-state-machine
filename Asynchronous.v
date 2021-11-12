`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Create Date: 11.04.2021 13:18:25
// Module Name: Asynchronous

//Lock sequence: 5,2,4,1,9.
// 
//////////////////////////////////////////////////////////////////////////////////

module Asynchronous(
    input k0,
    input k1,
    input k2,
    input k3,
    input k4,
    input k5,
    input k6,
    input k7,
    input k8,
    input k9,
    input Dr, 
    input Reset,
    output reg Qa, 
    output reg Qb, 
    output reg Qc, 
    output reg Qd, 
    output reg Qe,
    output Z
    );
    
    //Z active  when five-digit code entered correctly
    assign Z = Qe & ~Qd & ~Qc & ~Qb & ~Qa;

    //When any key pressed
    always @( k0 or k1 or k2 or k3 or k4 or k5 or k6 or k7 or k8 or k9  or Reset or Dr )  
        begin
            //Reset to idling state A(00000)
            if ( Reset == 1)
                begin
                    Qa <= 0;
                    Qb <= 0;
                    Qc <= 0;
                    Qd <= 0;
                    Qe <= 0;
                end
                
            //Door open switch causing a return to the idling state
            else if ( Dr == 1 )
                begin
                    Qa <= 0; 
                    Qb <= 0; 
                    Qc <= 0;
                    Qd <= 0;
                    Qe <= 0;
                end
                                
            else
                begin
                //Traisition equations
                    Qa <= (~Qe & ~Qd & ~Qc & ~Qb & ~k0 & ~k1 & ~k3 & ~k4 & ~k6 & ~k7 & ~k8 & ~k9) & ( (~Qa & ~k2 & k5) | (Qa & ~k5) );
                    Qb <= (~Qe & ~Qd & ~Qc & ~k0 & ~k1 & ~k3 & ~k5 & ~k6 & ~k7 & ~k8 & ~k9) & ( (~Qb & Qa & k2 & ~k4) | (Qb & ~Qa & ~k2) | ( Qb & ~k2 & ~k4) );
                    Qc <= (~Qe & ~Qd & ~Qa & ~k0 & ~k2 & ~k3 & ~k5 & ~k6 & ~k7 & ~k8 & ~k9) & ( (Qc & ~Qb & ~k4) | (Qc & ~k1 & ~k4) | ( ~Qc & Qb & ~k1 & k4) );
                    Qd <= (~Qe & ~Qb & ~Qa & ~k0 & ~k2 & ~k3 & ~k4 & ~k5 & ~k6 & ~k7 & ~k8) & ( (Qd & ~Qc & ~k1 ) | (Qd & ~k1 & ~k9) | (~Qd & Qc & k1 & ~k9 ) );
                    Qe <= (~Qc & ~Qb & ~Qa & ~k0 & ~k1 & ~k2 & ~k3 & ~k4 & ~k5 & ~k6 & ~k7 & ~k8) & ( (~Qe & Qd & k9) | (Qe & ~k9) );     
                end
        end
endmodule
