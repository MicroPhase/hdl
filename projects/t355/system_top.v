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
  input   wire            CLK_50M,

  output  wire            status_led,
  input                   ref_clk1_p,
  input                   ref_clk1_n,
  input       [ 3:0]      rx_data_p,
  input       [ 3:0]      rx_data_n,
  output      [ 3:0]      tx_data_p,
  output      [ 3:0]      tx_data_n,
  output                  rx_sync_p,
  output                  rx_sync_n,
  output                  rx_os_sync_p,
  output                  rx_os_sync_n,
  input                   tx_sync_p,
  input                   tx_sync_n,
  input                   sysref_p,
  input                   sysref_n,


  output  wire            spi_csn_lmk04828        ,
  output  wire            spi_lmk04828_clk        ,
  output  wire            spi_lmk04828_sdio       ,
  input   wire            spi_lmk04828_miso       ,


  output wire             spi_adrv9009_csn        ,
  output wire             spi_adrv9009_clk        ,
  output wire             spi_adrv9009_sdio       ,
  input  wire             spi_adrv9009_miso       ,

  output wire             CLK_MAINSEL             ,
  input  wire             pps_ext                 ,
  input  wire             pps_int                 ,
  input  wire             gps_uart_rxd            ,
  output wire             gps_uart_txd            ,
  output wire             gps_rst_n               ,


  // inout                   ad9528_reset_b,
  inout                   lmk04828_sysref_req,
  inout                   adrv9009_tx1_enable,
  inout                   adrv9009_tx2_enable,
  inout                   adrv9009_rx1_enable,
  inout                   adrv9009_rx2_enable,
  inout                   adrv9009_test,
  inout                   adrv9009_reset_b,
  inout                   adrv9009_gpint,

  inout                   adrv9009_gpio_00,
  inout                   adrv9009_gpio_01,
  inout                   adrv9009_gpio_02,
  inout                   adrv9009_gpio_03,
  inout                   adrv9009_gpio_04,
  inout                   adrv9009_gpio_05,
  inout                   adrv9009_gpio_06,
  inout                   adrv9009_gpio_07,
  inout                   adrv9009_gpio_08,
  inout                   adrv9009_gpio_09,
  inout                   adrv9009_gpio_10,
  inout                   adrv9009_gpio_11,
  inout                   adrv9009_gpio_12,
  inout                   adrv9009_gpio_14,
  inout                   adrv9009_gpio_15,
  inout                   adrv9009_gpio_13,
  inout                   adrv9009_gpio_17,
  inout                   adrv9009_gpio_16,
  inout                   adrv9009_gpio_18
);

  // internal signals

  wire        [94:0]      gpio_i;
  wire        [94:0]      gpio_o;
  wire        [94:0]      gpio_t;
  wire        [20:0]      gpio_bd;
  wire        [ 2:0]      spi_csn;
  wire                    ref_clk0;
  wire                    ref_clk1;
  wire                    rx_sync;
  wire                    rx_os_sync;
  wire                    tx_sync;
  wire                    sysref;
  wire                    pl_clk2;
  wire                    bus_clk;
  wire                    clk_50m_bufg;
  wire                    pl_resetn1;
  wire      [1:0]         ref_src_sel;

  assign gpio_i[94:60] = gpio_o[94:60];
  assign gpio_i[31:21] = gpio_o[31:21];
  assign status_led = gpio_o[1];
  assign gps_rst_n = 1'b1;
  assign ref_src_sel = gpio_o[3:2];

  // instantiations

  IBUFDS_GTE4 i_ibufds_ref_clk1 (
    .CEB (1'd0),
    .I (ref_clk1_p),
    .IB (ref_clk1_n),
    .O (ref_clk1),
    .ODIV2 (ref_clk1_odiv2));

  BUFG_GT i_bufg_ref_clk (
    .I (ref_clk1_odiv2),
    .O (ref_clk1_bufg));

  OBUFDS i_obufds_rx_sync (
    .I (rx_sync),
    .O (rx_sync_p),
    .OB (rx_sync_n));

  OBUFDS i_obufds_rx_os_sync (
    .I (rx_os_sync),
    .O (rx_os_sync_p),
    .OB (rx_os_sync_n));


  IBUFDS i_ibufds_tx_sync (
    .I (tx_sync_p),
    .IB (tx_sync_n),
    .O (tx_sync));

  IBUFDS i_ibufds_sysref (
    .I (sysref_p),
    .IB (sysref_n),
    .O (sysref));

  BUFGCE #(
      .CE_TYPE("SYNC"),               // ASYNC, HARDSYNC, SYNC
      .IS_CE_INVERTED(1'b0),          // Programmable inversion on CE
      .IS_I_INVERTED(1'b0),           // Programmable inversion on I
      .SIM_DEVICE("ULTRASCALE_PLUS")  // ULTRASCALE, ULTRASCALE_PLUS
   )
   BUFGCE_inst (
      .O(clk_50m_bufg),   // 1-bit output: Buffer
      .CE(1'b1), // 1-bit input: Buffer enable
      .I(CLK_50M)    // 1-bit input: Buffer
   );


    wire ad9528_reset_b;
    // wire adrv9009_test;
    // wire adrv9009_gpio_09;
    // wire adrv9009_gpio_10;
    // wire adrv9009_gpio_11;
    // wire adrv9009_gpio_12;
    // wire adrv9009_gpio_14;
    // wire adrv9009_gpio_13;
    // wire adrv9009_gpio_17;
    // wire adrv9009_gpio_16;
    // wire adrv9009_gpio_18;
  ad_iobuf #(.DATA_WIDTH(28)) i_iobuf (
    .dio_t ({gpio_t[59:32]}),
    .dio_i ({gpio_o[59:32]}),
    .dio_o ({gpio_i[59:32]}),
    .dio_p ({ ad9528_reset_b,       // 59
              lmk04828_sysref_req,    // 58
              adrv9009_tx1_enable,  // 57
              adrv9009_tx2_enable,  // 56
              adrv9009_rx1_enable,  // 55
              adrv9009_rx2_enable,  // 54
              adrv9009_test,        // 53
              adrv9009_reset_b,     // 52
              adrv9009_gpint,       // 51
              adrv9009_gpio_00,     // 50
              adrv9009_gpio_01,     // 49
              adrv9009_gpio_02,     // 48
              adrv9009_gpio_03,     // 47
              adrv9009_gpio_04,     // 46
              adrv9009_gpio_05,     // 45
              adrv9009_gpio_06,     // 44
              adrv9009_gpio_07,     // 43
              adrv9009_gpio_15,     // 42
              adrv9009_gpio_08,     // 41
              adrv9009_gpio_09,     // 40
              adrv9009_gpio_10,     // 39
              adrv9009_gpio_11,     // 38
              adrv9009_gpio_12,     // 37
              adrv9009_gpio_14,     // 36
              adrv9009_gpio_13,     // 35
              adrv9009_gpio_17,     // 34
              adrv9009_gpio_16,     // 33
              adrv9009_gpio_18}));  // 32

  assign gpio_i[ 7: 0] = gpio_o[ 7: 0];
  // assign gpio_i[20: 8] = gpio_bd_i;
  // assign gpio_bd_o = gpio_o[ 7: 0];

  


  wire    [ 2:0]  spi0_csn;
  wire            spi0_miso;
  wire            spi0_mosi;
  wire            spi0_sclk;

  wire spi_lmk04828_miso_ibuf;
  wire spi_adrv9009_miso_ibuf;

  IBUF IBUF_lmk04828_miso (
      .O(spi_lmk04828_miso_ibuf),     // Buffer output
      .I(spi_lmk04828_miso)      // Buffer input (connect directly to top-level port)
    );

  IBUF IBUF_adrv9009_miso (
  .O(spi_adrv9009_miso_ibuf),     // Buffer output
  .I(spi_adrv9009_miso)      // Buffer input (connect directly to top-level port)
  );


  // assign          spi_csn_lmk04828 = (spi0_csn == 3'd1) ? 1'b0 : 1'b1;
  assign          spi_adrv9009_csn = (spi0_csn=='d6) ? 1'b0 : 1'b1;
  // assign          spi_lmk04828_clk = spi0_sclk;
  assign          spi_adrv9009_clk = spi0_sclk;
  // assign          spi_lmk04828_sdio = spi0_mosi;
  assign          spi_adrv9009_sdio = spi0_mosi;

  assign          spi0_miso = (spi0_csn == 3'd1) ? spi_lmk04828_miso_ibuf :
                              (spi0_csn == 3'd6) ? spi_adrv9009_miso_ibuf : 1'b0;

  // ref_src_sel:
  // 2'b00: internal 10M for driving lmk04828
  // 2'b01: gps 10M for driving lmk04828
  // 2'b10: external 10M reference clock for driving lmk04828
  // 2'b11: onboard 10M OCXO for driving lmk04828
  assign CLK_MAINSEL = (ref_src_sel==2'b11) ? 1'b1 : 1'b0; // CLK_MAINSEL
                                                           // 0: using external reference 10M clock for driving lmk04828
                                                           // 1: using internal 10M OCXO (not mount currently) for driving lmk04828
  lmk04828_config u_lmk04828_config(
      .clk   ( bus_clk   ),
      .rst   ( ~pl_resetn1   ),
      .ref_src (ref_src_sel),
      .sclk  ( spi_lmk04828_clk  ),
      .mosi  ( spi_lmk04828_sdio  ),
      .sync_n  ( spi_csn_lmk04828  )
  );

  system_wrapper i_system_wrapper (
    .pl_clk2(pl_clk2),
    .pl_resetn1(pl_resetn1),
    .bus_clk(bus_clk),
    .clk_50m(clk_50m_bufg),
    .dac_fifo_bypass (gpio_o[60]),
    .adc_fir_filter_active (gpio_o[61]),
    .dac_fir_filter_active (gpio_o[62]),
    .gpio_i (gpio_i),
    .gpio_o (gpio_o),
    .gpio_t (gpio_t),

    .gps_uart_rxd (gps_uart_rxd),
    .gps_uart_txd (gps_uart_txd),

    .rx_data_0_n (rx_data_n[0]),
    .rx_data_0_p (rx_data_p[0]),
    .rx_data_1_n (rx_data_n[1]),
    .rx_data_1_p (rx_data_p[1]),
    .rx_data_2_n (rx_data_n[2]),
    .rx_data_2_p (rx_data_p[2]),
    .rx_data_3_n (rx_data_n[3]),
    .rx_data_3_p (rx_data_p[3]),
    .rx_ref_clk_0 (ref_clk1),
    .rx_ref_clk_2 (ref_clk1),
    .rx_sync_0 (rx_sync),
    .rx_sync_2 (rx_os_sync),
    .rx_sysref_0 (sysref),
    .rx_sysref_2 (sysref),
    .spi0_sclk (spi0_sclk),
    .spi0_csn (spi0_csn),
    .spi0_miso (spi0_miso),
    .spi0_mosi (spi0_mosi),
    .spi1_sclk (),
    .spi1_csn (),
    .spi1_miso (1'b0),
    .spi1_mosi (),
    .tx_data_0_n (tx_data_n[0]),
    .tx_data_0_p (tx_data_p[0]),
    .tx_data_1_n (tx_data_n[1]),
    .tx_data_1_p (tx_data_p[1]),
    .tx_data_2_n (tx_data_n[2]),
    .tx_data_2_p (tx_data_p[2]),
    .tx_data_3_n (tx_data_n[3]),
    .tx_data_3_p (tx_data_p[3]),
    .tx_ref_clk_0 (ref_clk1),
    .tx_sync_0 (tx_sync),
    .tx_sysref_0 (sysref),
    .ref_clk (ref_clk1_bufg));

endmodule
