module main_FSM(
    input     clk,

    input [6:0]         op,
    
    output reg          AdrSrc,
                        MemWrite,
                        IRWrite,
    
    output reg [1:0]    ResultSrc,
    output reg [2:0]    ALUOp,
    output reg [1:0]    ALUSrcA,
                        ALUSrcB,
    output reg          RegWrite,
                        Branch, 
                        PCUpdate   
);

parameter   S0 = 0,
            S1 = 1,
            S2 = 2,
            S3 = 3,
            S4 = 4,
            S5 = 5,
            S6 = 6,
            S7 = 7,
            S8 = 8,
            S9 = 9,
            S10 = 10;

reg [3:0] current_state,next_state;

always @()



endmodule 