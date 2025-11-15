EXTRA_CFLAGS += $(USER_EXTRA_CFLAGS)
EXTRA_CFLAGS += -Wno-implicit-fallthrough
#EXTRA_CFLAGS += -Wno-unused-function
#EXTRA_CFLAGS += -Wno-maybe-uninitialized
#EXTRA_CFLAGS += -Wno-unused-variable

RWNX_VERS_NUM := 6.4.3.0

CONFIG_COUNTRY_CODE = "00"

CONFIG_AIC8800_WLAN_SUPPORT = m
CONFIG_AIC8800_BTLPM_SUPPORT = m
CONFIG_AIC8800_BSP = m

# Support of bootrom start
CONFIG_START_FROM_BOOTROM = y

# Support of pmic setting, new version bootrom avaliable
CONFIG_PMIC_SETTING ?=y

# Select 8800DC/DW DCDC_VRF mode, check your board
CONFIG_VRF_DCDC_MODE = y


# ROM patch enabled option
CONFIG_ROM_PATCH_EN ?=y
# Support chip with mcu
CONFIG_MCU_INTEGRATED ?= n
ifeq ($(CONFIG_MCU_INTEGRATED), y)
CONFIG_PMIC_SETTING = n
endif

#
# WAITING FOR KCONFIG {
#

#
# DEBUG OPTIONS
CONFIG_RWNX_UM_HELPER_DFLT ?= "/dini/dini_bin/rwnx_umh.sh"

# IPC version
CONFIG_RWNX_OLD_IPC ?= n

# Support of P2P DebugFS for enabling/disabling NoA and OppPS
CONFIG_RWNX_P2P_DEBUGFS := n
#
# } // WAITING FOR KCONFIG
#

# Enable A-MSDU support (need FW support)
## Select this if FW is compiled with AMSDU support
CONFIG_RWNX_SPLIT_TX_BUF ?= n
## Select this TO send AMSDU
CONFIG_RWNX_AMSDUS_TX ?= n

# Enable BFMER support (need FW support)
CONFIG_RWNX_BFMER ?= n

CONFIG_SDIO_SUPPORT =y
CONFIG_RX_REORDER ?=y
CONFIG_ARP_OFFLOAD =y
CONFIG_RADAR_OR_IR_DETECT =n
CONFIG_DOWNLOAD_FW =n
CONFIG_RFTEST=y
CONFIG_USB_BT =y
CONFIG_SDIO_BT=n
CONFIG_USE_5G ?= y
CONFIG_CREATE_TRACE_POINTS = n
CONFIG_TXRX_THREAD_PRIO = y
# CONFIG_COEX = n for BT_ONLY, CONFIG_COEX =y for combo and sw
CONFIG_COEX = y
CONFIG_RX_NETIF_RECV_SKB = y
CONFIG_SET_VENDOR_EXTENSION_IE = n
CONFIG_SUPPORT_REALTIME_CHANGE_MAC = y
CONFIG_WPA3_FOR_OLD_KERNEL ?= n
CONFIG_PREALLOC_RX_SKB ?= n
CONFIG_WIFI_SUSPEND_FOR_LINUX = n
# Need to set fw path in BOARD_KERNEL_CMDLINE
CONFIG_USE_FW_REQUEST ?= y
CONFIG_USE_P2P0=n
CONFIG_TX_NETIF_FLOWCTRL = n
CONFIG_ONE_TXQ = n
CONFIG_SCHED_SCAN = n
CONFIG_OOB ?= n
CONFIG_USE_CUSTOMER_MAC = n
CONFIG_PREALLOC_TXQ ?= y
CONFIG_DPD = y
CONFIG_FORCE_DPD_CALIB = y
CONFIG_LOFT_CALIB = n
CONFIG_FILTER_TCP_ACK =y
CONFIG_RESV_MEM_SUPPORT ?= y
CONFIG_TEMP_COMP = n
CONFIG_TEMP_CONTROL = n
CONFIG_EXT_FEM_8800DCDW = n
CONFIG_SHUTDOWN_CALLBACK = y
CONFIG_FOR_IPCAM = n
CONFIG_SDIO_ADMA = n
# CONFIG_MCC = n for sta and p2p concurrent in same channel.
CONFIG_MCC = y
CONFIG_APF = n
CONFIG_POWER_LIMIT = n

