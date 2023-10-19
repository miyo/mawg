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

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN T17} [get_ports {ad3542_reset_x}];

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN P17} [get_ports {ldac_0}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN P18} [get_ports {spi_sdio1_0}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN M21} [get_ports {spi_sdio0_0}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN M22} [get_ports {spi_sclk_0}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN T16} [get_ports {spi_cs_0}];

set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN N17} [get_ports {ldac_1}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN N18} [get_ports {spi_sdio1_1}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN J16} [get_ports {spi_sdio0_1}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN J17} [get_ports {spi_sclk_1}];
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN G15} [get_ports {spi_cs_1}];

create_clock -period 10 -name GCLK [get_ports {GCLK}]

set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 35]];
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];