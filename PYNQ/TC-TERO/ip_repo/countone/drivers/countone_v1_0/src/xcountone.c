// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xcountone.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XCountone_CfgInitialize(XCountone *InstancePtr, XCountone_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Ctrl_BaseAddress = ConfigPtr->Ctrl_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XCountone_Start(XCountone *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCountone_ReadReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_AP_CTRL) & 0x80;
    XCountone_WriteReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XCountone_IsDone(XCountone *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCountone_ReadReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XCountone_IsIdle(XCountone *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCountone_ReadReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XCountone_IsReady(XCountone *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCountone_ReadReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XCountone_EnableAutoRestart(XCountone *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCountone_WriteReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_AP_CTRL, 0x80);
}

void XCountone_DisableAutoRestart(XCountone *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCountone_WriteReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_AP_CTRL, 0);
}

u32 XCountone_Get_return(XCountone *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCountone_ReadReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_AP_RETURN);
    return Data;
}
void XCountone_InterruptGlobalEnable(XCountone *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCountone_WriteReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_GIE, 1);
}

void XCountone_InterruptGlobalDisable(XCountone *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCountone_WriteReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_GIE, 0);
}

void XCountone_InterruptEnable(XCountone *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XCountone_ReadReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_IER);
    XCountone_WriteReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_IER, Register | Mask);
}

void XCountone_InterruptDisable(XCountone *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XCountone_ReadReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_IER);
    XCountone_WriteReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_IER, Register & (~Mask));
}

void XCountone_InterruptClear(XCountone *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCountone_WriteReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_ISR, Mask);
}

u32 XCountone_InterruptGetEnabled(XCountone *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XCountone_ReadReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_IER);
}

u32 XCountone_InterruptGetStatus(XCountone *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XCountone_ReadReg(InstancePtr->Ctrl_BaseAddress, XCOUNTONE_CTRL_ADDR_ISR);
}

