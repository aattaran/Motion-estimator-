###### Post Layout PrimeTime Script #######

## Define the library location
source scripts/lib_container.tcl
##set link_library   saed32lvt_ss0p7v125c.db 

##set target_library  saed32lvt_ss0p7v125c.db 

## read the extracted verilog netlist file
read_verilog output/me_extracted.v

## Set top module name
current_design motion_estimator

##Read extracted parasitics
read_parasitics -format SPEF output/me_extracted.spef.max

read_parasitics -format SPEF output/me_extracted.spef.min

read_sdf output/me_extracted.sdf
## Read in SDC from the ICC
read_sdc const/me_extracted.sdc

#set_case_analysis 0 scanEn
## Analysis reports

report_timing -from [all_registers -clock_pins] -to [all_registers -data_pins] -delay_type max  >> reports/post-timing-clock-data.max.rpt
#set_case_analysis 1 scanEn
report_timing -from [all_registers -clock_pins] -to [all_registers -data_pins] -delay_type min  > reports/post-timing-clock-data.min.rpt

report_timing -transition_time -capacitance -nets -input_pins -from [all_registers -clock_pins] -to [all_registers -data_pins] -delay_type max > reports/post-timing.tran.cap.max.rpt
report_timing -transition_time -capacitance -nets -input_pins -from [all_registers -clock_pins] -to [all_registers -data_pins] -delay_type min > reports/post-timing.tran.cap.min.rpt


## Save outputs
save_session output/ME.session

