module Read_Encoder (
    input wire clk,
    input wire rst_n,

    input wire A,
    input wire B,

    output reg [1:0] dir
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dir = 2'b00;
        end else begin
            if      (A) dir = 2'b01; // horario
            else if (B) dir = 2'b10; // antihorario
            else        dir = 2'b00; // sem movimento
        end
    end
endmodule