#CONFIG FOR LOW POWER MODE
CONFIG_SDIO_PWRCTRL ?= y
CONFIG_GPIO_WAKEUP ?= n
CONFIG_AUTO_POWERSAVE = n

# Enable wifi-hal Latency Mode
CONFIG_AICWF_LATENCY_MODE = n

ifneq ($(CONFIG_WIRELESS_EXT), y)
CONFIG_USE_WIRELESS_EXT = n
endif

ifeq ($(CONFIG_EXT_FEM_8800DCDW), y)
CONFIG_DPD = n
CONFIG_FORCE_DPD_CALIB = n
CONFIG_LOFT_CALIB = y
endif

# Support of MU-MIMO transmission (need FW support)
ifeq ($(CONFIG_RWNX_BFMER), y)
CONFIG_RWNX_MUMIMO_TX ?= n
else
CONFIG_RWNX_MUMIMO_TX = n
endif

# Enable handling of radar event
CONFIG_RWNX_RADAR ?= y

# Enable HW queue for Broadcast/Multicast traffic (need FW support)
CONFIG_RWNX_BCMC ?= y

# Enable Monitor+Data interface support (need FW support)
CONFIG_RWNX_MON_DATA = n
CONFIG_RWNX_MON_XMIT = n
CONFIG_RWNX_MON_RXFILTER = n


# extra DEBUG config
CONFIG_RWNX_SW_PROFILING ?= n
CONFIG_RWNX_DBG ?= y
CONFIG_DEBUG_FS ?= n

ccflags-$(CONFIG_DEBUG_FS) += -DCONFIG_RWNX_DEBUGFS
ccflags-$(CONFIG_DEBUG_FS) += -DCONFIG_RWNX_UM_HELPER_DFLT=\"$(CONFIG_RWNX_UM_HELPER_DFLT)\"
ccflags-$(CONFIG_RWNX_P2P_DEBUGFS) += -DCONFIG_RWNX_P2P_DEBUGFS

# FW VARS
ccflags-y += -DNX_VIRT_DEV_MAX=4

#for 8800D and DCDW u01
#ccflags-y += -DNX_REMOTE_STA_MAX=10

#for 8800DCDW u02
ccflags-y += -DNX_REMOTE_STA_MAX_FOR_OLD_IC=10
ccflags-y += -DNX_REMOTE_STA_MAX=32

ccflags-y += -DNX_MU_GROUP_MAX=62
ccflags-y += -DNX_TXDESC_CNT=64
ccflags-y += -DNX_TX_MAX_RATES=4
ccflags-y += -DNX_CHAN_CTXT_CNT=3

# FW ARCH:
ccflags-$(CONFIG_RWNX_OLD_IPC) += -DCONFIG_RWNX_OLD_IPC
ccflags-$(CONFIG_START_FROM_BOOTROM) += -DCONFIG_START_FROM_BOOTROM
ccflags-$(CONFIG_PMIC_SETTING) += -DCONFIG_PMIC_SETTING
ccflags-$(CONFIG_VRF_DCDC_MODE) += -DCONFIG_VRF_DCDC_MODE
ccflags-$(CONFIG_ROM_PATCH_EN) += -DCONFIG_ROM_PATCH_EN
ccflags-$(CONFIG_MCU_INTEGRATED) += -DCONFIG_MCU_INTEGRATED
ccflags-$(CONFIG_COEX) += -DCONFIG_COEX

