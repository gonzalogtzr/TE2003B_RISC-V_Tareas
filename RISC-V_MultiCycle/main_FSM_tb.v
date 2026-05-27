module main_FSM_tb();

reg clk, reset;
reg [6:0] op;
wire AdrSrc, MemWrite, IRWrite;
wire [1:0] ResultSrc, ALUOp, ALUSrcA,ALUSrcB;
wire RegWrite, Branch, PCUpdate;

main_FSM uut (
    .clk(clk),
    .reset(reset),
    .op(op),
    .AdrSrc(AdrSrc),
    .MemWrite(MemWrite),
    .IRWrite(IRWrite),
    .ResultSrc(ResultSrc),
    .ALUOp(ALUOp),
    .ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),
    .RegWrite(RegWrite),
    .Branch(Branch),
    .PCUpdate(PCUpdate)
);

initial begin
    forever #5 clk = ~clk; // 10 time units period
end


initial begin
    // Initialize signals
    clk = 0;
    reset = 1;
    op = 7'b0000000; // NOP

    // Release reset after some time
    #10 reset = 0;

    // Test sequence for different instructions
    #10 op = 7'b0110011; // R-type
    #10;
    wait(uut.current_state == uut.S0); // Wait for R-type state
    #10 op = 7'b0010011; // I-type
    #10;
    wait(uut.current_state == uut.S0); // Wait for R-type state
    #10 op = 7'b0000011; // Load
    #10;
    wait(uut.current_state == uut.S0); // Wait for R-type state
    #10 op = 7'b0100011; // Store
    #10;
    wait(uut.current_state == uut.S0); // Wait for R-type state
    #10 op = 7'b1100011; // Branch
    #10;
    wait(uut.current_state == uut.S0); // Wait for R-type state

    // Finish simulation after some time
    #100 $finish;
end

initial 
begin
    $monitor("Time: %0t | State: %0d | op: %b | AdrSrc: %b | MemWrite: %b | IRWrite: %b | ResultSrc: %b | ALUOp: %b | ALUSrcA: %b | ALUSrcB: %b | RegWrite: %b | Branch: %b | PCUpdate: %b", 
             $time, uut.current_state, op, AdrSrc, MemWrite, IRWrite, ResultSrc, ALUOp, ALUSrcA, ALUSrcB, RegWrite, Branch, PCUpdate);    
end

initial begin
    $dumpfile("main_FSM_tb.vcd");
    $dumpvars(0, main_FSM_tb);
end

endmodule 