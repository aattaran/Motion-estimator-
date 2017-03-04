
###### Synthesis Script #######

## Give the path to the verilog files and define the WORK directory
lappend search_path ./source
define_design_lib mo -path "mo"

## Define the library location

#source ../../lib_gen/lib_setup.tcl
source scripts/lib_container.tcl


## read the verilog files
analyze -library mo -format verilog PE.v
elaborate  -architecture verilog -library mo PE
## Check if design is consistent
check_design  > reports/synth_PE_check_design.rpt

## read the verilog files
analyze -library mo -format verilog comparator.v
elaborate   -architecture verilog -library mo comparator
## Check if design is consistent
check_design  > reports/synth_comparator_check_design.rpt

## read the verilog files
analyze -library mo -format verilog control.v
elaborate   -architecture verilog -library mo control
## Check if design is consistent
check_design  > reports/synth_control_check_design.rpt

## read the verilog files
analyze -library mo -format verilog motion_estimator.v
elaborate   -architecture verilog -library mo motion_estimator
## Check if design is consistent
check_design  > reports/synth_top_check_design.rpt



## Create Constraints 
create_clock clk -name clk -period 3.84
set_input_delay 1.0 [ remove_from_collection [all_inputs] clk ] -clock clk
set_output_delay 1.0 [all_outputs ] -clock clk
#set clock uncertainty 0.1 [get clocks clk]
#set ideal network [get ports clk]


set_max_area 0 

## You can use set flatten command also
# set_flatten 

## You can ungroup or flatten your design to get better area
#ungroup –all ##–flatten

## Compilation 

uniquify

## you can change medium to either low or high 

#compile_ultra –timing_high_effort_script

compile -area_effort high -map_effort high 

#-area_effort medium
## Below commands report area , cell, qor, resources, and timing information needed to analyze the design. 

  report_area > reports/synth_area.rpt
  report_design > reports/synth_design.rpt
  report_cell > reports/synth_cells.rpt
  report_qor  > reports/synth_qor.rpt
  report_resources > reports/synth_resources.rpt
  report_timing -max_paths 10 -delay max > reports/synth_timing.max.rpt
  report_timing -max_paths 10 -delay min > reports/synth_timing.min.rpt
  report_power -analysis_effort medium > reports/synth_power.rpt


## Dump out the constraints in an SDC file
  write_sdc const/ME.sdc -version 2.0

## Dump out the synthesized database and gate-level-netlist
  write -f ddc -hierarchy -output output/mes.ddc

  write -hierarchy -format verilog -output  output/mes_HDL.v

