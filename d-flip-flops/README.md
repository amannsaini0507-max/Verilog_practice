# D Flip-Flop Architectures

## 1. Objective
Design, model, and simulate fundamental positive edge-triggered D Flip-Flop (DFF) memory elements in Verilog HDL across four standard sequential control configurations:
1. Basic D Flip-Flop (`d_flip_flop`)
2. D Flip-Flop with Synchronous Active-High Reset (`dff_sync_reset`)
3. D Flip-Flop with Asynchronous Active-High Reset (`dff_async_reset`)
4. D Flip-Flop with Clock Enable (`dff_enable`)

---

## 2. Design Overviews & Operating Tables

### 1. Basic D Flip-Flop (`d_flip_flop`)
Samples the single-bit data input `d` on the rising edge of `clk` and transfers it to output `q`.
```verilog
always @(posedge clk) begin
    q <= d;
end
```
| `clk` | `d` | $Q(t+1)$ | Behavior |
| :---: | :---: | :---: | :--- |
| $\uparrow$ | 0 | 0 | Reset state |
| $\uparrow$ | 1 | 1 | Set state |
| 0 or 1 | X | $Q(t)$ | Memory retention |

---

### 2. D Flip-Flop with Synchronous Reset (`dff_sync_reset`)
Reset evaluation occurs strictly on the rising edge of `clk`. If `reset = 1` during the clock transition, `q` is cleared to `0`.
```verilog
always @(posedge clk) begin
    if (reset)
        q <= 0;
    else
        q <= d;
end
```
| `clk` | `reset` | `d` | $Q(t+1)$ | Behavior |
| :---: | :---: | :---: | :---: | :--- |
| $\uparrow$ | 1 | X | 0 | Synchronous Clear |
| $\uparrow$ | 0 | 0 | 0 | Sample Data `0` |
| $\uparrow$ | 0 | 1 | 1 | Sample Data `1` |
| 0 or 1 | X | X | $Q(t)$ | Memory retention |

---

### 3. D Flip-Flop with Asynchronous Reset (`dff_async_reset`)
The reset condition is evaluated immediately whenever `reset` transitions high, independent of the clock edge. This is achieved by including `posedge reset` in the procedural sensitivity list.
```verilog
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 0;
    else
        q <= d;
end
```
| `clk` | `reset` | `d` | $Q(t+1)$ | Behavior |
| :---: | :---: | :---: | :---: | :--- |
| X | 1 | X | 0 | **Immediate Asynchronous Clear** |
| $\uparrow$ | 0 | 0 | 0 | Sample Data `0` |
| $\uparrow$ | 0 | 1 | 1 | Sample Data `1` |
| 0 or 1 | 0 | X | $Q(t)$ | Memory retention |

---

### 4. D Flip-Flop with Clock Enable (`dff_enable`)
Gating logic that samples data only when the control line `enable` is asserted. When disabled (`enable = 0`), the flip-flop holds its previous state.
```verilog
always @(posedge clk) begin
    if (enable)
        q <= d;
end
```
| `clk` | `enable` | `d` | $Q(t+1)$ | Behavior |
| :---: | :---: | :---: | :---: | :--- |
| $\uparrow$ | 1 | 0 | 0 | Sample Data `0` |
| $\uparrow$ | 1 | 1 | 1 | Sample Data `1` |
| $\uparrow$ | 0 | X | $Q(t)$ | Hold State (Disabled) |

---

## 3. Verilog Concepts Demonstrated
- Clocked sequential procedural modeling with `always @(posedge clk)`.
- Use of non-blocking assignments (`<=`) for sequential register transfers.
- Modeling synchronous vs. asynchronous reset mechanisms:
  - Synchronous reset includes only `clk` in the sensitivity list.
  - Asynchronous reset includes both `clk` and `reset` edge triggers in the sensitivity list (`always @(posedge clk or posedge reset)`).
- Data gating using clock enable controls.

---

## 4. File Structure
```text
d-flip-flops/
├── rtl/
│   ├── d_flip_flop.v           # Basic DFF
│   ├── dff_sync_reset.v        # DFF with synchronous reset
│   ├── dff_async_reset.v       # DFF with asynchronous reset
│   └── dff_enable.v            # DFF with clock enable
├── tb/
│   ├── tb_d_flip_flop.v        # Testbench for basic DFF
│   ├── tb_dff_sync_reset.v     # Testbench for sync reset DFF
│   ├── tb_dff_async_reset.v    # Testbench for async reset DFF
│   └── tb_dff_enable.v         # Testbench for clock enable DFF
└── README.md                   # Project documentation
```

---

## 5. How to Run Simulation in Vivado

### Simulating Basic DFF:
```powershell
xvlog rtl/d_flip_flop.v tb/tb_d_flip_flop.v
xelab -top tb_d_flip_flop -snapshot tb_dff_snap
xsim tb_dff_snap -R
```

### Simulating Synchronous Reset DFF:
```powershell
xvlog rtl/dff_sync_reset.v tb/tb_dff_sync_reset.v
xelab -top tb_dff_sync_reset -snapshot tb_dff_sync_snap
xsim tb_dff_sync_snap -R
```

### Simulating Asynchronous Reset DFF:
```powershell
xvlog rtl/dff_async_reset.v tb/tb_dff_async_reset.v
xelab -top tb_dff_async_reset -snapshot tb_dff_async_snap
xsim tb_dff_async_snap -R
```

### Simulating Clock Enable DFF:
```powershell
xvlog rtl/dff_enable.v tb/tb_dff_enable.v
xelab -top tb_dff_enable -snapshot tb_dff_enable_snap
xsim tb_dff_enable_snap -R
```

---

## 6. Actual Verification Status
- **Simulator:** AMD Vivado Simulator (`xsim v2026.1`).
- **Results:**
  - `d_flip_flop`: **PASSED** (`$finish called at time : 44 ns`).
  - `dff_sync_reset`: **PASSED** (`$finish called at time : 42 ns`).
  - `dff_async_reset`: **PASSED** (`$finish called at time : 25 ns`).
  - `dff_enable`: **PASSED** (`$finish called at time : 60 ns`).
