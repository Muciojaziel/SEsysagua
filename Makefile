# This file was automagically generated by mbed.org. For more information, 
# see http://mbed.org/handbook/Exporting-to-GCC-ARM-Embedded

###############################################################################
# Boiler-plate

# cross-platform directory manipulation
ifeq ($(shell echo $$OS),$$OS)
    MAKEDIR = if not exist "$(1)" mkdir "$(1)"
    RM = rmdir /S /Q "$(1)"
else
    MAKEDIR = '$(SHELL)' -c "mkdir -p \"$(1)\""
    RM = '$(SHELL)' -c "rm -rf \"$(1)\""
endif

OBJDIR := BUILD
# Move to the build directory
ifeq (,$(filter $(OBJDIR),$(notdir $(CURDIR))))
.SUFFIXES:
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
MAKETARGET = '$(MAKE)' --no-print-directory -C $(OBJDIR) -f '$(mkfile_path)' \
		'SRCDIR=$(CURDIR)' $(MAKECMDGOALS)
.PHONY: $(OBJDIR) clean
all:
	+@$(call MAKEDIR,$(OBJDIR))
	+@$(MAKETARGET)
$(OBJDIR): all
Makefile : ;
% :: $(OBJDIR) ; :
clean :
	$(call RM,$(OBJDIR))

else

# trick rules into thinking we are in the root, when we are in the bulid dir
VPATH = ..

# Boiler-plate
###############################################################################
# Project settings

PROJECT := MQTT_Hello_ENC28J60


# Project settings
###############################################################################
# Objects and Paths

OBJECTS += HC-SR04/HCSR04.o
OBJECTS += MQTTClient/MQTTClient.o
OBJECTS += UIPEthernet/Dhcp.o
OBJECTS += UIPEthernet/Dns.o
OBJECTS += UIPEthernet/UIPClient.o
OBJECTS += UIPEthernet/UIPEthernet.o
OBJECTS += UIPEthernet/UIPServer.o
OBJECTS += UIPEthernet/UIPUdp.o
OBJECTS += UIPEthernet/utility/Enc28J60Network.o
OBJECTS += UIPEthernet/utility/IPAddress.o
OBJECTS += UIPEthernet/utility/clock-arch.o
OBJECTS += UIPEthernet/utility/mempool.o
OBJECTS += UIPEthernet/utility/millis.o
OBJECTS += UIPEthernet/utility/uip.o
OBJECTS += UIPEthernet/utility/uip_arp.o
OBJECTS += UIPEthernet/utility/uip_debug.o
OBJECTS += UIPEthernet/utility/uip_timer.o
OBJECTS += main.o

 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_smartcard.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/PeripheralPins.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/analogin_api.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/analogout_api.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/can_api.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/gpio_api.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/gpio_irq_api.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/gpio_irq_device.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/hal_tick_16b.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/hal_tick_32b.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/i2c_api.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/lp_ticker.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/mbed_board.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/mbed_overrides.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/mbed_retarget.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/mbed_sdk_boot.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/pinmap.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/port_api.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/pwmout_api.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/pwmout_device.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/rtc_api.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/serial_api.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/serial_device.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/sleep.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/spi_api.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/startup_stm32f303xe.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_adc.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_adc_ex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_can.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_cec.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_comp.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_cortex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_crc.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_crc_ex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_dac.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_dac_ex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_dma.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_flash.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_flash_ex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_gpio.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_hrtim.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_i2c.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_i2c_ex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_i2s.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_i2s_ex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_irda.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_iwdg.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_nand.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_nor.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_opamp.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_opamp_ex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_pccard.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_pcd.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_pcd_ex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_pwr.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_pwr_ex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_rcc.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_rcc_ex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_rtc.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_rtc_ex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_sdadc.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_smartcard_ex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_smbus.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_spi.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_spi_ex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_sram.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_tim.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_tim_ex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_tsc.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_uart.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_uart_ex.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_usart.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_hal_wwdg.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_adc.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_comp.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_crc.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_dac.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_dma.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_exti.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_fmc.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_gpio.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_hrtim.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_i2c.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_opamp.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_pwr.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_rcc.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_rtc.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_spi.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_tim.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_usart.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm32f3xx_ll_utils.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/stm_spi_api.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/system_stm32f3xx.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/trng_api.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/us_ticker_16b.o
 SYS_OBJECTS += mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/us_ticker_32b.o

