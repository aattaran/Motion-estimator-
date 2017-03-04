###########################################################################
### Floorplanning
###########################################################################


create_floorplan -control_type aspect_ratio -core_aspect_ratio 1 -core_utilization .75  -row_core_ratio 1  -start_first_row -left_io2core 5.0 -bottom_io2core 5.0 -right_io2core 5.0 -top_io2core 5.0 -keep_io_place -keep_macro_place

derive_pg_connection -power_net VDD -ground_net VSS
derive_pg_connection -power_net VDD -ground_net VSS -tie

##Create VSS ring

create_rectangular_rings  -nets  {VSS}  -left_offset 0.5  -left_segment_layer M6 -left_segment_width 1.0 -extend_ll -extend_lh -right_offset 0.5 -right_segment_layer M6 -right_segment_width 1.0 -extend_rl -extend_rh -bottom_offset 0.5  -bottom_segment_layer  M7 -bottom_segment_width 1.0 -extend_bl -extend_bh -top_offset 0.5 -top_segment_layer M7 -top_segment_width 1.0 -extend_tl -extend_th
 
## Create VDD Ring

create_rectangular_rings  -nets  {VDD}  -left_offset 1.8  -left_segment_layer M6 -left_segment_width 1.0 -extend_ll -extend_lh -right_offset 1.8 -right_segment_layer M6 -right_segment_width 1.0 -extend_rl -extend_rh -bottom_offset 1.8  -bottom_segment_layer M7 -bottom_segment_width 1.0 -extend_bl -extend_bh -top_offset 1.8 -top_segment_layer M7 -top_segment_width 1.0 -extend_tl -extend_th

## Creates Power Strap 

create_power_strap -nets { VDD } -layer M6 -direction vertical -width 3  
create_power_strap -nets { VSS } -layer M6 -direction vertical  -width 3

verify_drc

#set_case_analysis 1 CompStart
write_def -output output/me.def
save_mw_cel -as me

puts "floorplan done!!!!!"
