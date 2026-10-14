# Four-Bit Register Architectures

## 1. Objective
Design and simulate 4-bit parallel-in parallel-out (PIPO) data storage registers in Verilog HDL demonstrating three sequential control configurations:
1. 4-Bit Register with Clock Enable (`register4_enable`)
2. 4-Bit Register with Synchronous Reset & Clock Enable (`register4_syncreset_enable`)
3. 4-Bit Register with Asynchronous Reset & Clock Enable (`register4_asyncreset_enable`)

---

## 2. Design Overviews & Operating Tables

### 1. 4-Bit Register with Clock Enable (`register4_enable`)
Stores a 4-bit data word `d[3:0]` on the rising edge of `clk` when `enable = 1`. When `enable = 0`, the register holds its current word.
```verilog
always @(posedge clk) begin
    if (enable)
        q <= d;
end
```

---

### 2. 4-Bit Register with Synchronous Reset & Enable (`register4_syncreset_enable`)
Combines synchronous reset and clock enable. The synchronous reset has higher priority than `enable` and clears the 4-bit register to `4'b0000` on the rising clock edge:
```verilog
always @(posedge clk) begin
    if (reset)
        q <= 4'b0000;
    else if (enable)
        q <= d;
end
```
| `clk` | `reset` | `enable` | `d[3:0]` | $Q(t+1)$ | Behavior |
| :---: | :---: | :---: | :---: | :---: | :--- |
| $\uparrow$ | 1 | X | X | `4'b0000` | Synchronous Clear (Highest Priority) |
| $\uparrow$ | 0 | 1 | `data` | `data` | Parallel Load |
| $\uparrow$ | 0 | 0 | X | $Q(t)$ | Hold State |

---

### 3. 4-Bit Register with Asynchronous Reset & Enable (`register4_asyncreset_enable`)
Evaluates `reset` asynchronously. The register instantly clears to `4'b0000` whenever `reset = 1` regardless of clock state:
```verilog
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 4'b0000;
    else if (enable)
        q <= d;
end
```
| `clk` | `reset` | `enable` | `d[3:0]` | $Q(t+1)$ | Behavior |
| :---: | :---: | :---: | :---: | :---: | :--- |
| X | 1 | X | X | `4'b0000` | **Immediate Asynchronous Clear** |
| $\uparrow$ | 0 | 1 | `data` | `data` | Parallel Load |
| $\uparrow$ | 0 | 0 | X | $Q(t)$ | Hold State |

---

## 3. Verilog Concepts Demonstrated
- Parallel multi-bit sequential register inference (`reg [3:0] q`).
- Hierarchical priority inside procedural blocks (`reset` overrides `enable`).
- Synchronous vs. asynchronous multi-bit register clearing.
- Non-blocking assignments (`<=`) for clean multi-bit register transfers.

---

## 4. File Structure
```text
registers-4bit/
├── rtl/
│   ├── register4_enable.v                  # 4-bit register with enable
│   ├── register4_syncreset_enable.v         # 4-bit register with sync reset & enable
│   └── register4_asyncreset_enable.v        # 4-bit register with async reset & enable
├── tb/
│   ├── tb_register4_enable.v               # Testbench for register with enable
│   ├── tb_register4_syncreset_enable.v      # Testbench for sync reset & enable
│   └── tb_register4_asyncreset_enable.v     # Testbench for async reset & enable
└── README.md                               # Project documentation
```

---

## 5. How to Run Simulation in Vivado

### Simulating Register with Enable:
```powershell
xvlog rtl/register4_enable.v tb/tb_register4_enable.v
xelab -top tb_register4_enable -snapshot tb_reg_enable_snap
xsim tb_reg_enable_snap -R
```

### Simulating Register with Synchronous Reset & Enable:
```powershell
xvlog rtl/register4_syncreset_enable.v tb/tb_register4_syncreset_enable.v
xelab -top tb_register4_syncreset_enable -snapshot tb_reg_sync_snap
xsim tb_reg_sync_snap -R
```

### Simulating Register with Asynchronous Reset & Enable:
```powershell
xvlog rtl/register4_asyncreset_enable.v tb/tb_register4_asyncreset_enable.v
xelab -top tb_register4_asyncreset_enable -snapshot tb_reg_async_snap
xsim tb_reg_async_snap -R
```

---

## 6. Actual Verification Status
- **Simulator:** AMD Vivado Simulator (`xsim v2026.1`).
- **Results:**
  - `register4_enable`: **PASSED** (`$finish called at time : 60 ns`).
  - `register4_syncreset_enable`: **PASSED** (`$finish called at time : 80 ns`).
  - `register4_asyncreset_enable`: **PASSED** (`$finish called at time : 40 ns`).
