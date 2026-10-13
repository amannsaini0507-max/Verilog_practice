# Verilog HDL Coding Guidelines & Best Practices

This document outlines key digital design principles and Verilog HDL idioms for beginners using AMD Xilinx Vivado. Understanding these foundational concepts ensures predictable simulation results, clean synthesis, and latch-free combinational logic.

---

## 1. Continuous Assignments (`assign`)

Continuous assignment represents **dataflow modeling** and models combinational logic that is continuously evaluated:

- **Target:** The left-hand side (LHS) of an `assign` statement must always be a **net type** (e.g., `wire`). It cannot be a `reg`.
- **Evaluation:** Whenever any signal on the right-hand side (RHS) changes value, the expression is immediately evaluated and driven onto the target net.
- **Example:**
  ```verilog
  wire a, b;
  wire y_and;
  assign y_and = a & b; // continuously drives y_and with AND of a and b
  ```
- **Conditional Operator (`? :`):**
  Continuous assignments can model multiplexing or prioritized selection using ternary operators:
  ```verilog
  assign out = sel ? b : a;
  ```

---

## 2. Procedural Combinational Blocks (`always @(*)`)

In behavioral modeling, procedural blocks execute statements in response to signal changes:

- **Target:** The LHS of assignments inside any `always` block must be declared as a **variable type** (e.g., `reg`). Note: In Verilog, declaring an identifier as `reg` does *not* automatically infer a physical hardware register or flip-flop; it merely tells the compiler that the identifier receives values procedurally.
- **Sensitivity List:** In Verilog-2001, the wildcard token `*` inside `always @(*)` automatically includes every input signal read inside the block.
  ```verilog
  always @(*) begin
      if (en == 1'b0)
          y = 4'b0000;
      else
          y = a;
  end
  ```
- **Why Avoid Manual Lists?** Writing `always @(a or b)` manually risks accidentally omitting an input (e.g., forgetting `en`), which creates simulation-synthesis mismatches where simulation fails to trigger but synthesized hardware is purely combinational.

---

## 3. Clocked Sequential Blocks (`always @(posedge clk)`)

Sequential circuits (registers, counters, state machines) store state synchronized to a clock signal:

- **Sensitivity List:** Uses edge qualifiers: `posedge clk` (rising edge) or `negedge clk` (falling edge).
- **Asynchronous Resets:** If an active-high asynchronous reset is used:
  ```verilog
  always @(posedge clk or posedge reset) begin
      if (reset)
          q <= 4'b0000;
      else
          q <= d;
  end
  ```
- **Hardware Inferred:** D flip-flops with optional reset and enable ports.

---

## 4. Blocking (`=`) vs Non-Blocking (`<=`) Assignments

Verilog provides two distinct assignment operators within procedural blocks. Adhering strictly to these standard industry rules prevents race conditions and simulation mismatches:

| Feature | Blocking Assignment (`=`) | Non-Blocking Assignment (`<=`) |
| :--- | :--- | :--- |
| **Execution Order** | Immediate: Evaluates and updates variable instantly, blocking subsequent statements in the block. | Deferred: Evaluates RHS at current time step, then updates LHS at the end of the simulation time slice. |
| **Target Circuit** | **Combinational Logic** (`always @(*)`) | **Sequential / Clocked Logic** (`always @(posedge clk)`) |
| **Typical Analogy** | Procedural software-like sequential execution. | Concurrent hardware registers updating simultaneously on a clock edge. |

### The Golden Rules:
1. **Rule 1:** When modeling **combinational logic** using `always @(*)`, use **blocking assignments (`=`)**.
2. **Rule 2:** When modeling **sequential logic** using `always @(posedge clk)`, use **non-blocking assignments (`<=`)**.
3. **Rule 3:** **Never mix** `=` and `<=` in the same `always` block.
4. **Rule 4:** Do not make assignments to the same variable from more than one `always` block.

---

## 5. Conditional Constructs: `if-else` vs `case`

### `if-else` Constructs
- Evaluated with **implicit priority**: The first condition evaluated to true executes, and subsequent branches are ignored.
- Best suited for priority decoders, enable checks, or relational comparisons:
  ```verilog
  always @(*) begin
      if (en == 1'b0)
          y = 4'b0000;
      else if (a > b)
          y = 4'b0001;
      else
          y = 4'b0010;
  end
  ```

