###########################################################################
### Placement
###########################################################################

set_buffer_opt_strategy -effort high

set_tlu_plus_files -max_tluplus /packages/process_kit/generic/generic_32nm/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus -min_tluplus /packages/process_kit/generic/generic_32nm/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus  -tech2itf_map /packages/process_kit/generic/generic_32nm/SAED32_EDK/tech/star_rcxt/saed32nm_tf_itf_tluplus.map
 
place_opt -area_recovery -effort high -congestion
 
# When the design has congestion issues, you have following choices :
# place_opt -congestion -area_recovery -effort low # for medium effort congestion removal
# place_opt -effort high -congestion -area_recovery # for high eff cong removal


## What commands do you need when you want to optimize SCAN ?
# read_def < def file >
# check_scan_chain > $REPORTS_DIR/scan_chain_pre_ordering.rpt
# report_scan_chain >> $REPORTS_DIR/scan_chain_pre_ordering.rpt
# place_opt -effort low -optimize_dft


## What commands do you need when you want to reduce leakage power ?
# set_power_options -leakage true
# place_opt -effort low -area_recovery -power


# set_power_options -dynamic true -low_power_placement true
# read_saif –input < saif file >
# place_opt -effort low -area_recovery –power


save_mw_cel -as me_place

### Reports 

write_def -output output/me_place.def
report_placement_utilization > output/place_place_util.rpt
report_qor_snapshot > output/place_qor_snapshot.rpt
report_qor > output/place_qor.rpt

### Timing Report

report_timing -delay max -max_paths 20 > output/place.setup.rpt
#set_case_analysis 1 scanEn
report_timing -delay min -max_paths 20 > output/place.hold.rpt