ccflags-y += -I$(srctree)
ccflags-y += -I$(srctree)/$(src)
ccflags-y += -I$(srctree)/$(src)/../aic8800_bsp
ccflags-y += -DCONFIG_AIC_FW_PATH=\"$(CONFIG_AIC_FW_PATH)\"
ccflags-$(CONFIG_RWNX_RADAR) += -DCONFIG_RWNX_RADAR
ccflags-$(CONFIG_RWNX_MON_DATA) += -DCONFIG_RWNX_MON_DATA
ccflags-$(CONFIG_RWNX_MON_XMIT) += -DCONFIG_RWNX_MON_XMIT
ccflags-$(CONFIG_RWNX_MON_RXFILTER) += -DCONFIG_RWNX_MON_RXFILTER

ccflags-$(CONFIG_RWNX_BFMER) += -DCONFIG_RWNX_BFMER
ccflags-$(CONFIG_RWNX_SPLIT_TX_BUF) += -DCONFIG_RWNX_SPLIT_TX_BUF
ifeq ($(CONFIG_RWNX_SPLIT_TX_BUF), y)
ccflags-$(CONFIG_RWNX_AMSDUS_TX) += -DCONFIG_RWNX_AMSDUS_TX
endif
ccflags-$(CONFIG_RWNX_DBG) += -DCONFIG_RWNX_DBG
ccflags-$(CONFIG_RWNX_SW_PROFILING) += -DCONFIG_RWNX_SW_PROFILING
ccflags-$(CONFIG_RWNX_MUMIMO_TX) += -DCONFIG_RWNX_MUMIMO_TX
ccflags-$(CONFIG_RFTEST) += -DCONFIG_RFTEST
ccflags-y += -DDEFAULT_COUNTRY_CODE=""\$(CONFIG_COUNTRY_CODE)"\"
ccflags-$(CONFIG_USE_5G) += -DUSE_5G
ccflags-$(CONFIG_CREATE_TRACE_POINTS) += -DCREATE_TRACE_POINTS
ccflags-$(CONFIG_TXRX_THREAD_PRIO) += -DCONFIG_TXRX_THREAD_PRIO
ccflags-$(CONFIG_GPIO_WAKEUP) += -DCONFIG_GPIO_WAKEUP
ccflags-$(CONFIG_SET_VENDOR_EXTENSION_IE) += -DCONFIG_SET_VENDOR_EXTENSION_IE
ccflags-$(CONFIG_SUPPORT_REALTIME_CHANGE_MAC) += -DCONFIG_SUPPORT_REALTIME_CHANGE_MAC
ccflags-$(CONFIG_WPA3_FOR_OLD_KERNEL) += -DCONFIG_WPA3_FOR_OLD_KERNEL
ccflags-$(CONFIG_PREALLOC_RX_SKB) += -DCONFIG_PREALLOC_RX_SKB
ccflags-$(CONFIG_WIFI_SUSPEND_FOR_LINUX) += -DCONFIG_WIFI_SUSPEND_FOR_LINUX
ccflags-$(CONFIG_USE_FW_REQUEST) += -DCONFIG_USE_FW_REQUEST
ccflags-$(CONFIG_USE_P2P0) += -DCONFIG_USE_P2P0
ccflags-$(CONFIG_SCHED_SCAN) += -DCONFIG_SCHED_SCAN
ccflags-$(CONFIG_OOB) += -DCONFIG_OOB
ccflags-$(CONFIG_AICWF_LATENCY_MODE) += -DAICWF_LATENCY_MODE
ccflags-$(CONFIG_USE_CUSTOMER_MAC) += -DCONFIG_USE_CUSTOMER_MAC
ccflags-$(CONFIG_PREALLOC_TXQ) += -DCONFIG_PREALLOC_TXQ
ccflags-$(CONFIG_DPD) += -DCONFIG_DPD
ccflags-$(CONFIG_FORCE_DPD_CALIB) += -DCONFIG_FORCE_DPD_CALIB -DCONFIG_DPD
ccflags-$(CONFIG_LOFT_CALIB) += -DCONFIG_LOFT_CALIB
ccflags-$(CONFIG_FILTER_TCP_ACK) += -DCONFIG_FILTER_TCP_ACK
ccflags-$(CONFIG_SDIO_BT) += -DCONFIG_SDIO_BT
ccflags-$(CONFIG_RESV_MEM_SUPPORT) += -DCONFIG_RESV_MEM_SUPPORT
ccflags-$(CONFIG_TEMP_COMP) += -DCONFIG_TEMP_COMP
ccflags-$(CONFIG_TEMP_CONTROL) += -DCONFIG_TEMP_CONTROL
ccflags-$(CONFIG_POWER_LIMIT) += -DCONFIG_POWER_LIMIT
ccflags-$(CONFIG_EXT_FEM_8800DCDW) += -DCONFIG_EXT_FEM_8800DCDW
ccflags-$(CONFIG_MCC) += -DCONFIG_MCC
ccflags-$(CONFIG_SHUTDOWN_CALLBACK) += -DCONFIG_SHUTDOWN_CALLBACK
ccflags-$(CONFIG_FOR_IPCAM) += -DCONFIG_FOR_IPCAM
ccflags-$(CONFIG_SDIO_ADMA) += -DCONFIG_SDIO_ADMA


