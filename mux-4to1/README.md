# Four-to-One Multiplexer (4:1 MUX)

## 1. Objective
Design and simulate a 4-to-1 multiplexer in Verilog HDL using nested conditional operators, and verify its selective routing across different channel inputs and select lines.

---

## 2. Design Overview
A 4-to-1 multiplexer routes one of four single-bit input lines (`i0`, `i1`, `i2`, `i3`) to a single output `out` using a 2-bit select signal (`sel[1:0]`).

The design uses a nested ternary conditional operator:
```verilog
assign out = (sel == 2'b00) ? i0 :
             (sel == 2'b01) ? i1 :
             (sel == 2'b10) ? i2 : i3;
```

---

## 3. Input and Output Descriptions

| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| `i0` | Input | 1 bit | Data input 0 |
| `i1` | Input | 1 bit | Data input 1 |
| `i2` | Input | 1 bit | Data input 2 |
| `i3` | Input | 1 bit | Data input 3 |
| `sel` | Input | 2 bits | 2-bit selection bus (`sel[1:0]`) |
| `out` | Output | 1 bit | Selected data output |

---

## 4. Operation Table

| `sel[1]` | `sel[0]` | `sel` (Binary) | Output `out` | Selected Channel |
| :---: | :---: | :---: | :---: | :---: |
| 0 | 0 | `2'b00` | `i0` | Channel 0 |
| 0 | 1 | `2'b01` | `i1` | Channel 1 |
| 1 | 0 | `2'b10` | `i2` | Channel 2 |
| 1 | 1 | `2'b11` | `i3` | Channel 3 |

---

## 5. Verilog Concepts Demonstrated
- Continuous dataflow modeling with nested conditional (`? :`) operators.
- Bus comparison with multi-bit literals (`2'b00`, `2'b01`, `2'b10`).
- Priority-free balanced multiplexer structure.

---

## 6. File Structure
```text
mux-4to1/
├── rtl/
│   └── mux4to1.v       # 4:1 MUX RTL module
├── tb/
│   └── tb_mux4to1.v    # Behavioral testbench
└── README.md           # Project documentation
```

---

## 7. How to Run Simulation in Vivado

### Command-Line Method:
```powershell
xvlog rtl/mux4to1.v tb/tb_mux4to1.v
xelab -top tb_mux4to1 -snapshot tb_mux4to1_snap
xsim tb_mux4to1_snap -R
```

### GUI Method:
1. Add `rtl/mux4to1.v` to Design Sources.
2. Add `tb/tb_mux4to1.v` to Simulation Sources.
3. Set `tb_mux4to1` as Top module.
4. Run Behavioral Simulation and view waveform.

---

## 8. Test Cases and Coverage Notes

> [!NOTE]
> An exhaustive verification of a 4:1 multiplexer with 4 data inputs and 2 select lines requires evaluating $2^{(4+2)} = 2^6 = 64$ distinct input vectors. The existing testbench evaluates **16 selected test cases** across the 0–160 ns time window to verify data routing across all 4 channels.

### Summary of Selected Test Cases in `tb_mux4to1`:
- **Vectors 1–4 ($0\text{–}40\text{ ns}$):** Tests various input vectors with `sel` set to `00`, `01`, `10`, and `00`.
- **Vectors 5–8 ($40\text{–}80\text{ ns}$):** Tests single-bit activations on `i1`, `i2`, `i3` with alternating selections.
- **Vectors 9–12 ($80\text{–}120\text{ ns}$):** Sets `i0 = 1` while varying other inputs and select lines (`sel = 10, 00, 01, 00`).
- **Vectors 13–16 ($120\text{–}160\text{ ns}$):** Tests multiple high inputs simultaneously across selections `11, 01, 10, 01`.
- **At $T = 160\text{ ns}$:** Test terminates via `$finish`.

In every tested state, `out` faithfully tracks the channel dictated by `sel`.

---

## 9. Actual Verification Status
- **Simulator:** AMD Vivado Simulator (`xsim v2026.1`).
- **Result:** **PASSED**.
- **Execution Log:** `$finish called at time : 160 ns : File "tb_mux4to1.v" Line 27`.

---

## 10. Limitations or Improvements
- Can be extended to an exhaustive 64-case testbench using a `for` loop in the testbench.
- In behavioral Verilog, a 4:1 multiplexer can alternatively be modeled using an `always @(*)` block with a `case(sel)` statement.
