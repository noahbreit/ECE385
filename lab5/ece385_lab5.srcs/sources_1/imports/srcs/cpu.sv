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
    output  logic [3:0]  ctrl_out,
    output  logic [15:0] data_bus_out,
    output  logic [15:0] pc_out,
    output  logic [15:0] ir_out,
    output  logic [4:0]  state_out,
    output  logic [15:0] marmux_out,
    output  logic [15:0] sr1_out,
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

logic [15:0] mar; 
logic [15:0] mdr;
logic [15:0] ir;
logic [15:0] pc;
logic ben;
logic ben_logic_out;
logic [2:0] NZP;
logic [2:0] NZP_ctrl;

// DATA BUS //
logic [15:0] data_bus;

// ALU //
logic [15:0] alu;
//logic [15:0] sr1_out;
logic [15:0] sr2_out;
logic [15:0] imm5_out;
//
assign imm5_out = 16'(signed'(ir[4:0]));

// MARMUX //
logic [15:0] marmux;
logic [15:0] addr1mux_in    [2];
logic [15:0] addr2mux_in    [4];
logic [15:0] imm6_out, imm9_out, imm11_out;
//
assign imm6_out = 16'(signed'(ir[5:0]));
assign imm9_out = 16'(signed'(ir[8:0]));
assign imm11_out = 16'(signed'(ir[10:0]));
//
logic [15:0] addr1mux_out;
logic [15:0] addr2mux_out;
//
assign marmux = (addr1mux_out + addr2mux_out);

// CONTROL SIGNALS //
logic [2:0]  drmux_in   [2];
logic [2:0]  sr1mux_in  [2];
logic [15:0] sr2mux_in  [2];
logic [15:0] pcmux_in   [3]; 
//
logic [2:0]  drmux_out;
logic [2:0]  sr1mux_out;
logic [15:0] sr2mux_out;
logic [15:0] pcmux_out;

// MEM INTERFACE //
logic [15:0] mdrmux_in  [2];
//
logic [15:0] mdrmux_out;
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

// DEBUG DEBUG
assign ir_out = ir;
assign pc_out = pc;
assign data_bus_out = data_bus;
assign marmux_out = marmux;
// DEBUG DEBUG


// REGISTERS // 
//
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
    .data_i(mdrmux_out),
    
    .data_q(mdr)
);

load_reg #(.DATA_WIDTH(16)) mar_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_mar),
    .data_i(data_bus),

    .data_q(mar)
);

load_reg #(.DATA_WIDTH(3)) NZP_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_cc),
    .data_i(NZP),

    .data_q(NZP_ctrl) 
);

load_reg #(.DATA_WIDTH(1)) ben_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_ben),
    .data_i(ben_logic_out),

    .data_q(ben) 
);

// CONTROL SIGNAL EXTERNAL LOGIC //
//
// DR MUX
assign drmux_in[0] = ir[11:9];
assign drmux_in[1] = 3'b111;
var_mux #(.WIDTH(3), .CHANNELS(2)) dr_mux (
    .din        (drmux_in),
    .sel        (drmux),
    
    .out        (drmux_out)
);

// SR1 MUX
assign sr1mux_in[0] = ir[11:9];
assign sr1mux_in[1] = ir[8:6];
var_mux #(.WIDTH(3), .CHANNELS(2)) sr1_mux (
    .din        (sr1mux_in),
    .sel        (sr1mux),
    
    .out        (sr1mux_out)
);

// SR2 MUX
assign sr2mux_in[0] = sr2_out;
assign sr2mux_in[1] = imm5_out;
var_mux #(.WIDTH(16), .CHANNELS(2)) sr2_mux (
    .din        (sr2mux_in),
    .sel        (sr2mux),               
    
    .out        (sr2mux_out)
);

// PC MUX
assign pcmux_in[0] = pc + 1;
assign pcmux_in[1] = data_bus;
assign pcmux_in[2] = marmux;
var_mux #(.WIDTH(16), .CHANNELS(3)) pc_mux (
    .din        (pcmux_in),
    .sel        (pcmux),               
    
    .out        (pcmux_out)
);

// MDR MUX
assign mdrmux_in[0] = data_bus;
assign mdrmux_in[1] = mem_rdata;
var_mux #(.WIDTH(16), .CHANNELS(2)) mdr_mux (
    .din        (mdrmux_in),
    .sel        (mio_en),               
    
    .out        (mdrmux_out)
);

// ADDR1 MUX
assign addr1mux_in[0] = pc;
assign addr1mux_in[1] = sr1_out;
var_mux #(.WIDTH(16), .CHANNELS(2)) addr1_mux (
    .din        (addr1mux_in),
    .sel        (addr1mux),               
    
    .out        (addr1mux_out)
);

// ADDR2 MUX
assign addr2mux_in[0] = '0;
assign addr2mux_in[1] = imm6_out;
assign addr2mux_in[2] = imm9_out;
assign addr2mux_in[3] = imm11_out;
var_mux #(.WIDTH(16), .CHANNELS(4)) addr2_mux (
    .din        (addr2mux_in),
    .sel        (addr2mux),               
    
    .out        (addr2mux_out)
);

// LARGE MODULES -- REG_FILE, ALU, BUS // 
//
// REG FILE
lc3_reg_file reg_file (
    .clk        (clk),
    .reset      (reset),
    
    .din        (data_bus),
    
    .dr         (drmux_out),
    .load       (ld_reg),
    .sr2_in     (ir[2:0]),
    .sr1_in     (sr1mux_out),
    
    .sr2_out    (sr2_out),
    .sr1_out    (sr1_out)
);

// ALU
ALU alu_module (
    .A          (sr1_out),
    .B          (sr2mux_out),
    
    .ALUK       (aluk),
    
    .ALU_out    (alu)
);

// BUS
cpu_bus lc3_bus (
    .gate_pc        (gate_pc),
    .gate_mdr       (gate_mdr),
    .gate_alu       (gate_alu), 
    .gate_marmux    (gate_marmux),
    
    .pc_in          (pc),   
    .mdr_in         (mdr),
    .alu_in         (alu),
    .marmux_in      (marmux),
    
    .ctrl_out       (ctrl_out),
    .out            (data_bus)
);

//NZP logic
NZP_logic NZP_logic (
    .data_input     (data_bus),
    
    .N_Z_P_val      (NZP)
);
    
//ben logic 
ben_logic ben_logic(
    .ir_in          (ir[11:9]),
    .nzp_in         (NZP_ctrl),
    
    .ben            (ben_logic_out)
);

// # NOTE # INTERAL PC LOGIC
//always_comb
//begin
//    case(pcmux)     // TODO ENUMERATE!!
//        2'b00:
//            pcmux_out = pc + 1;
//        default:
//            pcmux_out = pc;
//    endcase
//end

// # NOTE # INTERNAL MIO LOGIC
//always_comb
//begin
//    case(mio_en)    // TODO ENUMERATE!!
//        1'b0:
//            mdr_in = mem_rdata;
//        1'b1:
//            mdr_in = data_bus;
//    endcase
//end

endmodule