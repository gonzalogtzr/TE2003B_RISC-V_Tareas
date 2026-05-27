module main_FSM(
    input               clk,
                        reset,

    input [6:0]         op,
    
    output reg          AdrSrc,
                        MemWrite,
                        IRWrite,
    
    output reg [1:0]    ResultSrc,
    output reg [1:0]    ALUOp,
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

always @(posedge clk or posedge reset) begin
    if(reset) 
        current_state <= S0;
    else 
        current_state <= next_state;
end

always @(*)begin
    case(current_state)
    S0: 
        next_state = S1;
    S1:
        case(op)
            7'b0100011: next_state = S2; // sw
            7'b0000011: next_state = S2; // lw
            7'b0110011: next_state = S6; // R-type
            7'b0010011: next_state = S8; // I-type
            7'b1101111: next_state = S9; //JAL
            7'b1100011: next_state = S10; // beq
            default: next_state = S0;
        endcase

    S2: begin
        if(op == 7'b0100011) 
            next_state = S5; // sw
        else 
            next_state = S3; // lw
    end
    S3: 
        next_state = S4;
    S4: 
        next_state = S0;
    S5:
        next_state = S0;
    S6:
        next_state = S7;
    S7:
        next_state = S0;
    S8:
        next_state = S7;
    S9:
        next_state = S7;
    S10:
        next_state = S0;
    endcase 
end

always @(*) 
begin
    AdrSrc = 0;
    MemWrite = 0;
    IRWrite = 0;
    ResultSrc = 0;
    ALUOp = 0;
    ALUSrcA = 0;
    ALUSrcB = 0;
    RegWrite = 0;
    Branch = 0;
    PCUpdate = 0;
    
    case(current_state)
    S0: 
    begin
        AdrSrc = 0;
        IRWrite = 1;
        ALUSrcA = 2'b00;
        ALUSrcB = 2'b10;
        ALUOp = 2'b00;
        ResultSrc = 2'b10;
        PCUpdate = 1;
    end
    S1:
    begin
        ALUSrcA = 2'b01;
        ALUSrcB = 2'b01;
        ALUOp = 2'b00;
    end
    S2:
    begin
        ALUSrcA = 2'b10;
        ALUSrcB = 2'b01;
        ALUOp = 2'b00;
    end
    S3:
    begin
        ResultSrc = 2'b00;
        AdrSrc = 1;
    end
    S4:
    begin
        RegWrite = 1;
        ResultSrc = 2'b01;
    end
    S5:
    begin
        MemWrite = 1;
        AdrSrc = 1;
        ResultSrc = 2'b00;
    end
    S6:
    begin
        ALUSrcA = 2'b10;
        ALUSrcB = 2'b00;
        ALUOp = 2'b10;
    end
    S7:
    begin
        RegWrite = 1;
        ResultSrc = 2'b00;
    end
    S8:
    begin
        ALUSrcA = 2'b10;
        ALUSrcB = 2'b01;
        ALUOp = 2'b10;
    end
    S9:
    begin
        ALUSrcA = 2'b01;
        ALUSrcB = 2'b10;
        ALUOp = 2'b00;
        ResultSrc = 2'b00;
        PCUpdate = 1;
    end
    S10:
    begin
        ALUSrcA = 2'b10;
        ALUSrcB = 2'b00;
        ALUOp = 2'b01;
        Branch = 1;
        ResultSrc = 2'b00;
    end
    endcase
end

endmodule 