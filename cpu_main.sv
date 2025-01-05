// список соотвествия опператоров brainfuck и числового представления
// 0 - "+" , 1 - "-" , 2 - ">" , 3 - "<"
// 4 - "[" , 5 - "]" , 6 - "." , 7 - ","
module top (
    input logic [15:0] data_in,
    output logic [15:0] data_out,
    input logic clk_in,
    input logic reset_in
);

//СДЕЛАТЬ СБРОС ПОЛНЫЙ

logic [15:0] data_pointer;
logic [15:0] command_pointer;
logic [15:0] stack_pointer;

wire [15:0] data_mem_out, [15:0] data_mem_in;
wire [2:0] instr_mem_out;

memory data_mem #(
    parameter width_addr = 16,
    parameter width_data = 16,
    parameter  is_initialize = 0
) (
    .reset_in(reset_in),
    .addr_in(data_pointer),
    .is_write_in(is_write),
    .data_out(data_mem_out),
    .data_in(data_mem_in)
);

memory instr_mem #(
    parameter width_addr = 16,
    parameter width_data = 3,
    parameter  is_initialize = 0,
    parameter init_file = "init.mem"
) (
    .reset_in(reset_in),
    .addr_in(command_pointer),
    .is_write_in(1'b0),
    .data_out(instr_mem)
);

    
always @( posedge clk or posedge reset) begin
    if(reset) begin //сброс 
        data_pointer<=0;
        command_pointer<=0;
        stack_pointer<=0;
    end
    else 
    begin
        data_enable <=0;
    case (instr_mem_out)
        3'd0 : begin
            is_write_in <=1'b1;
            data_enable <=1'b1;
            data_mem_in <=data_mem_out+1'b1;
            data_pointer <= command_pointer +1'b1;
        end
        3'd1 : begin
            is_write_in <=1'b1;
            data_enable <=1'b1;
            data_mem_in <=data_mem_out-1'b1;
            data_pointer <= command_pointer +1'b1;
        end
        3'd2 :
        3'd3 :
        3'd4 :
        3'd5 :
        3'd6 :
        3'd7 :
        default: 
    endcase

        
    end
end
endmodule