set_property  -dict {PACKAGE_PIN J12  IOSTANDARD LVCMOS33} [get_ports status_led]                                            ; ## 
# adrv9009

set_property  -dict {PACKAGE_PIN  R28 } [get_ports ref_clk1_n]                                              ; ## 
set_property  -dict {PACKAGE_PIN  R27 } [get_ports ref_clk1_p]                                              ; ## 
set_property  -dict {PACKAGE_PIN  T34 } [get_ports rx_data_n[0]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  T33 } [get_ports rx_data_p[0]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  P34 } [get_ports rx_data_n[1]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  P33 } [get_ports rx_data_p[1]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  N32 } [get_ports rx_data_n[2]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  N31 } [get_ports rx_data_p[2]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  M34 } [get_ports rx_data_n[3]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  M33 } [get_ports rx_data_p[3]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  T30 } [get_ports tx_data_n[0]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  T29 } [get_ports tx_data_p[0]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  R32 } [get_ports tx_data_n[1]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  R31 } [get_ports tx_data_p[1]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  P30 } [get_ports tx_data_n[2]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  P29 } [get_ports tx_data_p[2]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  M30 } [get_ports tx_data_n[3]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  M29 } [get_ports tx_data_p[3]]                                            ; ## 
set_property  -dict {PACKAGE_PIN  W11    IOSTANDARD LVDS} [get_ports rx_sync_n]                             ; ## 
set_property  -dict {PACKAGE_PIN  W12    IOSTANDARD LVDS} [get_ports rx_sync_p]                             ; ## 
set_property  -dict {PACKAGE_PIN  R13    IOSTANDARD LVDS} [get_ports rx_os_sync_n]                          ; ## 
set_property  -dict {PACKAGE_PIN  T13    IOSTANDARD LVDS} [get_ports rx_os_sync_p]                          ; ## 
set_property  -dict {PACKAGE_PIN  T10    IOSTANDARD LVDS DIFF_TERM_ADV TERM_100} [get_ports tx_sync_n]      ; ## 
set_property  -dict {PACKAGE_PIN  U10    IOSTANDARD LVDS DIFF_TERM_ADV TERM_100} [get_ports tx_sync_p]      ; ## 
set_property  -dict {PACKAGE_PIN  R8     IOSTANDARD LVDS DIFF_TERM_ADV TERM_100} [get_ports sysref_n]       ; ## 
set_property  -dict {PACKAGE_PIN  T8     IOSTANDARD LVDS DIFF_TERM_ADV TERM_100} [get_ports sysref_p]       ; ## 
set_property  -dict {PACKAGE_PIN  R12    IOSTANDARD LVDS DIFF_TERM_ADV TERM_100} [get_ports tx_sync_1_n]    ; ## 
set_property  -dict {PACKAGE_PIN  T12    IOSTANDARD LVDS DIFF_TERM_ADV TERM_100} [get_ports tx_sync_1_p]    ; ## 



set_property  -dict {PACKAGE_PIN  U6   IOSTANDARD LVCMOS18 PULLUP true} [get_ports spi_adrv9009_csn]  ; ##
set_property  -dict {PACKAGE_PIN  T7   IOSTANDARD LVCMOS18} [get_ports spi_adrv9009_clk]              ; ##
set_property  -dict {PACKAGE_PIN  V7    IOSTANDARD LVCMOS18} [get_ports spi_adrv9009_sdio]            ; ##
set_property  -dict {PACKAGE_PIN  V6    IOSTANDARD LVCMOS18} [get_ports spi_adrv9009_miso]            ; ##


# set_property  -dict {PACKAGE_PIN     IOSTANDARD LVCMOS18} [get_ports ad9528_reset_b]            ; ##
set_property  -dict {PACKAGE_PIN  E14   IOSTANDARD LVCMOS18} [get_ports lmk04828_sysref_req]      ; ##
set_property  -dict {PACKAGE_PIN  K13   IOSTANDARD LVCMOS18} [get_ports adrv9009_tx1_enable]      ; ##
set_property  -dict {PACKAGE_PIN  K15   IOSTANDARD LVCMOS18} [get_ports adrv9009_tx2_enable]      ; ##
set_property  -dict {PACKAGE_PIN  L15   IOSTANDARD LVCMOS18} [get_ports adrv9009_rx1_enable]      ; ##
set_property  -dict {PACKAGE_PIN  K14   IOSTANDARD LVCMOS18} [get_ports adrv9009_rx2_enable]      ; ##
set_property  -dict {PACKAGE_PIN  U8    IOSTANDARD LVCMOS18} [get_ports adrv9009_test]            ; ##
set_property  -dict {PACKAGE_PIN  V8    IOSTANDARD LVCMOS18} [get_ports adrv9009_reset_b]         ; ##
set_property  -dict {PACKAGE_PIN  U9    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpint]           ; ##



