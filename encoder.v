module Encoder (
    input wire clk,
    input wire rst_n,
    input wire horario,
    input wire antihorario,
    output reg A,
    output reg B
);
    localparam [1:0]RESET = 2'b00;
    localparam [1:0]IDLE  = 2'b01;
    localparam [1:0]EXEC  = 2'b10;
    reg [1:0]estado, proximo_estado;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            estado = RESET;
        end else begin
            estado = proximo_estado;
        end
    end

    always @(estado) begin
        case (estado)
            RESET: begin
                proximo_estado = EXEC;
            end

            IDLE: begin
                proximo_estado = EXEC;
            end

            EXEC: begin
                if ( horario && antihorario ) proximo_estado = IDLE;
                else                          proximo_estado = EXEC;
            end
        endcase
    end

    always @(posedge clk) begin
        A = 0;
        B = 0;

        case (estado)
            RESET: begin
            end

            IDLE: begin
            end

            EXEC: begin
                if ( !(horario && antihorario) ) begin
                    if      (horario)     A = 1;
                    else if (antihorario) B = 1;
                end
            end
        endcase
    end
endmodule
