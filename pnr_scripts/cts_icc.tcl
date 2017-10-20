###########################################################################
### Clock Tree Synthesis
###########################################################################

##In the Layout window, click on "Clock ", you will see various options, you can set any of the options to run CTS. If you click on Clock ' Core CTS and Optimization

##Save the Cell and report timing
clock_opt -fix_hold_all_clocks

save_mw_cel -as moest_cts
report_placement_utilization > reports/moest_cts_util.rpt
report_qor_snapshot > reports/moest_cts_qor_snapshot.rpt
report_qor > reports/moest_cts_qor.rpt

report_timing -max_paths 20 -delay max > reports/moest_cts.setup.rpt
report_timing -max_paths 20 -delay min > reports/moest_cts.hold.rpt

## Save cel again and report paths
save_mw_cel -as moest_cts_opt
