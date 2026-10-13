# One-to-Four Demultiplexer (1:4 DEMUX)

## 1. Objective
Design and simulate a 1-to-4 demultiplexer in Verilog HDL to steer a single-bit data input `d` onto one of four output channels determined by a 2-bit select code `sel[1:0]`.

---

## 2. Design Overview
A demultiplexer performs the inverse operation of a multiplexer. It takes a single data input `d` and transmits it across one of four output lines (`y[3:0]`). When the data input is low (`d = 0`), all output lines remain `0`. When `d = 1`, the selected output line transitions to `1` while all unselected lines remain grounded at `0`.

The design is implemented using a combinational procedural block (`always @(*)`) with nested `if-else` and `case` constructs, complete with a `default` case.

---

## 3. Input and Output Descriptions

| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| `d` | Input | 1 bit | Single-bit serial data input |
| `sel` | Input | 2 bits | 2-bit channel selection address (`sel[1:0]`) |
| `y` | Output | 4 bits | 4-bit demultiplexed output bus (`y[3:0]`) |

---

## 4. Operation Table

| Data Input `d` | `sel[1]` | `sel[0]` | `y[3]` | `y[2]` | `y[1]` | `y[0]` | Active Channel |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 0 | X | X | 0 | 0 | 0 | 0 | None (All channels 0) |
| 1 | 0 | 0 | 0 | 0 | 0 | 1 | Channel 0 (`y[0] = d`) |
| 1 | 0 | 1 | 0 | 0 | 1 | 0 | Channel 1 (`y[1] = d`) |
| 1 | 1 | 0 | 0 | 1 | 0 | 0 | Channel 2 (`y[2] = d`) |
| 1 | 1 | 1 | 1 | 0 | 0 | 0 | Channel 3 (`y[3] = d`) |

---

## 5. Verilog Concepts Demonstrated
- Procedural combinational design with `always @(*)`.
- Combinational data steering.
- Fully specified `case(sel)` with an explicit `default` fallback, guaranteeing latch-free synthesis.

---

## 6. File Structure
```text
demux-1to4/
├── rtl/
│   └── demux1to4.v       # 1-to-4 demultiplexer RTL module
├── tb/
│   └── tb_demux1to4.v    # Behavioral testbench
└── README.md             # Project documentation
```

---

## 7. How to Run Simulation in Vivado

### Command-Line Method:
```powershell
xvlog rtl/demux1to4.v tb/tb_demux1to4.v
xelab -top tb_demux1to4 -snapshot tb_demux1to4_snap
xsim tb_demux1to4_snap -R
```

### GUI Method:
1. Add `rtl/demux1to4.v` to Design Sources.
2. Add `tb/tb_demux1to4.v` to Simulation Sources.
3. Set `tb_demux1to4` as Top module.
4. Run Behavioral Simulation.

---

## 8. Test Cases and Expected Behavior

The testbench applies 7 successive stimulus patterns:
1. **$T = 0\text{–}10\text{ ns}$ (`d = 0, sel = 00`):** `y = 4'b0000` (Data low).
2. **$T = 10\text{–}20\text{ ns}$ (`d = 1, sel = 00`):** `y = 4'b0001` (Routed to bit 0).
3. **$T = 20\text{–}30\text{ ns}$ (`d = 1, sel = 01`):** `y = 4'b0010` (Routed to bit 1).
4. **$T = 30\text{–}40\text{ ns}$ (`d = 1, sel = 10`):** `y = 4'b0100` (Routed to bit 2).
5. **$T = 40\text{–}50\text{ ns}$ (`d = 1, sel = 11`):** `y = 4'b1000` (Routed to bit 3).
6. **$T = 50\text{–}60\text{ ns}$ (`d = 0, sel = 10`):** `y = 4'b0000` (Data de-assertion).
7. **$T = 60\text{–}70\text{ ns}$ (`d = 0, sel = 11`):** `y = 4'b0000` (Data de-assertion).
8. **At $T = 70\text{ ns}$:** Simulation terminates via `$finish`.

---

## 9. Actual Verification Status
- **Simulator:** AMD Vivado Simulator (`xsim v2026.1`).
- **Result:** **PASSED**.
- **Execution Log:** `$finish called at time : 70 ns : File "tb_demux1to4.v" Line 18`.

---

## 10. Limitations or Improvements
- In applications requiring active-low outputs or multi-bit data buses, the design can be parameterized with a configurable data width `WIDTH`.