INCLUDE_PATHS += -I../
INCLUDE_PATHS += -I../.
INCLUDE_PATHS += -I../HC-SR04
INCLUDE_PATHS += -I../MQTTClient
INCLUDE_PATHS += -I../UIPEthernet
INCLUDE_PATHS += -I../UIPEthernet/utility
INCLUDE_PATHS += -I../mbed/.
INCLUDE_PATHS += -I../mbed/TARGET_NUCLEO_F303RE
INCLUDE_PATHS += -I../mbed/TARGET_NUCLEO_F303RE/TARGET_STM
INCLUDE_PATHS += -I../mbed/TARGET_NUCLEO_F303RE/TARGET_STM/TARGET_STM32F3
INCLUDE_PATHS += -I../mbed/TARGET_NUCLEO_F303RE/TARGET_STM/TARGET_STM32F3/TARGET_STM32F303xE
INCLUDE_PATHS += -I../mbed/TARGET_NUCLEO_F303RE/TARGET_STM/TARGET_STM32F3/TARGET_STM32F303xE/TARGET_NUCLEO_F303RE
INCLUDE_PATHS += -I../mbed/TARGET_NUCLEO_F303RE/TARGET_STM/TARGET_STM32F3/TARGET_STM32F303xE/device
INCLUDE_PATHS += -I../mbed/TARGET_NUCLEO_F303RE/TARGET_STM/TARGET_STM32F3/device
INCLUDE_PATHS += -I../mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM
INCLUDE_PATHS += -I../mbed/drivers
INCLUDE_PATHS += -I../mbed/hal
INCLUDE_PATHS += -I../mbed/platform

LIBRARY_PATHS := -L../mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM 
LIBRARIES := -lmbed 
LINKER_SCRIPT ?= ../mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM/STM32F303XE.ld

# Objects and Paths
###############################################################################
# Tools and Flags

AS      = 'arm-none-eabi-gcc' '-x' 'assembler-with-cpp' '-c' '-Wall' '-Wextra' '-Wno-unused-parameter' '-Wno-missing-field-initializers' '-fmessage-length=0' '-fno-exceptions' '-fno-builtin' '-ffunction-sections' '-fdata-sections' '-funsigned-char' '-MMD' '-fno-delete-null-pointer-checks' '-fomit-frame-pointer' '-Os' '-g1' '-mcpu=cortex-m4' '-mthumb' '-mfpu=fpv4-sp-d16' '-mfloat-abi=softfp'
CC      = 'arm-none-eabi-gcc' '-std=gnu99' '-c' '-Wall' '-Wextra' '-Wno-unused-parameter' '-Wno-missing-field-initializers' '-fmessage-length=0' '-fno-exceptions' '-fno-builtin' '-ffunction-sections' '-fdata-sections' '-funsigned-char' '-MMD' '-fno-delete-null-pointer-checks' '-fomit-frame-pointer' '-Os' '-g1' '-mcpu=cortex-m4' '-mthumb' '-mfpu=fpv4-sp-d16' '-mfloat-abi=softfp'
CPP     = 'arm-none-eabi-g++' '-std=gnu++98' '-fno-rtti' '-Wvla' '-c' '-Wall' '-Wextra' '-Wno-unused-parameter' '-Wno-missing-field-initializers' '-fmessage-length=0' '-fno-exceptions' '-fno-builtin' '-ffunction-sections' '-fdata-sections' '-funsigned-char' '-MMD' '-fno-delete-null-pointer-checks' '-fomit-frame-pointer' '-Os' '-g1' '-mcpu=cortex-m4' '-mthumb' '-mfpu=fpv4-sp-d16' '-mfloat-abi=softfp'
LD      = 'arm-none-eabi-gcc'
ELF2BIN = 'arm-none-eabi-objcopy'
PREPROC = 'arm-none-eabi-cpp' '-E' '-P' '-Wl,--gc-sections' '-Wl,--wrap,main' '-Wl,--wrap,_malloc_r' '-Wl,--wrap,_free_r' '-Wl,--wrap,_realloc_r' '-Wl,--wrap,_memalign_r' '-Wl,--wrap,_calloc_r' '-Wl,--wrap,exit' '-Wl,--wrap,atexit' '-Wl,-n' '-mcpu=cortex-m4' '-mthumb' '-mfpu=fpv4-sp-d16' '-mfloat-abi=softfp'


