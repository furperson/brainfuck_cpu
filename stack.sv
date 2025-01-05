module stack #(
    parameter integer width_data = 3,
    parameter integer N_words = 256;
) (
    input logic clk_in,
    input logic reset_in,
    input logic push_in,
    input logic pop_in,
     input logic [width_data-1:0] data_in,
    output logic [width_data-1:0] data_out
   
);

logic [width_data-1:0] inner_memmory [$clog2(N_words)-1:0] ;
logic [$clog2(N_words)-1:0] inner_pointer;

assign data_out = inner_memmory [inner_pointer];

always @( posedge clk or posedge reset_in) begin
    if (reset_in==1'b1) begin
    generate
        integer i;
        for (i =0 ; i < (N_words -1);i = i+1 ) begin
            inner_memmory[i] <= 0;
        end
    endgenerate
    end
    else begin
        if(push_in==1'b1) begin
            inner_memmory [inner_pointer] <= data_in;
            inner_pointer<=inner_pointer+1;
        end 
        else if(pop_in==1'b1) begin
        inner_pointer=inner_pointer+1;
        end
    end
    
end
    
endmodule