### `case` Constructs
- Evaluates an expression against multiple discrete values.
- In hardware synthesis, a `case` statement often synthesizes into parallel multiplexer or decoder logic.
- **Syntax:**
  ```verilog
  case (sel)
      2'b00: y = 4'b0001;
      2'b01: y = 4'b0010;
      2'b10: y = 4'b0100;
      2'b11: y = 4'b1000;
      default: y = 4'b0000;
  endcase
  ```
- Always include a `default` branch to cover unspecified patterns, `x` (unknown), or `z` (high-impedance) states during simulation.

---

## 6. Avoiding Unintended Latches

An **unintended latch** is one of the most common design flaws encountered by beginners in combinational HDL design.

### What is a Latch?
A transparent latch holds its previous value when its enable condition is not active. In purely combinational circuits (like decoders, adders, multiplexers, and comparators), retaining previous state is unintended and creates timing hazards.

### When is a Latch Inferred?
Synthesis tools infer a latch whenever a variable inside an `always @(*)` block is **not assigned a value under every possible branch of execution**. If any path leaves the variable unassigned, the hardware must physically retain the previous value, forcing the synthesis tool to infer a level-sensitive latch.

### Incomplete `if-else` Example:
```verilog
// BAD: Incomplete if-else leads to latch inference for 'out'
always @(*) begin
    if (sel == 1'b1)
        out = b;
    // Missing else branch! If sel == 0, 'out' must hold its previous value -> LATCH!
end

// GOOD: Fully specified
always @(*) begin
    if (sel == 1'b1)
        out = b;
    else
        out = a;
end
```

### Incomplete `case` Example:
```verilog
// BAD: Missing case items or default
always @(*) begin
    case (sel)
        2'b00: y = 4'b0001;
        2'b01: y = 4'b0010;
        // Missing 2'b10, 2'b11, and default -> LATCH!
    endcase
end

// GOOD: Fully specified with default
always @(*) begin
    case (sel)
        2'b00:   y = 4'b0001;
        2'b01:   y = 4'b0010;
        2'b10:   y = 4'b0100;
        2'b11:   y = 4'b1000;
        default: y = 4'b0000;
    endcase
end
```

### Best-Practice Technique: Pre-assignment Defaults
To guarantee a latch-free block, assign default values to all outputs at the very top of the `always @(*)` block before any conditional logic:
```verilog
always @(*) begin
    // Default assignments
    y = 4'b0000;

    // Overriding conditions
    if (en) begin
        case (sel)
            2'b00: y = 4'b0001;
            2'b01: y = 4'b0010;
            2'b10: y = 4'b0100;
            2'b11: y = 4'b1000;
        endcase
    end
end
```

---

## 7. Vector Widths, Arithmetic Sizing & Zero-Extension

1. **Width Declarations:**
   - In Verilog, multi-bit buses are declared as `[MSB:LSB]`. Standard convention is big-endian bit ordering: `[3:0]` where bit 3 is the Most Significant Bit (MSB) and bit 0 is the Least Significant Bit (LSB).
2. **Arithmetic Overflow & Width Matching:**
   - Adding two $N$-bit numbers produces an $(N+1)$-bit result.
   - If an expression is assigned to a target variable of smaller width, the MSB is silently truncated.
   - **Correct Carry-Out Idiom:**
     To capture the carry-out of a 4-bit addition, zero-extend the operands into a 5-bit temporary variable:
     ```verilog
     reg [4:0] sum;
     sum = {1'b0, a} + {1'b0, b};
     out = sum[3:0]; // 4-bit result
     carry = sum[4]; // 5th bit is the carry-out
     ```
3. **Bitwise vs Logical Operators:**
   - **Bitwise operators** (`&`, `|`, `^`, `~`) operate on each individual bit of the vector independently, returning a vector of equal width.
   - **Logical operators** (`&&`, `||`, `!`) treat entire multi-bit operands as boolean truth values (non-zero is `1'b1`, zero is `1'b0`) and return a single-bit result (`1'b0` or `1'b1`).
