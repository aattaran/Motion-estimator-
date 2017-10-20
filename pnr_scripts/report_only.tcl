## Analysis reports

report_timing -from [all_inputs] -max_paths 20 -to [all_registers -data_pins] > reports/in2reg_timing.rpt
report_timing -from [all_register -clock_pins] -max_paths 20 -to [all_registers -data_pins]  > reports/reg2reg_timing.rpt
report_timing -from [all_registers -clock_pins] -max_paths 20 -to [all_outputs] > reports/reg2out_timing.rpt
report_timing -from [all_inputs] -to [all_outputs] -max_paths 20 > reports/in2reg_timing.rpt

#report_timing -from [all_registers -clock_pins] -to [all_registers -data_pins] -delay_type max  >> reports/timing.rpt

report_timing -from [all_registers -clock_pins] -to [all_registers -data_pins] -delay_type min  > reports/timing.rpt

report_timing -transition_time -capacitance -nets -input_pins -from [all_registers -clock_pins] -to [all_registers -data_pins]  > reports/timing.tran.cap.rpt


## Save outputs
save_session output/moest.session
