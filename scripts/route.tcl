###########################################################################
### Routing
###########################################################################

##In the layout window, click on Route -> Core Routing and Optimization

route_opt 

##Save the cel and report timing

save_mw_cel -as me_route
write_def -output output/me_route.def
write_verilog -output output/me_route.v

report_placement_utilization > reports/route_place_util.rpt
report_qor_snapshot > reports/route_qor_snapshot.rpt
report_qor > reports/route_qor.rpt
report_timing -max_paths 20 -delay max > reports/route.setup.rpt
report_timing -max_paths 20 -delay min > reports/route.hold.rpt

##POST ROUTE OPTIMIZATION STEPS

##Goto Layout Window, Route -> Verify Route
verify_zrt_route