set_property  -dict {PACKAGE_PIN    N12    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_00]        ; ## 
set_property  -dict {PACKAGE_PIN    K10    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_01]        ; ##
set_property  -dict {PACKAGE_PIN    K16    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_02]        ; ##
set_property  -dict {PACKAGE_PIN    M13    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_03]        ; ##
set_property  -dict {PACKAGE_PIN    L12    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_04]        ; ##
set_property  -dict {PACKAGE_PIN    K12    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_05]        ; ##
set_property  -dict {PACKAGE_PIN    M15    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_06]        ; ##
set_property  -dict {PACKAGE_PIN    M14    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_07]        ; ##
set_property  -dict {PACKAGE_PIN    P10    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_08]        ; ##
set_property  -dict {PACKAGE_PIN    P9     IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_09]        ; ##
set_property  -dict {PACKAGE_PIN    N9     IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_10]        ; ##
set_property  -dict {PACKAGE_PIN    N8     IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_11]        ; ##
set_property  -dict {PACKAGE_PIN    M10    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_12]        ; ##
set_property  -dict {PACKAGE_PIN    N13    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_13]        ; ##
set_property  -dict {PACKAGE_PIN    M11    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_14]        ; ##
set_property  -dict {PACKAGE_PIN    P12    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_15]        ; ##
set_property  -dict {PACKAGE_PIN    L10    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_16]        ; ##
set_property  -dict {PACKAGE_PIN    L11    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_17]        ; ##
set_property  -dict {PACKAGE_PIN    L16    IOSTANDARD LVCMOS18} [get_ports adrv9009_gpio_18]        ; ##



set_property  -dict {PACKAGE_PIN  L19   IOSTANDARD LVCMOS33} [get_ports CLK_MAINSEL]                   ; ##
set_property -dict {PACKAGE_PIN E22 IOSTANDARD LVCMOS33} [get_ports pps_ext];
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33} [get_ports pps_int];

set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports gps_uart_rxd];
set_property -dict {PACKAGE_PIN D17 IOSTANDARD LVCMOS33} [get_ports gps_uart_txd];
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports gps_rst_n];

set_property  -dict {PACKAGE_PIN  J20   IOSTANDARD LVCMOS33 PULLUP true } [get_ports spi_csn_lmk04828] ; ##
set_property  -dict {PACKAGE_PIN  G21   IOSTANDARD LVCMOS33} [get_ports spi_lmk04828_clk]              ; ##
set_property  -dict {PACKAGE_PIN  F21   IOSTANDARD LVCMOS33} [get_ports spi_lmk04828_sdio]             ; ##
set_property  -dict {PACKAGE_PIN  B15   IOSTANDARD LVCMOS18} [get_ports spi_lmk04828_miso]             ; ##
# clocks

create_clock -name tx_ref_clk     -period  4.00 [get_ports ref_clk0_p];
create_clock -name rx_ref_clk     -period  4.00 [get_ports ref_clk1_p];
set_property  -dict {PACKAGE_PIN  F17   IOSTANDARD LVCMOS33} [get_ports CLK_50M]             ; ##

# For transceiver output clocks use reference clock 
# This will help autoderive the clocks correcly
set_case_analysis -quiet 0 [get_pins -quiet -hier *_channel/TXSYSCLKSEL[0]];
set_case_analysis -quiet 0 [get_pins -quiet -hier *_channel/TXSYSCLKSEL[1]];
set_case_analysis -quiet 1 [get_pins -quiet -hier *_channel/TXOUTCLKSEL[0]];
set_case_analysis -quiet 1 [get_pins -quiet -hier *_channel/TXOUTCLKSEL[1]];
set_case_analysis -quiet 0 [get_pins -quiet -hier *_channel/TXOUTCLKSEL[2]];

set_case_analysis -quiet 0 [get_pins -quiet -hier *_channel/RXSYSCLKSEL[0]];
set_case_analysis -quiet 0 [get_pins -quiet -hier *_channel/RXSYSCLKSEL[1]];
set_case_analysis -quiet 1 [get_pins -quiet -hier *_channel/RXOUTCLKSEL[0]];
set_case_analysis -quiet 1 [get_pins -quiet -hier *_channel/RXOUTCLKSEL[1]];
set_case_analysis -quiet 0 [get_pins -quiet -hier *_channel/RXOUTCLKSEL[2]];

create_generated_clock -name tx_div_clk     [get_pins i_system_wrapper/system_i/util_adrv9009_xcvr/inst/i_xch_0/i_gthe4_channel/TXOUTCLK];
create_generated_clock -name rx_div_clk     [get_pins i_system_wrapper/system_i/util_adrv9009_xcvr/inst/i_xch_0/i_gthe4_channel/RXOUTCLK];
create_generated_clock -name rx_os_div_clk  [get_pins i_system_wrapper/system_i/util_adrv9009_xcvr/inst/i_xch_2/i_gthe4_channel/RXOUTCLK];

create_clock -name spi0_clk      -period 40   [get_pins -hier */EMIOSPI0SCLKO];
create_clock -name spi1_clk      -period 40   [get_pins -hier */EMIOSPI1SCLKO];

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design];

set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets clk_50m_bufg];