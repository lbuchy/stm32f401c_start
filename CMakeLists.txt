project(cortex_hack C ASM)
cmake_minimum_required(VERSION 2.8)

set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake" )

include( ExternalProject )
include( "BuildPackage" )

BUILD_PACKAGE( "ArmBaremetalToolchain" )
BUILD_PACKAGE( "Stm32CubeF4" )

add_definitions(-DSTM32F401xC)
set( CMAKE_EXE_LINKER_FLAGS "-T ${CMAKE_SOURCE_DIR}/STM32F401CC_FLASH.ld" )

set(CMAKE_ASM_COMPILE_OBJECT "<CMAKE_ASM_COMPILER> ${ASM_COMPILE_FLAGS} <SOURCE> -o <OBJECT>")
#set( CMAKE_C_SOURCE_FILE_EXTENSIONS ".s" )
set(CMAKE_ASM_DEFS "")

link_directories( ${TOOLCHAIN_DIR}/lib )

include_directories(${CMAKE_SOURCE_DIR}/include)
aux_source_directory(${CMAKE_SOURCE_DIR}/src SRC_LIST)

file(GLOB
	INC_LIST
	${CMAKE_SOURCE_DIR}/include/*.h)

add_executable(
	${PROJECT_NAME}.elf 
	${SRC_LIST}
	${INC_LIST}
	${STM32CUBE_SRC})

target_link_libraries(${PROJECT_NAME}.elf c m)
