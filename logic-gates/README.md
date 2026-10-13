# Basic Logic Gates

## 1. Objective
Implement fundamental two-input logic gates (AND, OR, XOR, NAND, NOR) and a single-input inverter (NOT) in Verilog HDL using continuous dataflow assignments, and verify their truth tables via simulation.

---

## 2. Design Overview
The `logic_gates` module models elementary digital logic operations concurrently using Verilog's built-in bitwise operators. All six outputs respond immediately to transitions on inputs `a` and `b`.

---

## 3. Input and Output Descriptions

| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| `a` | Input | 1 bit | Primary logic input A |
| `b` | Input | 1 bit | Primary logic input B |
| `y_and` | Output | 1 bit | Bitwise AND: `a & b` |
| `y_or` | Output | 1 bit | Bitwise OR: `a \| b` |
| `y_not` | Output | 1 bit | Bitwise NOT: `~a` (inversion of input `a`) |
| `y_xor` | Output | 1 bit | Bitwise XOR: `a ^ b` |
| `y_nand` | Output | 1 bit | Bitwise NAND: `~(a & b)` |
| `y_nor` | Output | 1 bit | Bitwise NOR: `~(a \| b)` |

---

## 4. Truth Table

| `a` | `b` | `y_and` (`a & b`) | `y_or` (`a \| b`) | `y_not` (`~a`) | `y_xor` (`a ^ b`) | `y_nand` (`~(a & b)`) | `y_nor` (`~(a \| b)`) |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 0 | 0 | 0 | 0 | 1 | 0 | 1 | 1 |
| 0 | 1 | 0 | 1 | 1 | 1 | 1 | 0 |
| 1 | 0 | 0 | 1 | 0 | 1 | 1 | 0 |
| 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 |

---

## 5. Verilog Concepts Demonstrated
- Dataflow modeling with continuous assignment (`assign`).
- Net data types (`wire`).
- Bitwise operators: `&`, `|`, `~`, `^`.
- Complete combinational output assignment with zero latch inference.

---

## 6. File Structure
```text
logic-gates/
├── rtl/
│   └── logic_gates.v       # Top RTL module
├── tb/
│   └── tb_logic_gates.v    # Behavioral testbench
└── README.md               # Project documentation
```

---

## 7. How to Run Simulation in Vivado

### GUI Method:
1. Open or create a project in Vivado.
2. Add `rtl/logic_gates.v` as a **Design Source**.
3. Add `tb/tb_logic_gates.v` as a **Simulation Source**.
4. In the Sources window, right-click `tb_logic_gates` and select **Set as Top**.
5. Click **Run Simulation -> Run Behavioral Simulation**.
6. Inspect the resulting waveform across the 0–40 ns interval.

### Command-Line Method (Vivado Tools):
```powershell
xvlog rtl/logic_gates.v tb/tb_logic_gates.v
xelab -top tb_logic_gates -snapshot tb_logic_gates_snap
xsim tb_logic_gates_snap -R
```

---

## 8. Test Cases and Expected Behavior

The testbench sequentially cycles through all $2^2 = 4$ input combinations with `#10` ns delay between each vector:

1. **At $T = 0\text{ ns}$ (`a=0, b=0`):** `y_and=0, y_or=0, y_not=1, y_xor=0, y_nand=1, y_nor=1`
2. **At $T = 10\text{ ns}$ (`a=0, b=1`):** `y_and=0, y_or=1, y_not=1, y_xor=1, y_nand=1, y_nor=0`
3. **At $T = 20\text{ ns}$ (`a=1, b=0`):** `y_and=0, y_or=1, y_not=0, y_xor=1, y_nand=1, y_nor=0`
4. **At $T = 30\text{ ns}$ (`a=1, b=1`):** `y_and=1, y_or=1, y_not=0, y_xor=0, y_nand=0, y_nor=0`
5. **At $T = 40\text{ ns}$:** Simulation terminates via `$finish`.

---

## 9. Actual Verification Status
- **Simulator:** AMD Vivado Simulator (`xsim v2026.1`).
- **Result:** **PASSED**.
- **Execution Log:** `$finish called at time : 40 ns : File "tb_logic_gates.v" Line 18`. All output logic states match the truth table across all 4 input combinations.

---

## 10. Limitations or Improvements
- The current implementation of `y_not` inverts input `a`. To invert input `b` as well, an additional output (e.g., `y_not_b`) could be added.
