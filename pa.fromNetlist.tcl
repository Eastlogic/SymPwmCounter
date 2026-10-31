
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name SymPwmCounter -dir "D:/ARCHIVE/XilinxISE_14_7/SymPwmCounter/planAhead_run_3" -part xc6slx16ftg256-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/ARCHIVE/XilinxISE_14_7/SymPwmCounter/SymPwmCounter.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/ARCHIVE/XilinxISE_14_7/SymPwmCounter} }
set_property target_constrs_file "SymPwmCounter.ucf" [current_fileset -constrset]
add_files [list {SymPwmCounter.ucf}] -fileset [get_property constrset [current_run]]
link_design