C_FLAGS += -std=gnu99
C_FLAGS += -DTARGET_STM32F303RE
C_FLAGS += -D__MBED__=1
C_FLAGS += -DDEVICE_I2CSLAVE=1
C_FLAGS += -DTARGET_LIKE_MBED
C_FLAGS += -DDEVICE_PORTOUT=1
C_FLAGS += -DDEVICE_PORTINOUT=1
C_FLAGS += -DTARGET_RTOS_M4_M7
C_FLAGS += -DDEVICE_LOWPOWERTIMER=1
C_FLAGS += -DDEVICE_RTC=1
C_FLAGS += -DTOOLCHAIN_object
C_FLAGS += -DDEVICE_SERIAL_ASYNCH=1
C_FLAGS += -D__CMSIS_RTOS
C_FLAGS += -DTOOLCHAIN_GCC
C_FLAGS += -DDEVICE_CAN=1
C_FLAGS += -DTARGET_CORTEX_M
C_FLAGS += -DDEVICE_I2C_ASYNCH=1
C_FLAGS += -DTARGET_LIKE_CORTEX_M4
C_FLAGS += -DDEVICE_ANALOGOUT=1
C_FLAGS += -DTARGET_M4
C_FLAGS += -DTARGET_UVISOR_UNSUPPORTED
C_FLAGS += -DTARGET_NUCLEO_F303RE
C_FLAGS += -DDEVICE_SPI_ASYNCH=1
C_FLAGS += -DDEVICE_SERIAL=1
C_FLAGS += -DDEVICE_INTERRUPTIN=1
C_FLAGS += -DTARGET_CORTEX
C_FLAGS += -DDEVICE_I2C=1
C_FLAGS += -DTRANSACTION_QUEUE_SIZE_SPI=2
C_FLAGS += -D__CORTEX_M4
C_FLAGS += -DDEVICE_STDIO_MESSAGES=1
C_FLAGS += -DTARGET_FF_MORPHO
C_FLAGS += -D__FPU_PRESENT=1
C_FLAGS += -DTARGET_STM32F303xE
C_FLAGS += -DTARGET_FF_ARDUINO
C_FLAGS += -DDEVICE_PORTIN=1
C_FLAGS += -DTARGET_RELEASE
C_FLAGS += -DTARGET_STM
C_FLAGS += -DMBED_BUILD_TIMESTAMP=1525355842.56
C_FLAGS += -DDEVICE_SERIAL_FC=1
C_FLAGS += -D__MBED_CMSIS_RTOS_CM
C_FLAGS += -DDEVICE_SLEEP=1
C_FLAGS += -DTOOLCHAIN_GCC_ARM
C_FLAGS += -DDEVICE_SPI=1
C_FLAGS += -DDEVICE_SPISLAVE=1
C_FLAGS += -DTARGET_STM32F3
C_FLAGS += -DDEVICE_ANALOGIN=1
C_FLAGS += -DDEVICE_PWMOUT=1
C_FLAGS += -DARM_MATH_CM4
C_FLAGS += -include
C_FLAGS += mbed_config.h