ifeq ($(CONFIG_SDIO_SUPPORT), y)
ccflags-y += -DAICWF_SDIO_SUPPORT
ccflags-$(CONFIG_SDIO_PWRCTRL) += -DCONFIG_SDIO_PWRCTRL
endif

ifeq ($(CONFIG_RWNX_MUMIMO_TX), y)
ccflags-y += -DCONFIG_USER_MAX=2
else
ccflags-y += -DCONFIG_USER_MAX=1
endif

ifeq ($(CONFIG_RWNX_BCMC), y)
ccflags-y += -DNX_TXQ_CNT=5
else
ccflags-y += -DNX_TXQ_CNT=4
endif

ccflags-$(CONFIG_RX_REORDER) += -DAICWF_RX_REORDER
ccflags-$(CONFIG_ARP_OFFLOAD) += -DAICWF_ARP_OFFLOAD
ccflags-$(CONFIG_RADAR_OR_IR_DETECT) += -DCONFIG_RADAR_OR_IR_DETECT
ccflags-$(CONFIG_DOWNLOAD_FW)  += -DCONFIG_DOWNLOAD_FW
ccflags-$(CONFIG_RX_NETIF_RECV_SKB) += -DCONFIG_RX_NETIF_RECV_SKB
ccflags-$(CONFIG_ONE_TXQ)  += -DCONFIG_ONE_TXQ
ccflags-$(CONFIG_TX_NETIF_FLOWCTRL) += -DCONFIG_TX_NETIF_FLOWCTRL
ccflags-$(CONFIG_APF) += -DCONFIG_APF
ccflags-$(CONFIG_AUTO_POWERSAVE) += -DCONFIG_AUTO_POWERSAVE

ccflags-y += -DAIC_TRACE_INCLUDE_PATH=$(src)
MAKEFLAGS +=-j$(shell nproc)

aic8800_fdrv-y += \
	aicsemi/aic8800/aic8800_fdrv/rwnx_msg_tx.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_msg_rx.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_utils.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_cmds.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_irqs.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_cfgfile.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_strs.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_rx.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_tx.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_txq.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_main.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_mod_params.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_mesh.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_platform.o \
	aicsemi/aic8800/aic8800_fdrv/ipc_host.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_tdls.o \
	aicsemi/aic8800/aic8800_fdrv/md5.o \
	aicsemi/aic8800/aic8800_fdrv/aicwf_compat_8800dc.o \
	aicsemi/aic8800/aic8800_fdrv/aicwf_compat_8800d80.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_wakelock.o \
	aicsemi/aic8800/aic8800_fdrv/regdb.o \
	aicsemi/aic8800/aic8800_fdrv/aicwf_rx_prealloc.o

aic8800_fdrv-$(CONFIG_RWNX_RADAR) += \
	aicsemi/aic8800/aic8800_fdrv/rwnx_radar.o
