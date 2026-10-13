# 4-Bit Magnitude Comparator (Bitwise Logic & MSB-First Priority)

## 1. Objective
Design and simulate a 4-bit unsigned magnitude comparator in Verilog HDL using bitwise logic operations (`^`, `~`, `&`) and an MSB-first priority inspection chain, avoiding high-level relational operators (`<`, `>`).

---

## 2. Design Overview
Magnitude comparison of two $N$-bit binary numbers $A$ and $B$ can be derived by inspecting bit pairs from the Most Significant Bit (MSB, bit 3) to the Least Significant Bit (LSB, bit 0):

1. **Bit Inequality Detection:** For any bit position $i$, `a[i] ^ b[i]` is `1` if and only if `a[i] != b[i]`.
2. **Priority Chain:** Comparison starts at bit 3:
   - If `a[3] != b[3]`, the result is decided immediately:
     - If `~a[3] & b[3]` is `1` (i.e., $a[3]=0, b[3]=1$), then $A < B$.
     - Otherwise ($a[3]=1, b[3]=0$), $A > B$.
     - In both cases, $A == B$ is `0`.
   - If `a[3] == b[3]`, the comparator evaluates bit 2, then bit 1, then bit 0 in sequential priority order.
3. **Equality Fallback:** If all four bit pairs are identical (`a[i] ^ b[i] == 0` for all $i \in [3, 0]$), the `else` branch asserts `a_eq_b = 1` and deasserts `a_gt_b` and `a_lt_b`.

---

## 3. Input and Output Descriptions

| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| `a` | Input | 4 bits | 4-bit unsigned input operand $A$ (`a[3:0]`) |
| `b` | Input | 4 bits | 4-bit unsigned input operand $B$ (`b[3:0]`) |
| `a_gt_b` | Output | 1 bit | Asserted high (`1`) when $A > B$ |
| `a_lt_b` | Output | 1 bit | Asserted high (`1`) when $A < B$ |
| `a_eq_b` | Output | 1 bit | Asserted high (`1`) when $A == B$ |

---

## 4. Priority Decision Table

| Bit Comparison Condition | Outcome | `a_gt_b` | `a_lt_b` | `a_eq_b` |
| :--- | :--- | :---: | :---: | :---: |
| `a[3] ^ b[3] == 1` | Determined by `~a[3] & b[3]` | If 0 $\rightarrow$ 1, else 0 | If 1 $\rightarrow$ 1, else 0 | 0 |
| `a[3]==b[3]` and `a[2] ^ b[2] == 1` | Determined by `~a[2] & b[2]` | If 0 $\rightarrow$ 1, else 0 | If 1 $\rightarrow$ 1, else 0 | 0 |
| `a[3:2]==b[3:2]` and `a[1] ^ b[1] == 1` | Determined by `~a[1] & b[1]` | If 0 $\rightarrow$ 1, else 0 | If 1 $\rightarrow$ 1, else 0 | 0 |
| `a[3:1]==b[3:1]` and `a[0] ^ b[0] == 1` | Determined by `~a[0] & b[0]` | If 0 $\rightarrow$ 1, else 0 | If 1 $\rightarrow$ 1, else 0 | 0 |
| `a[3:0] == b[3:0]` (All bits match) | Operands are identical | 0 | 0 | 1 |

---

## 5. Verilog Concepts Demonstrated
- Procedural combinational modeling with `always @(*)`.
- MSB-first priority decoding using `if-else if-else` cascaded branching.
- Using XOR (`^`) for inequality detection and AND-NOT (`~a & b`) for less-than evaluation.
- Ensuring every output (`a_gt_b`, `a_lt_b`, `a_eq_b`) is explicitly driven on every execution path to prevent latch inference.

---

## 6. File Structure
```text
comparator-4bit-bitwise/
├── rtl/
│   └── comparator4bit_logic.v  # Bitwise MSB-first comparator RTL module
├── tb/
│   └── tb_compare4bit.v        # Behavioral testbench
└── README.md                   # Project documentation
```

---

## 7. How to Run Simulation in Vivado

### Command-Line Method:
```powershell
xvlog rtl/comparator4bit_logic.v tb/tb_compare4bit.v
xelab -top tb_compare4bit -snapshot tb_compare4bit_snap
xsim tb_compare4bit_snap -R
```

### GUI Method:
1. Add `rtl/comparator4bit_logic.v` to Design Sources.
2. Add `tb/tb_compare4bit.v` to Simulation Sources.
3. Set `tb_compare4bit` as Top module.
4. Run Behavioral Simulation.

---

## 8. Test Cases and Expected Behavior

The testbench (`tb_compare4bit.v`) evaluates 6 specific vectors:
1. **$T = 0\text{–}10\text{ ns}$ (`a = 4'b0010, b = 4'b0101`):** $2 < 5 \rightarrow$ `a_gt_b=0, a_lt_b=1, a_eq_b=0`.
2. **$T = 10\text{–}20\text{ ns}$ (`a = 4'b1000, b = 4'b0011`):** $8 > 3 \rightarrow$ `a_gt_b=1, a_lt_b=0, a_eq_b=0`.
3. **$T = 20\text{–}30\text{ ns}$ (`a = 4'b0110, b = 4'b0110`):** $6 == 6 \rightarrow$ `a_gt_b=0, a_lt_b=0, a_eq_b=1`.
4. **$T = 30\text{–}40\text{ ns}$ (`a = 4'b0000, b = 4'b1111`):** $0 < 15 \rightarrow$ `a_gt_b=0, a_lt_b=1, a_eq_b=0`.
5. **$T = 40\text{–}50\text{ ns}$ (`a = 4'b1111, b = 4'b0000`):** $15 > 0 \rightarrow$ `a_gt_b=1, a_lt_b=0, a_eq_b=0`.
6. **$T = 50\text{–}60\text{ ns}$ (`a = 4'b1010, b = 4'b1011`):** $10 < 11 \rightarrow$ `a_gt_b=0, a_lt_b=1, a_eq_b=0`.
7. **At $T = 60\text{ ns}$:** Simulation terminates via `$finish`.

---

## 9. Actual Verification Status
- **Simulator:** AMD Vivado Simulator (`xsim v2026.1`).
- **Result:** **PASSED**.
- **Execution Log:** `$finish called at time : 60 ns : File "tb_compare4bit.v" Line 16`. All flags match expected results across all test intervals.

---

## 10. Limitations or Improvements
- In the original student workspace, this module was co-located in the same file as `comparator4bit`. It has been extracted to `rtl/comparator4bit_logic.v` to keep module and file naming consistent across the repository without altering any internal code logic.
