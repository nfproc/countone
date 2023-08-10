// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xcountone.h"

extern XCountone_Config XCountone_ConfigTable[];

XCountone_Config *XCountone_LookupConfig(u16 DeviceId) {
	XCountone_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XCOUNTONE_NUM_INSTANCES; Index++) {
		if (XCountone_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XCountone_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XCountone_Initialize(XCountone *InstancePtr, u16 DeviceId) {
	XCountone_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XCountone_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XCountone_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

