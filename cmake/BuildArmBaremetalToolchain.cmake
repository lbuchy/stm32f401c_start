set( PKG_URL
    "https://launchpad.net/gcc-arm-embedded/4.8/4.8-2014-q3-update/+download/gcc-arm-none-eabi-4_8-2014q3-20140805-linux.tar.bz2" )
set( PKG_MD5 "acc8c8ff45f8801e2155934214309a87" )

# Nothing to build!
set( PKG_CMAKELISTS "" )

set( PKG_EXTRACT_PREFIX "/toolchain" )
set( PKG_ARCHIVE_PREFIX "/gcc-arm-none-eabi-4_8-2014q3" )

set( TOOLCHAIN_DIR "${CMAKE_CURRENT_BINARY_DIR}${PKG_EXTRACT_PREFIX}${PKG_ARCHIVE_PREFIX}" )


set( CMAKE_SYSTEM_NAME "Generic" )
set( CMAKE_C_COMPILER "${TOOLCHAIN_DIR}/bin/arm-none-eabi-gcc" )
set( CMAKE_ASM_COMPILER "${TOOLCHAIN_DIR}/bin/arm-none-eabi-as" )
set( CMAKE_SHARED_LIBRARY_LINK_C_FLAGS )

#enable_language(ASM)

set( CMAKE_C_FLAGS
	"-mthumb -mcpu=cortex-m4 --specs=nosys.specs -ffunction-sections -Wall -std=gnu99 -mfloat-abi=soft -g3" )