CXX_FLAGS += -std=gnu++98
CXX_FLAGS += -fno-rtti
CXX_FLAGS += -Wvla
CXX_FLAGS += -DTARGET_STM32F303RE
CXX_FLAGS += -D__MBED__=1
CXX_FLAGS += -DDEVICE_I2CSLAVE=1
CXX_FLAGS += -DTARGET_LIKE_MBED
CXX_FLAGS += -DDEVICE_PORTOUT=1
CXX_FLAGS += -DDEVICE_PORTINOUT=1
CXX_FLAGS += -DTARGET_RTOS_M4_M7
CXX_FLAGS += -DDEVICE_LOWPOWERTIMER=1
CXX_FLAGS += -DDEVICE_RTC=1
CXX_FLAGS += -DTOOLCHAIN_object
CXX_FLAGS += -DDEVICE_SERIAL_ASYNCH=1
CXX_FLAGS += -D__CMSIS_RTOS
CXX_FLAGS += -DTOOLCHAIN_GCC
CXX_FLAGS += -DDEVICE_CAN=1
CXX_FLAGS += -DTARGET_CORTEX_M
CXX_FLAGS += -DDEVICE_I2C_ASYNCH=1
CXX_FLAGS += -DTARGET_LIKE_CORTEX_M4
CXX_FLAGS += -DDEVICE_ANALOGOUT=1
CXX_FLAGS += -DTARGET_M4
CXX_FLAGS += -DTARGET_UVISOR_UNSUPPORTED
CXX_FLAGS += -DTARGET_NUCLEO_F303RE
CXX_FLAGS += -DDEVICE_SPI_ASYNCH=1
CXX_FLAGS += -DDEVICE_SERIAL=1
CXX_FLAGS += -DDEVICE_INTERRUPTIN=1
CXX_FLAGS += -DTARGET_CORTEX
CXX_FLAGS += -DDEVICE_I2C=1
CXX_FLAGS += -DTRANSACTION_QUEUE_SIZE_SPI=2
CXX_FLAGS += -D__CORTEX_M4
CXX_FLAGS += -DDEVICE_STDIO_MESSAGES=1
CXX_FLAGS += -DTARGET_FF_MORPHO
CXX_FLAGS += -D__FPU_PRESENT=1
CXX_FLAGS += -DTARGET_STM32F303xE
CXX_FLAGS += -DTARGET_FF_ARDUINO
CXX_FLAGS += -DDEVICE_PORTIN=1
CXX_FLAGS += -DTARGET_RELEASE
CXX_FLAGS += -DTARGET_STM
CXX_FLAGS += -DMBED_BUILD_TIMESTAMP=1525355842.56
CXX_FLAGS += -DDEVICE_SERIAL_FC=1
CXX_FLAGS += -D__MBED_CMSIS_RTOS_CM
CXX_FLAGS += -DDEVICE_SLEEP=1
CXX_FLAGS += -DTOOLCHAIN_GCC_ARM
CXX_FLAGS += -DDEVICE_SPI=1
CXX_FLAGS += -DDEVICE_SPISLAVE=1
CXX_FLAGS += -DTARGET_STM32F3
CXX_FLAGS += -DDEVICE_ANALOGIN=1
CXX_FLAGS += -DDEVICE_PWMOUT=1
CXX_FLAGS += -DARM_MATH_CM4
CXX_FLAGS += -include
CXX_FLAGS += mbed_config.h

