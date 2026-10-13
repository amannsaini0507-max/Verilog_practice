# Bitwise & Logical Operators

## 1. Objective
1. Demonstrate multi-bit (4-bit) bitwise operations (AND, OR, XOR, NOT) using vector signals (`bitwise_lab`).
2. Clearly contrast bitwise operators (`&`) against logical boolean operators (`&&`) and equality comparison (`==`) in Verilog HDL (`operator_lab`).

---

## 2. Design Overview

This project is divided into two focused modules:

1. **`bitwise_lab`**: Applies bitwise operators bit-by-bit across 4-bit bus inputs `a[3:0]` and `b[3:0]`, producing four 4-bit output buses (`y_and`, `y_or`, `y_xor`, `y_not_a`).
2. **`operator_lab`**: Directly compares the output of a 4-bit bitwise operation (`bitwise_and = a & b`) with a 1-bit logical truth evaluation (`logical_and = a && b`) and an equality test (`equal = (a == b)`).

---

## 3. Input and Output Descriptions

### Module 1: `bitwise_lab`
| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| `a` | Input | 4 bits | 4-bit operand bus A |
| `b` | Input | 4 bits | 4-bit operand bus B |
| `y_and` | Output | 4 bits | Bit-by-bit AND: `a & b` |
| `y_or` | Output | 4 bits | Bit-by-bit OR: `a \| b` |
| `y_xor` | Output | 4 bits | Bit-by-bit XOR: `a ^ b` |
| `y_not_a` | Output | 4 bits | Bit-by-bit NOT of operand A: `~a` |

### Module 2: `operator_lab`
| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| `a` | Input | 4 bits | 4-bit operand bus A |
| `b` | Input | 4 bits | 4-bit operand bus B |
| `bitwise_and` | Output | 4 bits | 4-bit bitwise AND: `a & b` |
| `logical_and` | Output | 1 bit | 1-bit boolean truth value: `a && b` |
| `equal` | Output | 1 bit | 1-bit equality comparison: `(a == b)` |

---

## 4. Operation Tables

### Bitwise Operations (`bitwise_lab`)
| Vector A | Vector B | `y_and` (`a & b`) | `y_or` (`a \| b`) | `y_xor` (`a ^ b`) | `y_not_a` (`~a`) |
| :---: | :---: | :---: | :---: | :---: | :---: |
| `1010` | `1100` | `1000` | `1110` | `0110` | `0101` |
| `0110` | `0011` | `0010` | `0111` | `0101` | `1001` |

### Bitwise vs. Logical vs. Equality (`operator_lab`)
| Vector A | Vector B | Is A True? | Is B True? | `bitwise_and` (`a & b`) | `logical_and` (`a && b`) | `equal` (`a == b`) |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| `0000` | `1010` | False (`0`) | True (`1`) | `0000` | `0` | `0` |
| `1010` | `1100` | True (`1`) | True (`1`) | `1000` | `1` | `0` |
| `1010` | `1010` | True (`1`) | True (`1`) | `1010` | `1` | `1` |

---

## 5. Verilog Concepts Demonstrated
- Multi-bit vector bus declarations (`[3:0]`).
- The fundamental difference between **bitwise operators** (`&`, `|`, `~`, `^`) which preserve operand bit-widths and operate positionally, and **logical operators** (`&&`, `||`, `!`) which evaluate the truth value of operands as whole entities (`0` is false, any non-zero is true) returning a 1-bit scalar result.
- Relational equality operator (`==`).

---

## 6. File Structure
```text
bitwise-operators/
├── rtl/
│   ├── bitwise_lab.v       # 4-bit bitwise operations RTL
│   └── operator_lab.v      # Bitwise vs logical operator comparison RTL
├── tb/
│   ├── tb_bitwise_lab.v    # Testbench for bitwise_lab
│   └── tb_operator_lab.v   # Testbench for operator_lab
└── README.md               # Project documentation
```

---

## 7. How to Run Simulation in Vivado

### Simulating `bitwise_lab`:
```powershell
xvlog rtl/bitwise_lab.v tb/tb_bitwise_lab.v
xelab -top tb_bitwise_lab -snapshot tb_bitwise_lab_snap
xsim tb_bitwise_lab_snap -R
```

### Simulating `operator_lab`:
```powershell
xvlog rtl/operator_lab.v tb/tb_operator_lab.v
xelab -top tb_operator_lab -snapshot tb_operator_lab_snap
xsim tb_operator_lab_snap -R
```

---

## 8. Test Cases and Expected Behavior

### `tb_bitwise_lab`:
- **Vector 1 ($0\text{–}10\text{ ns}$):** `a = 4'b1010, b = 4'b1100`  
  Expected: `y_and = 4'b1000`, `y_or = 4'b1110`, `y_xor = 4'b0110`, `y_not_a = 4'b0101`.
- **Vector 2 ($10\text{–}20\text{ ns}$):** `a = 4'b0110, b = 4'b0011`  
  Expected: `y_and = 4'b0010`, `y_or = 4'b0111`, `y_xor = 4'b0101`, `y_not_a = 4'b1001`.
- **At $T = 20\text{ ns}$:** Test terminates via `$finish`.

### `tb_operator_lab`:
- **Vector 1 ($0\text{–}10\text{ ns}$):** `a = 4'b0000, b = 4'b1010`  
  Expected: `bitwise_and = 4'b0000`, `logical_and = 1'b0`, `equal = 1'b0`.
- **Vector 2 ($10\text{–}20\text{ ns}$):** `a = 4'b1010, b = 4'b1100`  
  Expected: `bitwise_and = 4'b1000`, `logical_and = 1'b1`, `equal = 1'b0`.
- **Vector 3 ($20\text{–}30\text{ ns}$):** `a = 4'b1010, b = 4'b1010`  
  Expected: `bitwise_and = 4'b1010`, `logical_and = 1'b1`, `equal = 1'b1`.
- **At $T = 30\text{ ns}$:** Test terminates via `$finish`.

---

## 9. Actual Verification Status
- **Simulator:** AMD Vivado Simulator (`xsim v2026.1`).
- **Results:**
  - `bitwise_lab`: **PASSED** (`$finish called at time : 20 ns`).
  - `operator_lab`: **PASSED** (`$finish called at time : 30 ns`).

---

## 10. Limitations or Improvements
- These testbenches use selected targeted vectors rather than exhaustive 256-combination verification.
