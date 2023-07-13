// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2017 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module system_top (
  inout   [14:0]  ddr_addr,
  inout   [ 2:0]  ddr_ba,
  inout           ddr_cas_n,
  inout           ddr_ck_n,
  inout           ddr_ck_p,
  inout           ddr_cke,
  inout           ddr_cs_n,
  inout   [ 3:0]  ddr_dm,
  inout   [31:0]  ddr_dq,
  inout   [ 3:0]  ddr_dqs_n,
  inout   [ 3:0]  ddr_dqs_p,
  inout           ddr_odt,
  inout           ddr_ras_n,
  inout           ddr_reset_n,
  inout           ddr_we_n,

  inout           fixed_io_ddr_vrn,
  inout           fixed_io_ddr_vrp,
  inout   [53:0]  fixed_io_mio,
  inout           fixed_io_ps_clk,
  inout           fixed_io_ps_porb,
  inout           fixed_io_ps_srstb,

  inout           iic_scl,
  inout           iic_sda,

  input           rx_clk_in_p,
  input           rx_clk_in_n,
  input           rx_frame_in_p,
  input           rx_frame_in_n,
  input   [ 5:0]  rx_data_in_p,
  input   [ 5:0]  rx_data_in_n,
  output          tx_clk_out_p,
  output          tx_clk_out_n,
  output          tx_frame_out_p,
  output          tx_frame_out_n,
  output  [ 5:0]  tx_data_out_p,
  output  [ 5:0]  tx_data_out_n,

  output          enable,
  output          txnrx,

  inout           gpio_resetb,
  inout           gpio_sync,
  inout           gpio_en_agc,
  inout   [ 3:0]  gpio_ctl,
  inout   [ 7:0]  gpio_status,

  output          spi_csn,
  output          spi_clk,
  output          spi_mosi,
  input           spi_miso,

    // clock form vctcxo
  input  wire	 			      CLK_40MHz_FPGA  ,
  // PPS or 10 MHz (need to choose from SW)
  input  wire             PPS_IN          ,
  input  wire             CLKIN_10MHz     ,
  output wire             CLKIN_10MHz_REQ ,

  // Clock disciplining / LTC2630 controls
  output wire             CLK_40M_DAC_nSYNC,
  output wire             CLK_40M_DAC_SCLK ,
  output wire             CLK_40M_DAC_DIN ,

  output          rx1_band_sel_h,
  output          rx1_band_sel_l,
  output          tx1_band_sel_h,
  output          tx1_band_sel_l,
  output          rx2_band_sel_h,
  output          rx2_band_sel_l,
  output          tx2_band_sel_h,
  output          tx2_band_sel_l
  );

  // internal signals
  wire    [95:0]  gp_out_s;
  wire    [95:0]  gp_in_s;
  wire    [63:0]  gpio_i;
  wire    [63:0]  gpio_o;
  wire    [63:0]  gpio_t;
  wire    [85:0]  gp_out;
  wire   [85:0]  gp_in;
  // assignments
  assign gp_out[85:0] = gp_out_s[85:0];
  assign gp_in_s[95:86] = gp_out_s[95:86];
  assign gp_in_s[85: 0] = gp_in[85:0];

  assign gpio_i[31:0] = gpio_o[31:0];
  assign gpio_i[63:47] = gpio_o[63:47];


  assign rx1_band_sel_h = gpio_o[0];
  assign rx1_band_sel_l = gpio_o[1];
  assign tx1_band_sel_h = gpio_o[2];
  assign tx1_band_sel_l = gpio_o[3];
  assign rx2_band_sel_h = gpio_o[4];
  assign rx2_band_sel_l = gpio_o[5];
  assign tx2_band_sel_h = gpio_o[6];
  assign tx2_band_sel_l = gpio_o[7];


  wire            ref_sel;
  wire            ext_ref;
  wire            ext_ref_is_pps;
  wire            ext_ref_locked;
  wire            ppsgps;
  wire            ppsext;
  wire            pll_locked;

  assign ext_ref_is_pps = gpio_o[8];
  assign ref_sel = gpio_o[9];
  assign gpio_i[10] = ext_ref_locked;
  assign ppsext = ext_ref_is_pps ? PPS_IN : ref_sel ? PPS_IN : CLKIN_10MHz;

  ppsloop #(.DEVICE("LTC2630")
  )u_ppsloop(
      .xoclk   ( CLK_40MHz_FPGA   ),
      .ppsgps  ( ppsgps  ),
      .ppsext  ( ppsext  ),
      .refsel  ( 2'b00 ),
      .lpps    (     ),
      .is10meg (  ),
      .ispps   (  ),
      .reflck  ( ext_ref_locked ),
      .plllck  ( pll_locked ),
      .sclk    ( CLK_40M_DAC_SCLK    ),
      .mosi    ( CLK_40M_DAC_DIN    ),
      .sync_n  ( CLK_40M_DAC_nSYNC  ),
      .dac_dflt  ( 16'hBfff )
  );

  assign CLKIN_10MHz_REQ = 1'b1;

  ad_iobuf #(.DATA_WIDTH(15)) i_iobuf (
    .dio_t ( gpio_t[46:32]),
    .dio_i ( gpio_o[46:32]),
    .dio_o ( gpio_i[46:32]),
    .dio_p ({ gpio_resetb,        // 46:46
              gpio_sync,          // 45:45
              gpio_en_agc,        // 44:44
              gpio_ctl,           // 43:40
              gpio_status}));     // 39:32

  // instantiations

  system_wrapper i_system_wrapper (
    .ddr_addr (ddr_addr),
    .ddr_ba (ddr_ba),
    .ddr_cas_n (ddr_cas_n),
    .ddr_ck_n (ddr_ck_n),
    .ddr_ck_p (ddr_ck_p),
    .ddr_cke (ddr_cke),
    .ddr_cs_n (ddr_cs_n),
    .ddr_dm (ddr_dm),
    .ddr_dq (ddr_dq),
    .ddr_dqs_n (ddr_dqs_n),
    .ddr_dqs_p (ddr_dqs_p),
    .ddr_odt (ddr_odt),
    .ddr_ras_n (ddr_ras_n),
    .ddr_reset_n (ddr_reset_n),
    .ddr_we_n (ddr_we_n),
    .enable (enable),
    .fixed_io_ddr_vrn (fixed_io_ddr_vrn),
    .fixed_io_ddr_vrp (fixed_io_ddr_vrp),
    .fixed_io_mio (fixed_io_mio),
    .fixed_io_ps_clk (fixed_io_ps_clk),
    .fixed_io_ps_porb (fixed_io_ps_porb),
    .fixed_io_ps_srstb (fixed_io_ps_srstb),
    .gp_in_0 (gp_in_s[31:0]),
    .gp_in_1 (gp_in_s[63:32]),
    .gp_in_2 (gp_in_s[95:64]),
    .gp_in_3 (32'd0),
    .gp_out_0 (gp_out_s[31:0]),
    .gp_out_1 (gp_out_s[63:32]),
    .gp_out_2 (gp_out_s[95:64]),
    .gp_out_3 (),
    .gpio_i (gpio_i),
    .gpio_o (gpio_o),
    .gpio_t (gpio_t),
    .gps_pps (1'b0),
    .iic_main_scl_io (iic_scl),
    .iic_main_sda_io (iic_sda),
    .otg_vbusoc (1'b0),
    .rx_clk_in_n (rx_clk_in_n),
    .rx_clk_in_p (rx_clk_in_p),
    .rx_data_in_n (rx_data_in_n),
    .rx_data_in_p (rx_data_in_p),
    .rx_frame_in_n (rx_frame_in_n),
    .rx_frame_in_p (rx_frame_in_p),
    .spi0_clk_i (1'b0),
    .spi0_clk_o (spi_clk),
    .spi0_csn_0_o (spi_csn),
    .spi0_csn_1_o (),
    .spi0_csn_2_o (),
    .spi0_csn_i (1'b1),
    .spi0_sdi_i (spi_miso),
    .spi0_sdo_i (1'b0),
    .spi0_sdo_o (spi_mosi),
    .spi1_clk_i (1'b0),
    .spi1_clk_o (),
    .spi1_csn_0_o (),
    .spi1_csn_1_o (),
    .spi1_csn_2_o (),
    .spi1_csn_i (1'b1),
    .spi1_sdi_i (1'b0),
    .spi1_sdo_i (1'b0),
    .spi1_sdo_o (),
    .tdd_sync_i (1'b0),
    .tdd_sync_o (),
    .tdd_sync_t (),
    .tx_clk_out_n (tx_clk_out_n),
    .tx_clk_out_p (tx_clk_out_p),
    .tx_data_out_n (tx_data_out_n),
    .tx_data_out_p (tx_data_out_p),
    .tx_frame_out_n (tx_frame_out_n),
    .tx_frame_out_p (tx_frame_out_p),
    .txnrx (txnrx),
    .up_enable (gpio_o[47]),
    .up_txnrx (gpio_o[48]));

endmodule

// ***************************************************************************
// ***************************************************************************
