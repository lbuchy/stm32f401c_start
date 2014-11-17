
set( PKG_URL "file://${CMAKE_SOURCE_DIR}/stm32cubef4.zip" )
set( PKG_MD5 "52869aa3341045fbbe21cb1296a0a9d4" )

set( PKG_ARCHIVE_PREFIX "/STM32Cube_FW_F4_V1.3.0" )
set( PKG_EXTRACT_PREFIX "/STM32Cube" )

set( PKG_CMAKELISTS "" )

set( STM32CUBE_ROOT ${CMAKE_BINARY_DIR}${PKG_ARCHIVE_PREFIX}${PKG_EXTRACT_PREFIX} )

aux_source_directory(
        "${STM32CUBE_ROOT}/STM32F4xx_HAL_Driver/Src"
	STM32CUBE_HAL_SRC)

set( STM32CUBE_SRC ${STM32CUBE_SRC} 
	"${STM32CUBE_ROOT}/Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c"
	"${STM32CUBE_ROOT}/Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f401xc.s"
	${STM32CUBE_HAL_SRC} )

include_directories( "${STM32CUBE_ROOT}/Drivers/CMSIS/Device/ST/STM32F4xx/Include" )
include_directories( "${STM32CUBE_ROOT}/Drivers/CMSIS/Include" )
include_directories( "${STM32CUBE_ROOT}/STM32F4xx_HAL_Driver/Inc" )
