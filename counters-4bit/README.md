# Four-Bit Counter Architectures

## 1. Objective
Design, implement, and simulate 4-bit synchronous binary counters in Verilog HDL covering four fundamental counting configurations:
1. 4-Bit Up Counter with Synchronous Reset (`counter4`)
2. 4-Bit Up Counter with Synchronous Reset & Clock Enable (`counter4_enable`)
3. 4-Bit Down Counter with Synchronous Reset & Clock Enable (`down_counter4`)
4. 4-Bit Bidirectional Up/Down Counter with Reset, Enable & Direction Control (`up_down_counter`)

---

## 2. Design Overviews & Operating Tables

### 1. 4-Bit Up Counter (`counter4`)
Increments its 4-bit count value by 1 on every rising clock edge. Automatically rolls over from `4'b1111` ($15$) to `4'b0000` ($0$) on modulo-16 overflow.
```verilog
always @(posedge clk) begin
    if (reset)
        q <= 4'b0000;
    else
        q <= q + 4'b0001;
end
```

---

### 2. 4-Bit Up Counter with Enable (`counter4_enable`)
Adds clock gating control. When `enable = 1`, the counter increments on each clock edge; when `enable = 0`, the count value is frozen.
```verilog
always @(posedge clk) begin
    if (reset)
        q <= 4'b0000;
    else if (enable)
        q <= q + 4'b0001;
end
```

---

### 3. 4-Bit Down Counter with Enable (`down_counter4`)
Decrements its 4-bit count value by 1 on each rising clock edge when `enable = 1`. Rolls over from `4'b0000` ($0$) down to `4'b1111` ($15$) upon underflow.
```verilog
always @(posedge clk) begin
    if (reset)
        q <= 4'b0000;
    else if (enable)
        q <= q - 4'b0001;
end
```

---

### 4. 4-Bit Bidirectional Up/Down Counter (`up_down_counter`)
Supports runtime directional switching:
- `direction = 1`: Increments count (`q <= q + 4'b0001`)
- `direction = 0`: Decrements count (`q <= q - 4'b0001`)
```verilog
always @(posedge clk) begin
    if (reset)
        q <= 4'b0000;
    else if (enable) begin
        if (direction)
            q <= q + 4'b0001;
        else
            q <= q - 4'b0001;
    end
end
```

| `clk` | `reset` | `enable` | `direction` | $Q(t+1)$ | Behavior |
| :---: | :---: | :---: | :---: | :---: | :--- |
| $\uparrow$ | 1 | X | X | `4'b0000` | Synchronous Reset |
| $\uparrow$ | 0 | 0 | X | $Q(t)$ | Count Hold |
| $\uparrow$ | 0 | 1 | 1 | $Q(t) + 1$ | Up-Count (Modulo 16) |
| $\uparrow$ | 0 | 1 | 0 | $Q(t) - 1$ | Down-Count (Modulo 16) |

---

## 3. Verilog Concepts Demonstrated
- Synchronous binary arithmetic accumulation (`+`, `-`) in clocked procedural blocks.
- Modulo-$2^N$ natural overflow and underflow wrap-around behavior.
- Combining nested control structures: synchronous reset, clock enable gating, and bidirectional steering.
- Non-blocking assignments (`<=`) ensuring race-free sequential state updates.

---

## 4. File Structure
```text
counters-4bit/
├── rtl/
│   ├── counter4.v              # 4-bit basic up counter
│   ├── counter4_enable.v       # 4-bit up counter with enable
│   ├── down_counter4.v         # 4-bit down counter with enable
│   └── up_down_counter.v       # 4-bit bidirectional up/down counter
├── tb/
│   ├── tb_counter4.v           # Testbench for basic up counter
│   ├── tb_counter4_enable.v    # Testbench for up counter with enable
│   ├── tb_down_counter4.v      # Testbench for down counter with enable
│   └── tb_up_down_counter.v    # Testbench for bidirectional counter
└── README.md                   # Project documentation
```

---

## 5. How to Run Simulation in Vivado

### Simulating Basic Up Counter:
```powershell
xvlog rtl/counter4.v tb/tb_counter4.v
xelab -top tb_counter4 -snapshot tb_cnt_snap
xsim tb_cnt_snap -R
```

### Simulating Up Counter with Enable:
```powershell
xvlog rtl/counter4_enable.v tb/tb_counter4_enable.v
xelab -top tb_counter4_enable -snapshot tb_cnt_en_snap
xsim tb_cnt_en_snap -R
```

### Simulating Down Counter:
```powershell
xvlog rtl/down_counter4.v tb/tb_down_counter4.v
xelab -top tb_down_counter4 -snapshot tb_down_cnt_snap
xsim tb_down_cnt_snap -R
```

### Simulating Bidirectional Up/Down Counter:
```powershell
xvlog rtl/up_down_counter.v tb/tb_up_down_counter.v
xelab -top tb_up_down_counter -snapshot tb_up_down_cnt_snap
xsim tb_up_down_cnt_snap -R
```

---

## 6. Actual Verification Status
- **Simulator:** AMD Vivado Simulator (`xsim v2026.1`).
- **Results:**
  - `counter4`: **PASSED** (`$finish called at time : 190 ns`).
  - `counter4_enable`: **PASSED** (`$finish called at time : 100 ns`).
  - `down_counter4`: **PASSED** (`$finish called at time : 110 ns`).
  - `up_down_counter`: **PASSED** (`$finish called at time : 140 ns`).
