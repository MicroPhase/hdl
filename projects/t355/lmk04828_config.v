// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1_AR76780 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
// Date        : Fri Jan  3 14:19:55 2025
// Host        : wcc-B760 running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -mode synth_stub lmk04828_config.v
// Design      : lmk04828_config_clkin2_10m
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu15eg-ffvb1156-2-i
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module lmk04828_config(clk, rst, ref_src, sclk, mosi, sync_n)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,ref_src[1:0],sclk,mosi,sync_n" */;
  input clk;
  input rst;
  input [1:0]ref_src;
  output sclk;
  output mosi;
  output sync_n;
endmodule
