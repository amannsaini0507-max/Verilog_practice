# Two-to-Four Decoder with Active-High Enable

## 1. Objective
Design and simulate a 2-to-4 binary line decoder featuring an active-high enable input using behavioral Verilog (`always @(*)`, `if-else`, and `case`).

---

## 2. Design Overview
A 2-to-4 decoder decodes a 2-bit binary code into one of four mutually exclusive active-high outputs (`y[3:0]`). When the enable control line `en` is deasserted (`en = 0`), all outputs are forced to `0000` regardless of the address input. When `en = 1`, exactly one output bit corresponding to the binary value of `a[1:0]` is driven high (`1`).

---

## 3. Input and Output Descriptions

| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| `a` | Input | 2 bits | 2-bit binary input address (`a[1:0]`) |
| `en` | Input | 1 bit | Active-high enable control signal |
| `y` | Output | 4 bits | 4-bit decoded one-hot output bus (`y[3:0]`) |

---

## 4. Truth Table

| `en` | `a[1]` | `a[0]` | `y[3]` | `y[2]` | `y[1]` | `y[0]` | Output (`y[3:0]`) |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 0 | X | X | 0 | 0 | 0 | 0 | `4'b0000` (Disabled) |
| 1 | 0 | 0 | 0 | 0 | 0 | 1 | `4'b0001` (Line 0 active) |
| 1 | 0 | 1 | 0 | 0 | 1 | 0 | `4'b0010` (Line 1 active) |
| 1 | 1 | 0 | 0 | 1 | 0 | 0 | `4'b0100` (Line 2 active) |
| 1 | 1 | 1 | 1 | 0 | 0 | 0 | `4'b1000` (Line 3 active) |

---

## 5. Verilog Concepts Demonstrated
- Combinational procedural modeling with `always @(*)`.
- Hierarchical control flow using `if-else` for master enable detection.
- Multi-way branching using `case(a) ... endcase`.
- Procedural output variable declaration (`output reg [3:0] y`).

---

## 6. File Structure
```text
decoder-2to4/
├── rtl/
│   └── decoder2to4.v       # 2-to-4 decoder RTL module
├── tb/
│   └── tb_decoder2to4.v    # Behavioral testbench
└── README.md               # Project documentation
```

---

## 7. How to Run Simulation in Vivado

### Command-Line Method:
```powershell
xvlog rtl/decoder2to4.v tb/tb_decoder2to4.v
xelab -top tb_decoder2to4 -snapshot tb_decoder2to4_snap
xsim tb_decoder2to4_snap -R
```

### GUI Method:
1. Add `rtl/decoder2to4.v` to Design Sources.
2. Add `tb/tb_decoder2to4.v` to Simulation Sources.
3. Set `tb_decoder2to4` as Top module.
4. Run Behavioral Simulation.

---

## 8. Test Cases and Expected Behavior

The testbench systematically verifies both disabled and enabled modes:
1. **At $T = 0\text{ ns}$ (`en = 0, a = 2'bxx`):** `y = 4'b0000` (Disabled state verifies don't-care input immunity).
2. **At $T = 10\text{ ns}$ (`en = 1, a = 2'b00`):** `y = 4'b0001`.
3. **At $T = 20\text{ ns}$ (`en = 1, a = 2'b01`):** `y = 4'b0010`.
4. **At $T = 30\text{ ns}$ (`en = 1, a = 2'b10`):** `y = 4'b0100`.
5. **At $T = 40\text{ ns}$ (`en = 1, a = 2'b11`):** `y = 4'b1000`.
6. **At $T = 50\text{ ns}$:** Simulation terminates via `$finish`.

---

## 9. Actual Verification Status
- **Simulator:** AMD Vivado Simulator (`xsim v2026.1`).
- **Result:** **PASSED**.
- **Execution Log:** `$finish called at time : 50 ns : File "tb_decoder2to4.v" Line 16`.

---

## 10. Limitations or Improvements
- While all 4 valid 2-bit binary combinations (`00`, `01`, `10`, `11`) are covered in `case(a)`, good coding practice recommends adding an explicit `default: y = 4'b0000;` branch to prevent latch inference if an uninitialized `2'bxx` or `2'bzz` arrives while `en == 1`.
