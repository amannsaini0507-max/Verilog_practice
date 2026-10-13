# Two-to-One Multiplexer (2:1 MUX)

## 1. Objective
Design and simulate a 2-to-1 multiplexer using two distinct modeling approaches:
1. Conditional/ternary operator expression (`mux2to1`).
2. Sum-of-products Boolean logic gates (`mux2to1_bool`).

Compare both implementations within a comparative testbench environment.

---

## 2. Design Overview
A 2-to-1 multiplexer selects one of two single-bit data inputs (`a` or `b`) and directs it to the single-bit output `out` based on the binary state of control signal `sel`.

- When `sel = 0`, input `a` is routed to `out`.
- When `sel = 1`, input `b` is routed to `out`.

Two design files are provided:
- **`mux2to1.v`:** Modeled using the ternary operator `assign out = sel ? b : a;`.
- **`mux2to1_bool.v`:** Modeled using basic Boolean logic `assign out = ((~sel) & a) | (sel & b);`.

---

## 3. Input and Output Descriptions

| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| `a` | Input | 1 bit | Data input 0 (selected when `sel = 0`) |
| `b` | Input | 1 bit | Data input 1 (selected when `sel = 1`) |
| `sel` | Input | 1 bit | Selection control input |
| `out` | Output | 1 bit | Selected data output |

---

## 4. Truth Table

| `sel` | `a` | `b` | `out` | Selected Input |
| :---: | :---: | :---: | :---: | :---: |
| 0 | 0 | 0 | 0 | `a` |
| 0 | 0 | 1 | 0 | `a` |
| 0 | 1 | 0 | 1 | `a` |
| 0 | 1 | 1 | 1 | `a` |
| 1 | 0 | 0 | 0 | `b` |
| 1 | 0 | 1 | 1 | `b` |
| 1 | 1 | 0 | 0 | `b` |
| 1 | 1 | 1 | 1 | `b` |

---

## 5. Verilog Concepts Demonstrated
- Conditional operator (`? :`) for multiplexer inference.
- Boolean logic implementation using bitwise AND (`&`), OR (`|`), and NOT (`~`).
- Instantiating multiple Design Under Test (DUT) modules side-by-side in a single comparative testbench (`tb_mux2to1_bool`).

---

## 6. File Structure
```text
mux-2to1/
├── rtl/
│   ├── mux2to1.v           # 2:1 MUX using conditional operator
│   └── mux2to1_bool.v      # 2:1 MUX using Boolean logic gates
├── tb/
│   ├── tb_mux2to1.v        # Testbench for conditional MUX
│   └── tb_mux2to1_bool.v   # Comparative testbench for both implementations
└── README.md               # Project documentation
```

---

## 7. How to Run Simulation in Vivado

### Running `tb_mux2to1`:
```powershell
xvlog rtl/mux2to1.v tb/tb_mux2to1.v
xelab -top tb_mux2to1 -snapshot tb_mux2to1_snap
xsim tb_mux2to1_snap -R
```

### Running Comparative Simulation (`tb_mux2to1_bool`):
```powershell
xvlog rtl/mux2to1.v rtl/mux2to1_bool.v tb/tb_mux2to1_bool.v
xelab -top tb_mux2to1_bool -snapshot tb_mux2to1_bool_snap
xsim tb_mux2to1_bool_snap -R
```

---

## 8. Test Cases and Coverage Notes

> [!NOTE]
> The testbenches implemented here evaluate **selected test cases** to verify core switching behavior and functional equivalence; they are **not exhaustive** across all 8 possible input combinations.

### Test Cases in `tb_mux2to1`:
1. `a=0, b=1, sel=0` $\rightarrow$ `out = 0` (routes `a`)
2. `a=0, b=1, sel=1` $\rightarrow$ `out = 1` (routes `b`)
3. `a=1, b=0, sel=0` $\rightarrow$ `out = 1` (routes `a`)
4. `a=1, b=0, sel=1` $\rightarrow$ `out = 0` (routes `b`)

### Test Cases in `tb_mux2to1_bool` (Comparative):
Evaluates 5 selected input patterns simultaneously comparing `out` (`mux2to1_bool`) and `out1` (`mux2to1`):
1. `a=0, b=0, sel=0` $\rightarrow$ `out = 0, out1 = 0`
2. `a=0, b=1, sel=0` $\rightarrow$ `out = 0, out1 = 0`
3. `a=1, b=0, sel=0` $\rightarrow$ `out = 1, out1 = 1`
4. `a=1, b=0, sel=1` $\rightarrow$ `out = 0, out1 = 0`
5. `a=1, b=1, sel=1` $\rightarrow$ `out = 1, out1 = 1`

---

## 9. Actual Verification Status
- **Simulator:** AMD Vivado Simulator (`xsim v2026.1`).
- **Results:**
  - `tb_mux2to1`: **PASSED** (`$finish called at time : 40 ns`).
  - `tb_mux2to1_bool`: **PASSED** (`$finish called at time : 50 ns`). Both implementations produced identical outputs across all tested vectors.

---

## 10. Limitations or Improvements
- To achieve 100% functional test coverage, an exhaustive testbench evaluating all $2^3 = 8$ combinations of `(sel, a, b)` can be constructed using a loop or complete vector sequence.
