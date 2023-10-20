set_property PACKAGE_PIN Y9 [get_ports {GCLK}];  # "GCLK" 100M?

set_property PACKAGE_PIN F22 [get_ports {SW[0]}];  # "SW0"
set_property PACKAGE_PIN G22 [get_ports {SW[1]}];  # "SW1"
set_property PACKAGE_PIN H22 [get_ports {SW[2]}];  # "SW2"
set_property PACKAGE_PIN F21 [get_ports {SW[3]}];  # "SW3"
set_property PACKAGE_PIN H19 [get_ports {SW[4]}];  # "SW4"
set_property PACKAGE_PIN H18 [get_ports {SW[5]}];  # "SW5"
set_property PACKAGE_PIN H17 [get_ports {SW[6]}];  # "SW6"
set_property PACKAGE_PIN M15 [get_ports {SW[7]}];  # "SW7"

set_property PACKAGE_PIN T22 [get_ports {LD[0]}];  # "LD0"
set_property PACKAGE_PIN T21 [get_ports {LD[1]}];  # "LD1"
set_property PACKAGE_PIN U22 [get_ports {LD[2]}];  # "LD2"
set_property PACKAGE_PIN U21 [get_ports {LD[3]}];  # "LD3"
set_property PACKAGE_PIN V22 [get_ports {LD[4]}];  # "LD4"
set_property PACKAGE_PIN W22 [get_ports {LD[5]}];  # "LD5"
set_property PACKAGE_PIN U19 [get_ports {LD[6]}];  # "LD6"
set_property PACKAGE_PIN U14 [get_ports {LD[7]}];  # "LD7"

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN P18} [get_ports {ad3542_reset_x}];

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN B15} [get_ports {ldac_0}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN B22} [get_ports {spi_sdio0_0}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN B21} [get_ports {spi_sdio1_0}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN A21} [get_ports {spi_sclk_0}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN A22} [get_ports {spi_cs_0}];

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN C22} [get_ports {ldac_1}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN A19} [get_ports {spi_sdio0_1}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN A18} [get_ports {spi_sdio1_1}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN C17} [get_ports {spi_sclk_1}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN C18} [get_ports {spi_cs_1}];

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN D15} [get_ports {ldac_2}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN E21} [get_ports {spi_sdio0_2}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN F18} [get_ports {spi_sdio1_2}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN E18} [get_ports {spi_sclk_2}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN D21} [get_ports {spi_cs_2}];

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN L17} [get_ports {ldac_3}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN K19} [get_ports {spi_sdio0_3}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN M17} [get_ports {spi_sdio1_3}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN K20} [get_ports {spi_sclk_3}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN E15} [get_ports {spi_cs_3}];

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN A16} [get_ports {ldac_4}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN B16} [get_ports {spi_sdio0_4}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN A17} [get_ports {spi_sdio1_4}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN C15} [get_ports {spi_sclk_4}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN B17} [get_ports {spi_cs_4}];

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN G19} [get_ports {ldac_5}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN F19} [get_ports {spi_sdio0_5}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN E19} [get_ports {spi_sdio1_5}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN E20} [get_ports {spi_sclk_5}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN D22} [get_ports {spi_cs_5}];

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN J17} [get_ports {ldac_6}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN G15} [get_ports {spi_sdio0_6}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN G20} [get_ports {spi_sdio1_6}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN G21} [get_ports {spi_sclk_6}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN G16} [get_ports {spi_cs_6}];

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN N17} [get_ports {ldac_7}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN J20} [get_ports {spi_sdio0_7}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN N18} [get_ports {spi_sdio1_7}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN J16} [get_ports {spi_sclk_7}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN K21} [get_ports {spi_cs_7}];

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN N22} [get_ports {FMC_GPIO[0]}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN P22} [get_ports {FMC_GPIO[1]}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN M20} [get_ports {FMC_GPIO[2]}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN D18} [get_ports {FMC_GPIO[3]}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN M19} [get_ports {FMC_GPIO[4]}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN C19} [get_ports {FMC_GPIO[5]}];

set_property PACKAGE_PIN P17 [get_ports {FMC_LED}];

create_clock -period 10 -name GCLK [get_ports {GCLK}]

set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 35]];
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];
