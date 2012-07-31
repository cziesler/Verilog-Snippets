project_specify_options -format verilog -nocase -severity note -include /home/ccziesle/Verilog-Snippets/rtl/ -version 01
project_specify_options -format vhdl -severity note -version 93
project_specify_libraries -resource {STD {$LEDA_PATH/linux/resources/resource_93/STD}} -format vhdl -append
project_specify_libraries -resource {IEEE {$LEDA_PATH/linux/resources/resource_93/IEEE}} -format vhdl -append
project_specify_libraries -resource {SYNOPSYS {$LEDA_PATH/linux/resources/resource_93/SYNOPSYS}} -format vhdl -append
project_specify_libraries -resource {SNPS_EXT {$LEDA_PATH/linux/resources/resource_93/SNPS_EXT}} -format vhdl -append
project_specify_files -format verilog -work LEDA_WORK -file_extension {.v .ve .inc} {/home/ccziesle/Verilog-Snippets/rtl /home/ccziesle/Verilog-Snippets/rtl/counter.v /home/ccziesle/Verilog-Snippets/rtl/dff.v /home/ccziesle/Verilog-Snippets/rtl/full_adder.v /home/ccziesle/Verilog-Snippets/rtl/half_adder.v /home/ccziesle/Verilog-Snippets/rtl/sync.v}
project_specify_files -format vhdl -work LEDA_WORK -file_extension {.vhd .vhdl} /home/ccziesle/Verilog-Snippets/rtl
project_specify_libraries -format vhdl -resource {{IEEE {$LEDA_PATH/linux/resources/resource_93/IEEE}} {SNPS_EXT {$LEDA_PATH/linux/resources/resource_93/SNPS_EXT}} {STD {$LEDA_PATH/linux/resources/resource_93/STD}} {SYNOPSYS {$LEDA_PATH/linux/resources/resource_93/SYNOPSYS}} }
