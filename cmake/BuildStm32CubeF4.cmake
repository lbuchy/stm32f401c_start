
set( PKG_URL "file://${CMAKE_SOURCE_DIR}/stm32cubef4.zip" )
set( PKG_MD5 "52869aa3341045fbbe21cb1296a0a9d4" )

set( PKG_ARCHIVE_PREFIX "/STM32Cube_FW_F4_V1.3.0" )
set( PKG_EXTRACT_PREFIX "/STM32Cube" )

set( PKG_CMAKELISTS "" )

set( STM32CUBE_ROOT ${CMAKE_BINARY_DIR}${PKG_EXTRACT_PREFIX}${PKG_ARCHIVE_PREFIX} )

aux_source_directory(
        "${STM32CUBE_ROOT}/Drivers/STM32F4xx_HAL_Driver/Src"
	STM32CUBE_HAL_SRC)
file(GLOB
	STM32CUBE_HAL_INC_FILES
	"${STM32CUBE_ROOT}/Drivers/STM32F4xx_HAL_Driver/Inc/*.h")

set( STM32CUBE_SRC ${STM32CUBE_SRC} 
	"${STM32CUBE_ROOT}/Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c"
	"${STM32CUBE_ROOT}/Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f401xc.s"
	"${STM32CUBE_ROOT}/Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_core.c"
	"${STM32CUBE_ROOT}/Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ctlreq.c"
	"${STM32CUBE_ROOT}/Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ioreq.c"
	"${STM32CUBE_ROOT}/Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f401xc.s"
        # You will need to manually change this file to include "usbd_cdc.h" not "USBD_CDC.h"
        #"${STM32CUBE_ROOT}/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Src/usbd_cdc.c"
        "${STM32CUBE_ROOT}/Middlewares/ST/STM32_USB_Device_Library/Class/HID/Src/usbd_hid.c"
        # FreeRTOS
        "${STM32CUBE_ROOT}/Middlewares/Third_Party/FreeRTOS/Source/tasks.c"
        "${STM32CUBE_ROOT}/Middlewares/Third_Party/FreeRTOS/Source/timers.c"
        "${STM32CUBE_ROOT}/Middlewares/Third_Party/FreeRTOS/Source/queue.c"
        "${STM32CUBE_ROOT}/Middlewares/Third_Party/FreeRTOS/Source/list.c"
        "${STM32CUBE_ROOT}/Middlewares/Third_Party/FreeRTOS/Source/croutine.c"
        "${STM32CUBE_ROOT}/Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_1.c"
        "${STM32CUBE_ROOT}/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM3/port.c"
	${STM32CUBE_HAL_SRC} 
	${STM32CUBE_HAL_INC_FILES} )

include_directories( "${STM32CUBE_ROOT}/Drivers/CMSIS/Device/ST/STM32F4xx/Include" )
include_directories( "${STM32CUBE_ROOT}/Drivers/CMSIS/Include" )
include_directories( "${STM32CUBE_ROOT}/Drivers/STM32F4xx_HAL_Driver/Inc" )
include_directories( "${STM32CUBE_ROOT}/Middlewares/ST/STM32_USB_Device_Library/Core/Inc" )
include_directories( "${STM32CUBE_ROOT}/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc" )
include_directories( "${STM32CUBE_ROOT}/Middlewares/ST/STM32_USB_Device_Library/Class/HID/Inc" )
include_directories( "${STM32CUBE_ROOT}/Middlewares/Third_Party/FreeRTOS/Source/include" )
include_directories( "${STM32CUBE_ROOT}/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM3" )
