###########################################################################
### Placement
###########################################################################

set_buffer_opt_strategy -effort low

set_tlu_plus_files -max_tluplus /packages/process_kit/generic/generic_32nm/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus -min_tluplus /packages/process_kit/generic/generic_32nm/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus  -tech2itf_map /packages/process_kit/generic/generic_32nm/SAED32_EDK/tech/star_rcxt/saed32nm_tf_itf_tluplus.map


##Goto Layout Window , Placement ' Core Placement and Optimization .  A new window opens up as shown below . There are various options, you can click on what ever option you want and say ok. The tool will do the placement. Alternatively you can also run at the command at icc_shell . Below is example with congestion option.


place_opt -consider_scan
clock_opt -only_psyn

save_mw_cel -as moest_place

### Reports 

write_def -output output/moest_place.def
report_placement_utilization > reports/moest_place_util.rpt
report_qor_snapshot > reports/moest_place_qor_snapshot.rpt
report_qor > reports/moest_place_qor.rpt

### Timing Report

report_timing -delay max -max_paths 20 > reports/ME_place.setup.rpt
##set_case_analysis 1 scanEn
report_timing -delay min -max_paths 20 > reports/ME_place.hold.rpt
