###########################################################################
### Routing
###########################################################################

##In the layout window, click on Route -> Core Routing and Optimization

route_opt 

##Save the cel and report timing

save_mw_cel -as moest_route
write_def -output output/moest_route.def
report_placement_utilization > reports/moest_route_util.rpt
report_qor_snapshot > reports/moest_route_qor_snapshot.rpt
report_qor > reports/moest_route_qor.rpt
report_timing -max_paths 20 -delay max > reports/moest_route.setup.rpt
report_timing -max_paths 20 -delay min > reports/moest_route.hold.rpt

##POST ROUTE OPTIMIZATION STEPS

##Goto Layout Window, Route -> Verify Route


