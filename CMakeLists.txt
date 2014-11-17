project(cortex_hack)
cmake_minimum_required(VERSION 2.8)
aux_source_directory(. SRC_LIST)
add_executable(${PROJECT_NAME} ${SRC_LIST})

set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake" )

include( ExternalProject )
include( "BuildPackage" )

# Create the download directory
set( DOWNLOAD_DIR ${CMAKE_CURRENT_BINARY_DIR}/dl )
file( MAKE_DIRECTORY
      ${DOWNLOAD_DIR})


BUILD_PACKAGE( "ArmBaremetalToolchain" )
BUILD_PACKAGE( "Stm32CubeF4" )

link_directories( ${TOOLCHAIN_DIR}/lib )

target_link_libraries(${PROJECT_NAME} c m)
