// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XCOUNTONE_H
#define XCOUNTONE_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xcountone_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u32 Ctrl_BaseAddress;
} XCountone_Config;
#endif

typedef struct {
    u64 Ctrl_BaseAddress;
    u32 IsReady;
} XCountone;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XCountone_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XCountone_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XCountone_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XCountone_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XCountone_Initialize(XCountone *InstancePtr, u16 DeviceId);
XCountone_Config* XCountone_LookupConfig(u16 DeviceId);
int XCountone_CfgInitialize(XCountone *InstancePtr, XCountone_Config *ConfigPtr);
#else
int XCountone_Initialize(XCountone *InstancePtr, const char* InstanceName);
int XCountone_Release(XCountone *InstancePtr);
#endif

void XCountone_Start(XCountone *InstancePtr);
u32 XCountone_IsDone(XCountone *InstancePtr);
u32 XCountone_IsIdle(XCountone *InstancePtr);
u32 XCountone_IsReady(XCountone *InstancePtr);
void XCountone_EnableAutoRestart(XCountone *InstancePtr);
void XCountone_DisableAutoRestart(XCountone *InstancePtr);
u32 XCountone_Get_return(XCountone *InstancePtr);


void XCountone_InterruptGlobalEnable(XCountone *InstancePtr);
void XCountone_InterruptGlobalDisable(XCountone *InstancePtr);
void XCountone_InterruptEnable(XCountone *InstancePtr, u32 Mask);
void XCountone_InterruptDisable(XCountone *InstancePtr, u32 Mask);
void XCountone_InterruptClear(XCountone *InstancePtr, u32 Mask);
u32 XCountone_InterruptGetEnabled(XCountone *InstancePtr);
u32 XCountone_InterruptGetStatus(XCountone *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
