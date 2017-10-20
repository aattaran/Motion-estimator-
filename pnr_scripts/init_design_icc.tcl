###########################################################################
### Inital design setup
###########################################################################

##gui_start


source ../../lib_gen/lib_container.tcl


##dont use from lvt
##set_dont_use {saed32lvt_ss0p85v125c/AO22X*_LVT \ 
##               saed32lvt_ss0p85v125c/INVX1_LVT \ 
##              saed32lvt_ss0p85v125c/IBUFF*_LVT \
##	      saed32lvt_ss0p85v125c/AOI22X1_LVT}

##dont use from hvt
##set_dont_use {saed32hvt_ss0p85v125c/NAND2X*_HVT \ 
##               saed32hvt_ss0p85v125c/AOI21X1_HVT \ 
##              saed32hvt_ss0p85v125c/IBUFF*_HVT \
##	      saed32hvt_ss0p85v125c/MUX*_HVT}


set mw_logic0_net VSS
set mw_logic1_net VDD

set_tlu_plus_files -max_tluplus /packages/process_kit/generic/generic_32nm/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus -min_tluplus /packages/process_kit/generic/generic_32nm/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus  -tech2itf_map /packages/process_kit/generic/generic_32nm/SAED32_EDK/tech/star_rcxt/saed32nm_tf_itf_tluplus.map

create_mw_lib -technology /packages/process_kit/generic/generic_32nm/SAED32_EDK/tech/milkyway/saed32nm_1p9m_mw.tf -mw_reference_library {/packages/process_kit/generic/generic_32nm/EDK_updated_april2012/SAED32_EDK/lib/stdcell_lvt/milkyway/saed32nm_lvt_1p9m /packages/process_kit/generic/generic_32nm/EDK_updated_april2012/SAED32_EDK/lib/stdcell_hvt/milkyway/saed32nm_hvt_1p9m} moest_design.mw 

open_mw_lib moest_design.mw

read_verilog ../../dc_synth/synth_moest/output/moest_synth.v

current_design moest_top

uniquify_fp_mw_cel

link

read_sdc ../../dc_synth/synth_moest/const/ME.sdc

##read_def -verbose /Users/students/dennison/asic_flow_setup_orig/dc_synth/synth_ME/output/scan.def
##read_def -verbose /Users/students/dennison/asic_flow_setup_orig/dc_synth/synth_ME/output/scan.def

save_mw_cel -as moest_inital


