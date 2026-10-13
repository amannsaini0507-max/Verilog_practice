# 4-Bit Magnitude Comparator (Relational Operators)

## 1. Objective
Implement a 4-bit unsigned magnitude comparator in Verilog HDL using standard built-in relational operators (`<`, `>`, `==`) to evaluate greater-than, less-than, and equal relationships between two 4-bit numbers.

---

## 2. Design Overview
A digital magnitude comparator compares two binary words $A$ and $B$ and asserts one of three mutually exclusive status flags:
- $A > B$ (`a_gt_b`)
- $A < B$ (`a_lt_b`)
- $A == B$ (`a_eq_b`)

In this module (`comparator4bit`), the comparison logic is modeled compactly using Verilog's native relational continuous assignments:
```verilog
assign a_lt_b = (a < b);
assign a_gt_b = (a > b);
assign a_eq_b = (a == b);
```

---

## 3. Input and Output Descriptions

| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| `a` | Input | 4 bits | 4-bit unsigned input operand $A$ (`a[3:0]`) |
| `b` | Input | 4 bits | 4-bit unsigned input operand $B$ (`b[3:0]`) |
| `a_gt_b` | Output | 1 bit | Asserted high when $A > B$ |
| `a_lt_b` | Output | 1 bit | Asserted high when $A < B$ |
| `a_eq_b` | Output | 1 bit | Asserted high when $A == B$ |

---

## 4. Operation Table

| Condition | `a_gt_b` | `a_lt_b` | `a_eq_b` |
| :---: | :---: | :---: | :---: |
| $A > B$ | 1 | 0 | 0 |
| $A < B$ | 0 | 1 | 0 |
| $A == B$ | 0 | 0 | 1 |

---

## 5. Verilog Concepts Demonstrated
- Relational operators in Verilog: `<` (less than), `>` (greater than), and `==` (equality).
- Unsigned evaluation semantics on vector nets (`wire [3:0]`).
- Clean dataflow modeling with concurrent `assign` statements.

---

## 6. File Structure
```text
comparator-4bit-relational/
├── rtl/
│   └── comparator4bit.v    # 4-bit relational comparator RTL module
└── README.md               # Project documentation
```

---

## 7. How to Run in Vivado
To simulate this module in Vivado, a testbench instantiating `comparator4bit` is required:
1. Add `rtl/comparator4bit.v` to Design Sources in Vivado.
2. Create and add a simulation source (such as `tb_comparator4bit.v`).
3. Set the testbench as Top and run behavioral simulation.

---

## 8. Test Cases and Expected Behavior

| Test Vector ($A, B$) | Decimal Equivalent | Expected `a_gt_b` | Expected `a_lt_b` | Expected `a_eq_b` |
| :---: | :---: | :---: | :---: | :---: |
| `a = 4'b0010, b = 4'b0101` | $2 < 5$ | 0 | 1 | 0 |
| `a = 4'b1000, b = 4'b0011` | $8 > 3$ | 1 | 0 | 0 |
| `a = 4'b0110, b = 4'b0110` | $6 == 6$ | 0 | 0 | 1 |
| `a = 4'b0000, b = 4'b1111` | $0 < 15$ | 0 | 1 | 0 |
| `a = 4'b1111, b = 4'b0000` | $15 > 0$ | 1 | 0 | 0 |

---

## 9. Actual Verification Status
- **Testbench Availability:** **Missing from original student workspace**.
- **Status:** **Unverified via simulation**.
- In the original Vivado workspace, the student authored the RTL for `comparator4bit` (in `comparator4bit.v`), but created a testbench only for the bitwise comparator (`tb_compare4bit.v` instantiating `comparator4bit_logic`). Per repository guidelines to strictly preserve authentic student work without fabricating source files, no synthetic testbench was generated, and this design remains unsimulated.

---

## 10. Relationship to `comparator-4bit-bitwise`
This design represents the high-level behavioral equivalent of `comparator-4bit-bitwise`, which implements the exact same functional specification using explicit bit-by-bit MSB-first priority logic.
