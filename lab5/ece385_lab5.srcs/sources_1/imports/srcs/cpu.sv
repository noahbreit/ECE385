//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    
// Design Name:    ECE 385 Given Code - SLC-3 core
// Module Name:    SLC3
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 09-22-2015 
//    Revised 06-09-2020
//	  Revised 03-02-2021
//    Xilinx vivado
//    Revised 07-25-2023 
//    Revised 12-29-2023
//------------------------------------------------------------------------------

// ## NOAH NOTES :: TODO FOR WEEK ONE DEMO ##

module cpu (
    input   logic        clk,
    input   logic        reset,

    input   logic        run_i,
    input   logic        continue_i,
    output  logic [15:0] hex_display_debug,
    output  logic [15:0] led_o,
    
    // DEBUG DEBUG
    output  logic [15:0] data_bus,
    output  logic [4:0]  state_out,
    output  logic [15:0] pc,
    output  logic [15:0] ir,
    // DEBUG DEBUG
   
    input   logic [15:0] mem_rdata,
    output  logic [15:0] mem_wdata,
    output  logic [15:0] mem_addr,
    output  logic        mem_mem_ena,
    output  logic        mem_wr_ena
);


// Internal connections
logic ld_mar; 
logic ld_mdr; 
logic ld_ir; 
logic ld_ben; 
logic ld_cc; 
logic ld_reg; 
logic ld_pc; 
logic ld_led;

logic gate_pc;
logic gate_mdr;
logic gate_alu; 
logic gate_marmux;

logic [1:0] pcmux;
logic       drmux;
logic       sr1mux;
logic       sr2mux;
logic       addr1mux;
logic [1:0] addr2mux;
logic [1:0] aluk;
logic       mio_en;

logic [15:0] mdr_in;
logic [15:0] mar; 
logic [15:0] mdr;
//logic [15:0] ir;
//logic [15:0] pc;
logic ben;

// DEMO1 
//logic [15:0] data_bus;
logic [15:0] pcmux_out;
// 

assign mem_addr = mar;
assign mem_wdata = mdr;

// State machine, you need to fill in the code here as well
// .* auto-infers module input/output connections which have the same name
// This can help visually condense modules with large instantiations, 
// but can also lead to confusing code if used too commonly
control cpu_control (
    .*
);


assign led_o = ir;
assign hex_display_debug = ir;


load_reg #(.DATA_WIDTH(16)) ir_reg (
    .clk    (clk),
    .reset  (reset),

    .load   (ld_ir),
    .data_i (data_bus),

    .data_q (ir)
);

load_reg #(.DATA_WIDTH(16)) pc_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_pc),
    .data_i(pcmux_out),

    .data_q(pc)
);

load_reg #(.DATA_WIDTH(16)) mdr_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_mdr),
    .data_i(mdr_in),
    
    .data_q(mdr)
);

load_reg #(.DATA_WIDTH(16)) mar_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_mar),
    .data_i(data_bus),

    .data_q(mar)
);

cpu_bus lc3_bus (
    .gate_pc        (gate_pc),
    .gate_mdr       (gate_mdr),
    .gate_alu       (gate_alu), 
    .gate_marmux    (gate_marmux),
    
    .pc_in          (pc),   
    .mdr_in         (mdr),
    .alu_in         (),     // TODO
    .marmux_in      (),     // TODO
    
    .out            (data_bus)
);

// # NOTE # INTERAL PC LOGIC
always_comb
begin
    case(pcmux)     // TODO ENUMERATE!!
        00:
            pcmux_out = pc + 1;
        default:
            pcmux_out = pc;
    endcase
end

// # NOTE # INTERNAL MIO LOGIC
always_comb
begin
    case(mio_en)    // TODO ENUMERATE!!
        0:
            mdr_in = data_bus;
        1:
            mdr_in = mem_rdata;
    endcase
end


endmodule