/* Project name project configuration file	*/

#ifndef _project_config_h_
#define _project_config_h_

#include "lw_usb/GenericMacros.h"
#include "lw_usb/GenericTypeDefs.h"
#include "lw_usb/HID.h"
#include "lw_usb/MAX3421E.h"
#include "lw_usb/transfer.h"
#include "lw_usb/usb_ch9.h"
#include "lw_usb/USB.h"

/* USB constants */
/* time in milliseconds */
#define USB_SETTLE_TIME 					200         //USB settle after reset
#define USB_XFER_TIMEOUT					5000        //USB transfer timeout

#define USB_NAK_LIMIT 200
#define USB_RETRY_LIMIT 3

#endif // _project_config_h
