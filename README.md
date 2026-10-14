# verilog-practice

A collection of fundamental digital design modules implemented in **Verilog HDL** and simulated using **AMD Xilinx Vivado**.

---

## 1. Repository Purpose

This repository contains the verified digital logic design projects implemented and practiced during undergraduate study in Electronics and Communication Engineering. The objective of this repository is to establish a strong, foundational understanding of Register-Transfer Level (RTL) design principles, combinational logic modeling, and behavioral simulation using industry-standard Electronic Design Automation (EDA) tools.

> [!NOTE]
> **Academic Learning Disclaimer:**  
> These designs represent foundational academic coursework and laboratory practice. They are intended for learning, experimentation, and reference in basic digital logic modeling using Verilog-2001.

---

## 2. Tools & Environment

- **Hardware Description Language:** Verilog HDL (IEEE 1364-2001 compliant)
- **Primary EDA Tool:** AMD Xilinx Vivado Design Suite (Behavioral Simulation with `xvlog`, `xelab`, and `xsim`)
- **Verification Paradigm:** Directed testbenches with propagation delay modeling and waveform analysis

---

## 3. Project Directory

Below is the summary table of all completed projects included in this repository:

| # | Project / Module | Directory | Key Verilog Concepts Demonstrated | Verification Status |
| :-: | :--- | :--- | :--- | :--- |
| 1 | **Basic Logic Gates** | [`logic-gates/`](logic-gates/README.md) | Dataflow modeling with `assign`; basic bitwise operators (`&`, `\|`, `~`, `^`) | **Verified** (`xsim`, 40 ns) |
| 2 | **4-Bit Bitwise Operations** | [`bitwise-operators/`](bitwise-operators/README.md) | Multi-bit vector bus operations (`[3:0]`) for AND, OR, XOR, NOT | **Verified** (`xsim`, 20 ns) |
| 3 | **Bitwise vs. Logical Operators** | [`bitwise-operators/`](bitwise-operators/README.md) | Contrasting vector-wide bitwise operators with scalar boolean truth evaluation and equality (`==`) | **Verified** (`xsim`, 30 ns) |
| 4 | **2-to-1 Multiplexer** | [`mux-2to1/`](mux-2to1/README.md) | Conditional operator (`? :`) vs. Boolean logic (`&`, `\|`, `~`) in a comparative testbench | **Verified** (`xsim`, 40 ns & 50 ns) |
| 5 | **4-to-1 Multiplexer** | [`mux-4to1/`](mux-4to1/README.md) | Nested ternary conditional operators for multi-channel data routing | **Verified** (`xsim`, 160 ns) |
| 6 | **2-to-4 Line Decoder** | [`decoder-2to4/`](decoder-2to4/README.md) | Procedural `always @(*)`, hierarchical `if-else` enable check, and `case` branching | **Verified** (`xsim`, 50 ns) |
| 7 | **1-to-4 Demultiplexer** | [`demux-1to4/`](demux-1to4/README.md) | Single-bit data steering using procedural `always @(*)`, `if-else`, and `case` with `default` | **Verified** (`xsim`, 70 ns) |
| 8 | **4-Bit Relational Comparator** | [`comparator-4bit-relational/`](comparator-4bit-relational/README.md) | Unsigned magnitude comparison using built-in relational operators (`<`, `>`, `==`) | *RTL Implemented (Testbench missing in original workspace)* |
| 9 | **4-Bit Bitwise Comparator** | [`comparator-4bit-bitwise/`](comparator-4bit-bitwise/README.md) | Magnitude comparison using bitwise XOR, AND-NOT, and MSB-first priority inspection | **Verified** (`xsim`, 60 ns) |
| 10 | **4-Bit Arithmetic Logic Unit** | [`alu-4bit/`](alu-4bit/README.md) | Addition, subtraction, AND, XOR; 5-bit width handling for unsigned carry-out; zero flag | **Verified** (`xsim`, 100 ns) |
| 11 | **D Flip-Flop Architectures** | [`d-flip-flops/`](d-flip-flops/README.md) | Positive edge-triggered DFF; synchronous reset; asynchronous reset; clock enable | **Verified** (`xsim`, 4 variants) |
| 12 | **4-Bit Register Architectures** | [`registers-4bit/`](registers-4bit/README.md) | Multi-bit PIPO registers with clock enable, synchronous reset, and asynchronous reset | **Verified** (`xsim`, 3 variants) |
| 13 | **4-Bit Counter Architectures** | [`counters-4bit/`](counters-4bit/README.md) | Synchronous up counter, up counter with enable, down counter, and bidirectional up/down counter | **Verified** (`xsim`, 4 variants) |

---

## 4. Repository Structure

