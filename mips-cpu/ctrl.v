module ctrl(
    input [5:0] Op,
    input [5:0] Func,
    output [1:0] RegDst,
    output RegWrite,
    output ALUSrc,
    output MemWrite,
    output [1:0] MemtoReg,
     output [1:0] MemDst,
    output [1:0] ExtOp,
    output [3:0] ALUOp,
     output [2:0] nPCOp
    );
     
     reg [1:0] regdst;
    reg regwrite;
    reg alusrc;
    reg memwrite;
    reg [1:0] memtoreg;
     reg [1:0] memdst;
    reg [1:0] extop;
    reg [3:0] aluop;
     reg [2:0] npcop;
     
    parameter addu_f = 6'b100001,
                 subu_f = 6'b100011,
                 jr_f   = 6'b001000,
                 ori    = 6'b001101,
                 lw     = 6'b100011,
                 sw     = 6'b101011,
                 beq    = 6'b000100,
                 lui    = 6'b001111,
                 jal    = 6'b000011,
                 j      = 6'b000010;

    always @ (Op or Func) begin
        if(Op == 6'b0) begin
            case(Func)
                addu_f:begin
                            regdst    = 2'b01;
                            regwrite = 1;
                            alusrc    = 0;
                            memwrite = 0;
                            memtoreg = 2'b00;
                            memdst    = 2'bxx;
                            extop    = 2'bxx;
                            aluop    = 4'b0000;
                            npcop        = 3'b000;
                         end
                subu_f:begin
                            regdst    = 2'b01;
                            regwrite = 1;
                            alusrc    = 0;
                            memwrite = 0;
                            memtoreg = 2'b00;
                            memdst    = 2'bxx;
                            extop    = 2'bxx;
                            aluop    = 4'b0001;
                            npcop        = 3'b000;
                        end
                jr_f:    begin
                            regdst    = 2'bxx;
                            regwrite = 0;
                            alusrc    = 0;
                            memwrite = 0;
                            memtoreg = 2'b00;
                            memdst    = 2'bxx;
                            extop    = 2'bxx;
                            aluop    = 4'b0000;
                            npcop        = 3'b011;
                        end
                default:begin
                            regdst    = 2'b00;
                            regwrite = 0;
                            alusrc    = 0;
                            memwrite = 0;
                            memtoreg = 2'b00;
                            memdst    = 2'b00;
                            extop    = 2'b00;
                            aluop    = 4'b0000;
                            npcop        = 3'b000;
                        end
            endcase
        end
        else begin
            case(Op)
                ori:    begin
                            regdst    = 2'b00;
                            regwrite = 1;
                            alusrc    = 1;
                            memwrite = 0;
                            memtoreg = 2'b00;
                            memdst    = 2'bxx;
                            extop    = 2'b01;
                            aluop    = 4'b0010;
                            npcop        = 3'b000;
                        end
                lw:    begin
                            regdst    = 2'b00;
                            regwrite = 1;
                            alusrc    = 1;
                            memwrite = 0;
                            memtoreg = 2'b01;
                            memdst    = 2'b00;
                            extop    = 2'b00;
                            aluop    = 4'b0000;
                            npcop        = 3'b000;
                        end
                sw:    begin
                            regdst    = 2'bxx;
                            regwrite = 0;
                            alusrc    = 1;
                            memwrite = 1;
                            memtoreg = 2'b00;
                            memdst    = 2'b00;
                            extop    = 2'b00;
                            aluop    = 4'b0000;
                            npcop        = 3'b000;
                        end
                beq:    begin
                            regdst    = 2'bxx;
                            regwrite = 0;
                            alusrc    = 0;
                            memwrite = 0;
                            memtoreg = 2'b00;
                            memdst    = 2'bxx;
                            extop    = 2'b00;
                            aluop    = 4'b0001;
                            npcop        = 3'b001;
                        end
                lui:    begin
                            regdst    = 2'b00;
                            regwrite = 1;
                            alusrc    = 1;
                            memwrite = 0;
                            memtoreg = 2'b00;
                            memdst    = 2'bxx;
                            extop    = 2'b10;
                            aluop    = 4'b0000;
                            npcop        = 3'b000;
                        end
                jal:    begin
                            regdst    = 2'b10;
                            regwrite = 1;
                            alusrc    = 0;
                            memwrite = 0;
                            memtoreg = 2'b10;
                            memdst    = 2'bxx;
                            extop    = 2'b11;
                            aluop    = 4'b0000;
                            npcop        = 3'b010;
                        end
                j    :    begin
                            regdst    = 2'bxx;
                            regwrite = 0;
                            alusrc    = 1'bx;
                            memwrite = 0;
                            memtoreg = 2'bxx;
                            memdst    = 2'bxx;
                            extop    = 2'bxx;
                            aluop    = 4'bxxxx;
                            npcop        = 3'b010;
                        end
            endcase
        end
    end

    assign    RegDst     = regdst;
    assign    RegWrite = regwrite;
    assign    ALUSrc     = alusrc;
    assign    MemWrite = memwrite;
    assign    MemtoReg = memtoreg;
    assign    MemDst    = memdst;
    assign    ExtOp     = extop;
    assign    ALUOp     = aluop;
    assign    nPCOp     = npcop;


endmodule