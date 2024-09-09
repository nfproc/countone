Hardware-oriented implementation of the "count the ones" test
=============================================================

Abstract
--------

This repository contains an HLS implementation of on-the-fly randomness
test circuit for TRNGs, presented in the following paper.

> Ryusei Oya, Naoki Fujieda, and Shuichi Ichikawa: An HLS implementation
> of on-the-fly randomness test for TRNGs, 10th International Symposium
> on Computing and Networking (CANDAR 2022), pp. 151–157 (11/2022).

It also includes demonstration systems for PYNQ-Z1. 
The system is developed for PYNQ 2.7 and synthesized with Xilinx Vivado
2020.2 and Vitis HLS 2020.2.
The demonstration systems include a system to evaluate an on-line quality
control method for latch-based TRNG, proposed in the following paper.

> Naoki Fujieda, Shuichi Ichikawa, Ryusei Oya, and Hitomi Kishibe: Design
> and implementation of an on-line quality control system for latch-based
> true random number generator, IEICE Transactions on Information and
> Systems, Vol. E106-D, No. 12, pp. 1940-1950 (12/2023).

------------------------------------------------------------------------

Organization of Repository
--------------------------

The hierarchy of the repository is as follows:

- `C_src`: C source code of the test circuit
- `PYNQ`: Set of source code of the demonstration system
  - `TC-TERO`: visualization system of <a href="https://github.com/nfproc/TC-TERO">TC-TERO</a>
    - `ip_repo`: IP cores for the system
    - `jupyter`: Jupyter Notebook to validate the system
  - `latch`: evaluation system of <a href="https://doi.org/10.1587/transinf.2023PAP0001">on-line quality control method for latch-based TRNG</a>
    - `ip_repo`: IP cores for the system
    - `jupyter`: Jupyter Notebook to validate the system
- `rand_data`: random bitstrings used in C testbench

------------------------------------------------------------------------

How to Use
----------

### Getting Started

Files in the `PYNQ/*/jupyter` folder are used to confirm the working system.

Upload all of the files to somewhere under the jupyter_notebookes folder of
a PYNQ board and open the notebook (TRNG_Test.ipynb)

### High Level Synthesis

Files in the `C_src` folder are used for high level synthsis.

Create a Vitis HLS project. Add countone.cpp, define.hpp, and prob_table.hpp
to the project as design files. Add main.cpp as a testbench file.
The target function of the high level synthesis is countone.

The bit widths of the fraction part of chsq and ev variables, which are
treated as parameters in the paper, are defined in define.cpp as CHSQ_F and
EV_F, respectively. By performing C simulation, the average error ratio
(comparing with the floating-point implementation) can be measured.

When the test circuit is included in the quality control circuit, it should
be modified to disable a start/stop control and output the results via
AXI-Stream. To do this, uncomment either of the #define lines, commented out
in define.hpp.

### Synthesis of Demonstration System

The system is generated from a block diagram.
Refer to `PYNQ/*/How_to_create_design_en.txt` for details.

------------------------------------------------------------------------

Copyright
---------

The C source code in the `C_src` folder and the Python notebook in the
`PYNQ/*/jupyter` folder are developed by <a href="https://aitech.ac.jp/~dslab/nf/index.en.html">Naoki FUJIEDA</a>.
A part of C source code includes contribution by Ryusei Oya.

The `PYNQ/*/ip_repo` folder includes the source code of a TRNG, published
at https://github.com/nfproc/TRNG_IP.
A part of IP core in the `PYNQ/latch/ip_repo/latch_control` folder includes
contribution by Hitomi Kishibe.

The files are licensed under the New BSD license.
See the LICENSE.txt file for more information.

Copyright (C) 2022-2024 Digital Systems Laboratory. All rights reserved.