ASM_FLAGS += -x
ASM_FLAGS += assembler-with-cpp
ASM_FLAGS += -DTRANSACTION_QUEUE_SIZE_SPI=2
ASM_FLAGS += -D__CORTEX_M4
ASM_FLAGS += -DARM_MATH_CM4
ASM_FLAGS += -D__FPU_PRESENT=1
ASM_FLAGS += -D__MBED_CMSIS_RTOS_CM
ASM_FLAGS += -D__CMSIS_RTOS
ASM_FLAGS += -I../.
ASM_FLAGS += -I../MQTTClient
ASM_FLAGS += -I../UIPEthernet
ASM_FLAGS += -I../UIPEthernet/utility
ASM_FLAGS += -I../HC-SR04
ASM_FLAGS += -I../mbed/.
ASM_FLAGS += -I../mbed/TARGET_NUCLEO_F303RE
ASM_FLAGS += -I../mbed/TARGET_NUCLEO_F303RE/TARGET_STM
ASM_FLAGS += -I../mbed/TARGET_NUCLEO_F303RE/TARGET_STM/TARGET_STM32F3
ASM_FLAGS += -I../mbed/TARGET_NUCLEO_F303RE/TARGET_STM/TARGET_STM32F3/TARGET_STM32F303xE
ASM_FLAGS += -I../mbed/TARGET_NUCLEO_F303RE/TARGET_STM/TARGET_STM32F3/TARGET_STM32F303xE/TARGET_NUCLEO_F303RE
ASM_FLAGS += -I../mbed/TARGET_NUCLEO_F303RE/TARGET_STM/TARGET_STM32F3/TARGET_STM32F303xE/device
ASM_FLAGS += -I../mbed/TARGET_NUCLEO_F303RE/TARGET_STM/TARGET_STM32F3/device
ASM_FLAGS += -I../mbed/TARGET_NUCLEO_F303RE/TOOLCHAIN_GCC_ARM
ASM_FLAGS += -I../mbed/drivers
ASM_FLAGS += -I../mbed/hal
ASM_FLAGS += -I../mbed/platform


LD_FLAGS :=-Wl,--gc-sections -Wl,--wrap,main -Wl,--wrap,_malloc_r -Wl,--wrap,_free_r -Wl,--wrap,_realloc_r -Wl,--wrap,_memalign_r -Wl,--wrap,_calloc_r -Wl,--wrap,exit -Wl,--wrap,atexit -Wl,-n -mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=softfp 
LD_SYS_LIBS :=-Wl,--start-group -lstdc++ -lsupc++ -lm -lc -lgcc -lnosys -lmbed -Wl,--end-group

# Tools and Flags
###############################################################################
# Rules

.PHONY: all lst size


all: $(PROJECT).bin $(PROJECT).hex size


.s.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Assemble: $(notdir $<)"
  
	@$(AS) -c $(ASM_FLAGS) -o $@ $<
  


.S.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Assemble: $(notdir $<)"
  
	@$(AS) -c $(ASM_FLAGS) -o $@ $<
  

.c.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Compile: $(notdir $<)"
	@$(CC) $(C_FLAGS) $(INCLUDE_PATHS) -o $@ $<

.cpp.o:
	+@$(call MAKEDIR,$(dir $@))
	+@echo "Compile: $(notdir $<)"
	@$(CPP) $(CXX_FLAGS) $(INCLUDE_PATHS) -o $@ $<


$(PROJECT).link_script.ld: $(LINKER_SCRIPT)
	@$(PREPROC) $< -o $@



$(PROJECT).elf: $(OBJECTS) $(SYS_OBJECTS) $(PROJECT).link_script.ld 
	+@echo "link: $(notdir $@)"
	@$(LD) $(LD_FLAGS) -T $(filter-out %.o, $^) $(LIBRARY_PATHS) --output $@ $(filter %.o, $^) $(LIBRARIES) $(LD_SYS_LIBS)


$(PROJECT).bin: $(PROJECT).elf
	$(ELF2BIN) -O binary $< $@
	+@echo "===== bin file ready to flash: $(OBJDIR)/$@ =====" 

$(PROJECT).hex: $(PROJECT).elf
	$(ELF2BIN) -O ihex $< $@


# Rules
###############################################################################
# Dependencies

DEPS = $(OBJECTS:.o=.d) $(SYS_OBJECTS:.o=.d)
-include $(DEPS)
endif

# Dependencies
###############################################################################
