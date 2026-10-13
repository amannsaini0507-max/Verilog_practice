# Contributing to verilog-practice

Thank you for your interest in contributing to this repository. This codebase serves as an academic and practical portfolio of digital logic designs written in Verilog HDL and simulated using AMD Xilinx Vivado.

---

## 1. Scope & Guidelines

- **Focus:** This repository is focused strictly on fundamental combinational and small-scale digital blocks implemented as part of undergraduate coursework and lab practice.
- **Academic Integrity:** All contributions should represent genuine educational implementations. Do not include unverified designs or third-party intellectual property without proper attribution.

---

## 2. Verilog Coding Style

All RTL files must adhere to the **Verilog-2001 (IEEE 1364-2001)** standard to maintain maximum compatibility with Vivado and standard synthesis tools:

1. **Port Declarations:**
   - Use ANSI C-style port declarations directly in the module header:
     ```verilog
     module example_module (
         input  wire [3:0] a,
         input  wire [3:0] b,
         output reg  [3:0] y
     );
     ```
   - Explicitly declare port directions (`input`, `output`) and net/variable types (`wire`, `reg`).

2. **Combinational Logic Rules:**
   - For continuous assignments, use dataflow `assign` statements:
     ```verilog
     assign y = a & b;
     ```
   - For procedural combinational blocks, use `always @(*)` to ensure an exhaustive and automatic sensitivity list:
     ```verilog
     always @(*) begin
         // Combinational logic here
     end
     ```
   - Always assign values to all outputs under every conditional branch (`if-else`, `case`) to prevent unintended latch inference.
   - Include a `default` case in every `case` statement.
   - Use **blocking assignments (`=`)** exclusively inside combinational blocks.

3. **Sequential Logic Rules:**
   - Use **non-blocking assignments (`<=`)** inside clocked sequential blocks (`always @(posedge clk)`).
   - Never mix blocking (`=`) and non-blocking (`<=`) assignments within the same procedural block.

4. **Naming Conventions:**
   - Use lowercase letters with underscores (snake_case) or standard camelCase for module and signal names consistently.
   - File names must match the top-level module name defined inside the file (e.g., module `decoder2to4` is stored in `decoder2to4.v`).

---

## 3. Testbench Conventions

Testbenches provide automated behavioral verification of RTL modules:

1. **Timescale:** Every testbench must begin with a timescale directive:
   ```verilog
   `timescale 1ns / 1ps
   ```
2. **Ports & Interconnects:**
   - Inputs to the Device Under Test (DUT) must be declared as `reg`.
   - Outputs from the DUT must be declared as `wire`.
   - DUT instantiation should use explicit named port connections:
     ```verilog
     example_module uut (
         .a(a),
         .b(b),
         .y(y)
     );
     ```
3. **Stimulus Application:**
   - Encapsulate stimulus within an `initial begin ... end` block.
   - Provide adequate propagation delay (e.g., `#10;`) between stimulus changes to allow combinational outputs to settle and facilitate clear waveform inspection.
   - Always terminate testbench execution explicitly using `$finish;`.
4. **Accuracy:**
   - Clearly document test coverage. If a testbench verifies selected vectors rather than the entire input space, state this accurately in the documentation.

---

## 4. Directory Organization

Keep the repository organized by module:
```text
<project-name>/
├── rtl/
│   └── <module_name>.v
├── tb/
│   └── tb_<module_name>.v
└── README.md
```
Documentation files belong in `docs/`.
