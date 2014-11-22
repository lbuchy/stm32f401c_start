stm32f401c_start
================


# Building
SRC_DIR - The directory that this repo resides on your computer
BUILD_DIR - An arbitrary directory where you want the build output

    cd ${SRC_DIR}
    # Download stm32cubef4.zip from ST's website into ${SRC_DIR}
    # I couldn't find an easy link to it to embed into the build system for autodownload
    
    # Make a build directory
    mkdir ${BUILD_DIR}
    cd ${BUILD_DIR}
    
    # Generate makefiles
    cmake ${SRC_DIR}
    
    # make
    make

# Programming

Download openocd with your favourite package manager.

    pacaur -S openocd-git   # ARCH
    apt-get install openocd # UBUNTU
    
    cd ${SRC_DIR}
    # Start openocd (may need root if USB permissions not set up)
    openocd # Uses the openocd.cfg in the ${SRC_DIR}
    
Now OpenOCD is running.

    cd ${BUILD_DIR}
    # Start GDB
    ./toolchain/gcc-arm-none-eabi-4_8-2014q3/bin/arm-none-eabi-gdb cortex_hack.elf
    
    # You are greeted with a GDB prompt, connect to openocd
    (gdb) target remote localhost:3333
    
    # Program the device
    (gdb) load
    
    # Run the code
    (gdb) c
    
    
    