aic8800_fdrv-$(CONFIG_DEBUG_FS) += \
	aicsemi/aic8800/aic8800_fdrv/rwnx_debugfs.o \
	aicsemi/aic8800/aic8800_fdrv/rwnx_fw_trace.o

aic8800_fdrv-$(CONFIG_NL80211_TESTMODE) += \
	aicsemi/aic8800/aic8800_fdrv/rwnx_testmode.o
aic8800_fdrv-$(CONFIG_RWNX_BFMER)       += \
	aicsemi/aic8800/aic8800_fdrv/rwnx_bfmer.o
aic8800_fdrv-$(CONFIG_RWNX_MUMIMO_TX)   += \
	aicsemi/aic8800/aic8800_fdrv/rwnx_mu_group.o
aic8800_fdrv-$(CONFIG_SDIO_SUPPORT)     += \
	aicsemi/aic8800/aic8800_fdrv/sdio_host.o
aic8800_fdrv-$(CONFIG_SDIO_SUPPORT)     += \
	aicsemi/aic8800/aic8800_fdrv/aicwf_txrxif.o \
	aicsemi/aic8800/aic8800_fdrv/aicwf_sdio.o
aic8800_fdrv-$(CONFIG_FILTER_TCP_ACK)   += \
	aicsemi/aic8800/aic8800_fdrv/aicwf_tcp_ack.o

aic8800_fdrv-$(CONFIG_SDIO_BT)   += \
	aicsemi/aic8800/aic8800_fdrv/aic_btsdio.o \
	aicsemi/aic8800/aic8800_fdrv/btsdio.o

aic8800_btlpm-y += \
	aicsemi/aic8800/aic8800_btlpm/aic_bluetooth_main.o \
	aicsemi/aic8800/aic8800_btlpm/rfkill.o

aic8800_btlpm-y-$(CONFIG_SUPPORT_LPM) += \
	aicsemi/aic8800/aic8800_btlpm/lpm.o

aic8800_bsp-y += \
	aicsemi/aic8800/aic8800_bsp/aic8800dc_compat.o \
	aicsemi/aic8800/aic8800_bsp/aic8800d80_compat.o \
	aicsemi/aic8800/aic8800_bsp/aic_bsp_main.o \
	aicsemi/aic8800/aic8800_bsp/aic_bsp_driver.o \
	aicsemi/aic8800/aic8800_bsp/aicsdio.o \
	aicsemi/aic8800/aic8800_bsp/aicsdio_txrxif.o \
	aicsemi/aic8800/aic8800_bsp/md5.o

aic8800_bsp-$(CONFIG_PREALLOC_TXQ) += \
	aicsemi/aic8800/aic8800_bsp/aicwf_txq_prealloc.o


########## Platform support list ##########
CONFIG_PLATFORM_UBUNTU ?= y

ifeq ($(CONFIG_PLATFORM_UBUNTU), y)
ccflags-$(CONFIG_PLATFORM_UBUNTU) += -DCONFIG_PLATFORM_UBUNTU
KSRC  ?= /lib/modules/$(shell uname -r)/build
PWD   ?= $(shell pwd)
KVER ?= $(shell uname -r)
MODDESTDIR ?= /lib/modules/$(KVER)/kernel/drivers/net/wireless/
ARCH ?= x86_64
CROSS_COMPILE ?=
endif
###########################################

ifneq ($(KERNELRELEASE),)

obj-$(CONFIG_AIC8800_BTLPM_SUPPORT) += aic8800_btlpm.o
obj-$(CONFIG_AIC8800_WLAN_SUPPORT) += aic8800_fdrv.o
obj-$(CONFIG_AIC8800_BSP) += aic8800_bsp.o

else

all: modules
modules:
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KSRC) M=$(PWD)  modules

clean:
	rm -rf *.o *.ko *.o.* *.mod.* modules.* Module.* .a* .o* .*.o.* *.mod .tmp* .cache.mk

endif