```text
verilog-practice/
├── README.md                           # Main repository overview and index
├── LICENSE                             # MIT Open-Source License
├── .gitignore                          # Vivado and EDA build artifacts ignore rules
├── CONTRIBUTING.md                     # Coding guidelines and testbench standards
├── docs/
│   ├── setup-vivado.md                 # Vivado project creation and setup guide
│   ├── simulation-guide.md             # Behavioral simulation and troubleshooting guide
│   └── verilog-coding-guidelines.md   # RTL design principles and latch avoidance
├── logic-gates/
│   ├── rtl/logic_gates.v
│   ├── tb/tb_logic_gates.v
│   └── README.md
├── bitwise-operators/
│   ├── rtl/
│   │   ├── bitwise_lab.v
│   │   └── operator_lab.v
│   ├── tb/
│   │   ├── tb_bitwise_lab.v
│   │   └── tb_operator_lab.v
│   └── README.md
├── mux-2to1/
│   ├── rtl/
│   │   ├── mux2to1.v
│   │   └── mux2to1_bool.v
│   ├── tb/
│   │   ├── tb_mux2to1.v
│   │   └── tb_mux2to1_bool.v
│   └── README.md
├── mux-4to1/
│   ├── rtl/mux4to1.v
│   ├── tb/tb_mux4to1.v
│   └── README.md
├── decoder-2to4/
│   ├── rtl/decoder2to4.v
│   ├── tb/tb_decoder2to4.v
│   └── README.md
├── demux-1to4/
│   ├── rtl/demux1to4.v
│   ├── tb/tb_demux1to4.v
│   └── README.md
├── comparator-4bit-relational/
│   ├── rtl/comparator4bit.v
│   └── README.md
├── comparator-4bit-bitwise/
│   ├── rtl/comparator4bit_logic.v
│   ├── tb/tb_compare4bit.v
│   └── README.md
├── alu-4bit/
│   ├── rtl/ALU4bit.v
│   ├── tb/tb_ALU4bit.v
│   └── README.md
├── d-flip-flops/
│   ├── rtl/
│   │   ├── d_flip_flop.v
│   │   ├── dff_sync_reset.v
│   │   ├── dff_async_reset.v
│   │   └── dff_enable.v
│   ├── tb/
│   │   ├── tb_d_flip_flop.v
│   │   ├── tb_dff_sync_reset.v
│   │   ├── tb_dff_async_reset.v
│   │   └── tb_dff_enable.v
│   └── README.md
├── registers-4bit/
│   ├── rtl/
│   │   ├── register4_enable.v
│   │   ├── register4_syncreset_enable.v
│   │   └── register4_asyncreset_enable.v
│   ├── tb/
│   │   ├── tb_register4_enable.v
│   │   ├── tb_register4_syncreset_enable.v
│   │   └── tb_register4_asyncreset_enable.v
│   └── README.md
└── counters-4bit/
    ├── rtl/
    │   ├── counter4.v
    │   ├── counter4_enable.v
    │   ├── down_counter4.v
    │   └── up_down_counter.v
    ├── tb/
    │   ├── tb_counter4.v
    │   ├── tb_counter4_enable.v
    │   ├── tb_down_counter4.v
    │   └── tb_up_down_counter.v
    └── README.md
```

---

## 5. Getting Started: Opening and Simulating in Vivado

For detailed instructions, refer to [`docs/setup-vivado.md`](docs/setup-vivado.md).

### Quick GUI Workflow:
1. Open **AMD Vivado**.
2. Create an **RTL Project** (or use an existing workspace).
3. Add the desired module from its `rtl/` directory under **Design Sources**.
4. Add the corresponding testbench from its `tb/` directory under **Simulation Sources**.
5. Set the testbench as the **Top Module** in the Sources tree.
6. Click **Run Simulation -> Run Behavioral Simulation** in the Flow Navigator.

### Quick Command-Line Workflow:
Simulations can be compiled and executed directly via terminal using Vivado's native tools:
```powershell
# Example: Simulating the 4-Bit ALU
xvlog alu-4bit/rtl/ALU4bit.v alu-4bit/tb/tb_ALU4bit.v
xelab -top tb_ALU4bit -snapshot tb_alu_snap
xsim tb_alu_snap -R
```

---

## 6. Testbenches and Waveform Inspection

All testbenches in this repository are written with explicit time-delayed stimulus blocks (`initial begin ... end`) and define standard simulation timescales:
```verilog
`timescale 1ns / 1ps
```

### Inspecting Results:
- In the Vivado Waveform Viewer, click **Zoom to Fit** (`Ctrl + Shift + F`) to view the entire timeline.
- Verify that signal changes match the expected truth tables or operation tables documented in each project's individual `README.md`.
- Ensure multi-bit data buses (e.g., `out[3:0]`, `a[3:0]`) are set to the appropriate radix (Binary, Hexadecimal, or Unsigned Decimal) for straightforward visual verification.
- For in-depth simulation methodology and debugging techniques, refer to [`docs/simulation-guide.md`](docs/simulation-guide.md).
