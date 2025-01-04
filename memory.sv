module memory #(
parameter integer width_addr = 16,
parameter integer width_data = 16,
parameter integer is_initialize = 0,
parameter string init_file = "init.mem"
)
(
    input logic enable_in
    input logic is_write_in,
    input logic data_in,
    output logic data_out,
    input logic reset_in,
    input logic addr_in

);

logic [width_data-1:0] inner_memmory [2**width_addr -1:0] ; 

always_comb begin
if (reset_in==1'b1) begin
    if(is_initialize==0) begin
    generate
        integer i;
        for (i =0 ; i < (2**width_addr -1);i = i+1 ) begin
            inner_memmory[i] = 0;
        end
    endgenerate
    end
    else begin
        $readmemh(init_file,inner_memmory);
    end
end
else
begin
    if(is_write_in==1'b1) begin
        inner_memmory [addr_in] = data_in;
    end
    else begin
        data_out = inner_memmory [addr_in];
    end
end
end

endmodule