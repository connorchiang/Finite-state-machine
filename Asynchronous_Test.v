`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Create Date: 11.04.2021 13:18:25
// Module Name: Asynchronous_Test

//Lock sequence: 5,2,4,1,9.
// 
//////////////////////////////////////////////////////////////////////////////////


module Asynchronous_Test();
    reg k0;
    reg k1;
    reg k2; 
    reg k3; 
    reg k4; 
    reg k5; 
    reg k6; 
    reg k7; 
    reg k8; 
    reg k9;
    reg Reset;
    reg Dr;
     
    wire Qa;
    wire Qb;
    wire Qc; 
    wire Qd;
    wire Qe;
    wire Z;
    
    initial begin
    $display("correct five-digit code entered(5,2,4,1,9) and door open, state order: ABGCHDIEJFA ");
    $monitor ("Dr = %b, Qe = %b, Qd = %b, Qb = %b, Qc = %b, Qa = %b",Dr, Qe, Qd, Qc, Qb, Qa);
    //initialization of inputs( no key pressed )
        k0 <= 0;
        k1 <= 0; 
        k2 <= 0; 
        k3 <= 0; 
        k4 <= 0;
        k5 <= 0; 
        k6 <= 0;
        k7 <= 0; 
        k8 <= 0; 
        k9 <= 0;

        //correct five-digit code entered(5,2,4,1,9) and door open
        Dr = 0 ;
        //Reset
        Reset =1;
        #5 Reset = 0;
        //k5 pressed
        #5 k5 = 1;
        #5 k5 = 0; 
        //k2 pressed
        #5 k2 = 1; 
        #5 k2 = 0; 
        //k4 pressed
        #5 k4 = 1; 
        #5 k4 = 0; 
        //k1 pressed
        #5 k1 = 1; 
        #5 k1 = 0; 
        //k9 pressed
        #5 k9 = 1; 
        #5 k9 = 0; 
        //Door open switch, return to state A
        #5 Dr = 1 ;
        #200;
        $finish;
    end
    
    initial begin
    $display("wrong five-digit code entered(5,2,4,1,0), state order: ABGCHDIEA ");
    //after 100ns, close the door and enter wrong five-digit code (5,2,4,1,0)
        #100;
        Dr = 0 ;
        //k5 pressed
        #5 k5 = 1;
        #5 k5 = 0; 
        //k2 pressed
        #5 k2 = 1; 
        #5 k2 = 0; 
        //k4 pressed
        #5 k4 = 1; 
        #5 k4 = 0; 
        //k1 pressed
        #5 k1 = 1; 
        #5 k1 = 0; 
        //k0 pressed
        #5 k0 = 1; 
        #5 k0 = 0; 
        #100;
        $finish;
    end


    Asynchronous PhilModule1( .Dr(Dr), .Reset(Reset), .k0(k0), .k1(k1), .k2(k2), .k3(k3), .k4(k4), .k5(k5), .k6(k6), .k7(k7), .k8(k8),
.k9(k9), .Qa(Qa), .Qb(Qb), .Qc(Qc), .Qd(Qd), .Qe(Qe), .Z(Z) ); 

endmodule