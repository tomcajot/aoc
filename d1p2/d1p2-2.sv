module d1p2 #(parameter INPUT_SIZE=4483) (input logic clk, rst_n, input logic [10:0] mem [0:INPUT_SIZE], output logic [14:0] out);

    typedef enum logic [1:0] { idle, counting, reducing, done } statetype;
    statetype state, next_state;

    logic [14:0] count;
    logic [10:0] word;
    assign word = mem[count];

    logic signed [19:0] value;
    logic signed [19:0] next_value;
    logic [14:0] password;
    assign out = password;

    always_ff @(posedge clk) begin
        if (!rst_n) state <= idle;
        else state <= next_state;
    end

    always_ff @(posedge clk) begin
        if (!rst_n) value <= 20'd50;
        else value <= next_value;
    end

    always_ff @(posedge clk) begin
        if (!rst_n || count > INPUT_SIZE) count <= 15'b0;
        if (state == counting) count <= count + 15'b1;
    end

    always_comb begin
        if (state == idle) next_value = 20'd50;
        if (state == counting) begin
            if (word[10] == 1'b1) begin
                next_value = value + word[9:0];
            end else begin
                next_value = value - word[9:0];
            end
        end
        if (state == reducing) begin
            if (value[19] == 1'b1) next_value = value + 20'sd100;
            else next_value = value - 20'sd100;
        end
    end

    always_comb begin
        case (state)
            idle: next_state = counting;
            counting: begin
                if (next_value > 20'sd99 || next_value[19] == 1'b1) next_state = reducing;
                else if (count >= INPUT_SIZE) next_state = done;
                else next_state = counting;
            end
            reducing: begin
                if (next_value > 20'sd99  || next_value[19] == 1'b1) next_state = reducing;
                else if (count >= INPUT_SIZE) next_state = done;
                else next_state = counting;
            end
            done: begin
                next_state = done;
            end
        endcase
    end

    always_ff @(posedge clk) begin
        if (!rst_n) password <= 15'b0;
        else begin

            if (state == counting && (value == 20'b0)) password <= password + 1'b1;
            if (state == counting && (value != 20'b0) && (value[19] != next_value[19])) password <= password + 1'b1;
            if ((state == reducing) && (value > 20'sd99 || value < -20'sd99) && (next_value != 20'b0)) password <= password + 1'b1;

        end
    end


endmodule