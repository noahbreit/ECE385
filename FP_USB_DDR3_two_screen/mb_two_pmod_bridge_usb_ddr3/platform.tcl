# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\Wildh\Documents\GitHub\ECE385\FP_USB_DDR3_two_screen\mb_two_pmod_bridge_usb_ddr3\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\Wildh\Documents\GitHub\ECE385\FP_USB_DDR3_two_screen\mb_two_pmod_bridge_usb_ddr3\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {mb_two_pmod_bridge_usb_ddr3}\
-hw {C:\Users\Wildh\Desktop\mb_two_pmod_bridge_usb_ddr3.xsa}\
-out {C:/Users/Wildh/Documents/GitHub/ECE385/FP_USB_DDR3_two_screen}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {empty_application}
platform generate -domains 
platform active {mb_two_pmod_bridge_usb_ddr3}
platform generate -quick
platform generate
platform clean
platform generate
