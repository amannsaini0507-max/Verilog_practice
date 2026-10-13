# Four-Bit Arithmetic Logic Unit (4-Bit ALU)

## 1. Objective
Design and simulate a 4-bit Arithmetic Logic Unit (ALU) in Verilog HDL supporting four core operations: addition, subtraction, bitwise AND, and bitwise XOR. The ALU generates a 4-bit result, an unsigned addition carry-out flag, and a zero flag computed from the final 4-bit output.

---

## 2. Design Overview
The 4-bit ALU accepts two 4-bit data operands (`a[3:0]` and `b[3:0]`) and a 2-bit operation selector (`sel[1:0]`).

### Flag Architecture:
1. **Unsigned Addition Carry Flag (`carry`):**
   - The addition operation pads both operands with a leading zero to perform a 5-bit addition:
     ```verilog
     reg [4:0] sum;
     sum = {1'b0, a} + {1'b0, b};
     out = sum[3:0];
     carry = sum[4];
     ```
   - For all other operations (subtraction, bitwise AND, bitwise XOR, and default), `carry` is explicitly driven to `1'b0`. Thus, `carry` specifically indicates an arithmetic overflow during unsigned addition.
2. **Zero Flag (`zero`):**
   - Evaluated directly on the final 4-bit output bus `out[3:0]`:
     ```verilog
     if (out == 4'b0000)
         zero = 1;
     else
         zero = 0;
     ```
   - Asserts high (`1`) whenever all four bits of the operation result are zero.

---

## 3. Input and Output Descriptions

| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| `a` | Input | 4 bits | 4-bit operand $A$ (`a[3:0]`) |
| `b` | Input | 4 bits | 4-bit operand $B$ (`b[3:0]`) |
| `sel` | Input | 2 bits | 2-bit operation opcode (`sel[1:0]`) |
| `out` | Output | 4 bits | 4-bit ALU computation result (`out[3:0]`) |
| `carry` | Output | 1 bit | Unsigned addition carry-out flag (`sum[4]`) |
| `zero` | Output | 1 bit | Zero flag (asserts when `out == 4'b0000`) |

---

## 4. Operation Table

| `sel[1:0]` | Operation | RTL Expression | `carry` Flag Behavior | `zero` Flag Behavior |
| :---: | :--- | :--- | :--- | :--- |
| `2'b00` | **Addition** | `out = a + b` | `carry = sum[4]` (1 if $A+B \ge 16$) | `1` if `out == 4'b0000`, else `0` |
| `2'b01` | **Subtraction** | `out = a - b` | `carry = 1'b0` | `1` if `out == 4'b0000`, else `0` |
| `2'b10` | **Bitwise AND** | `out = a & b` | `carry = 1'b0` | `1` if `out == 4'b0000`, else `0` |
| `2'b11` | **Bitwise XOR** | `out = a ^ b` | `carry = 1'b0` | `1` if `out == 4'b0000`, else `0` |
| `default`| Fallback | `out = 4'b0000` | `carry = 1'b0` | `zero = 1` |

---

## 5. Verilog Concepts Demonstrated
- Using an intermediate 5-bit register (`sum`) with concatenation (`{1'b0, a}`) to prevent arithmetic width truncation and preserve the carry bit.
- Combinational `always @(*)` procedural block using `case(sel)` with an explicit `default` branch.
- Post-computation flag derivation (`zero`) based on the final bus value.
- Strict assignment of all output registers across every path to avoid latch inference.

---

## 6. File Structure
```text
alu-4bit/
├── rtl/
│   └── ALU4bit.v       # 4-bit ALU RTL module
├── tb/
│   └── tb_ALU4bit.v    # Behavioral testbench
└── README.md           # Project documentation
```

---

## 7. How to Run Simulation in Vivado

### Command-Line Method:
```powershell
xvlog rtl/ALU4bit.v tb/tb_ALU4bit.v
xelab -top tb_ALU4bit -snapshot tb_ALU4bit_snap
xsim tb_ALU4bit_snap -R
```

### GUI Method:
1. Add `rtl/ALU4bit.v` to Design Sources.
2. Add `tb/tb_ALU4bit.v` to Simulation Sources.
3. Set `tb_ALU4bit` as Top module.
4. Run Behavioral Simulation.

---

## 8. Test Cases and Expected Behavior

The testbench (`tb_ALU4bit.v`) evaluates 10 successive test operations across 100 ns:

1. **$T = 0\text{–}10\text{ ns}$ (Addition):** `a=1111 (15), b=0001 (1), sel=00`  
   Sum = 16 $\rightarrow$ `out = 4'b0000`, `carry = 1`, `zero = 1`. (Verifies both carry generation and zero detection simultaneously).
2. **$T = 10\text{–}20\text{ ns}$ (Addition):** `a=1111 (15), b=1111 (15), sel=00`  
   Sum = 30 $\rightarrow$ `out = 4'b1110 (14)`, `carry = 1`, `zero = 0`.
3. **$T = 20\text{–}30\text{ ns}$ (Addition repeated):** `a=1111, b=1111, sel=00`  
   `out = 4'b1110`, `carry = 1`, `zero = 0`.
4. **$T = 30\text{–}40\text{ ns}$ (Subtraction):** `a=0011 (3), b=1001 (9), sel=01`  
   Difference = $3 - 9 = -6 \equiv 10$ (mod 16) $\rightarrow$ `out = 4'b1010`, `carry = 0`, `zero = 0`.
5. **$T = 40\text{–}50\text{ ns}$ (Bitwise AND):** `a=0001, b=1111, sel=10`  
   `out = 4'b0001`, `carry = 0`, `zero = 0`.
6. **$T = 50\text{–}60\text{ ns}$ (Bitwise XOR):** `a=1111, b=1011, sel=11`  
   `out = 4'b0100`, `carry = 0`, `zero = 0`.
7. **$T = 60\text{–}70\text{ ns}$ (Addition):** `a=1011 (11), b=1111 (15), sel=00`  
   Sum = 26 $\rightarrow$ `out = 4'b1010 (10)`, `carry = 1`, `zero = 0`.
8. **$T = 70\text{–}80\text{ ns}$ (Subtraction):** `a=1010 (10), b=1001 (9), sel=01`  
   Difference = $10 - 9 = 1 \rightarrow$ `out = 4'b0001`, `carry = 0`, `zero = 0`.
9. **$T = 80\text{–}90\text{ ns}$ (Bitwise AND):** `a=1111, b=1111, sel=10`  
   `out = 4'b1111`, `carry = 0`, `zero = 0`.
10. **$T = 90\text{–}100\text{ ns}$ (Bitwise XOR):** `a=1010, b=1001, sel=11`  
    `out = 4'b0011`, `carry = 0`, `zero = 0`.
11. **At $T = 100\text{ ns}$:** Simulation terminates via `$finish`.

---

## 9. Actual Verification Status
- **Simulator:** AMD Vivado Simulator (`xsim v2026.1`).
- **Result:** **PASSED**.
- **Execution Log:** `$finish called at time : 100 ns : File "tb_ALU4bit.v" Line 22`.

---

## 10. Limitations or Improvements
- `carry` represents unsigned addition carry-out; subtraction borrow detection is not implemented.
- Additional arithmetic functions (e.g., increment, decrement) or logical shifts (`<<`, `>>`) can be added with wider selection opcodes.
