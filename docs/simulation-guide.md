# Behavioral Simulation Guide & Troubleshooting

This guide explains how simulation works in Verilog HDL using AMD Xilinx Vivado and provides solutions to common simulation errors and unexpected waveform results.

---

## 1. How HDL Simulation Works

Hardware Description Languages (HDLs) are simulated event-by-event using an event-driven simulation engine. In AMD Vivado, the simulation pipeline consists of three distinct phases:

```text
[Verilog Sources (.v)] ──> xvlog (Compiler) ──> Work Library
                                                    │
[Top Testbench / DUT]   ──> xelab (Elaborator) <───┘
                                  │
                          Snapshot Binary
                                  │
[Run & Inspect]        ──> xsim  (Simulation Engine / Waveform Viewer)
```

1. **Compilation (`xvlog`):** Checks syntax, analyzes module headers, and compiles source files into an intermediate representation stored in a design library (default: `work`).
2. **Elaboration (`xelab`):** Resolves module instantiations, binds port connections, calculates parameter values, detects multi-driver conflicts, and builds an executable simulation snapshot.
3. **Execution (`xsim`):** Runs the simulation kernel, advances simulation time according to `#` delays, schedules signal transitions, and outputs waveform data.

---

## 2. Running Simulations via Command Line

For fast verification without opening the full Vivado graphical user interface, you can run Vivado's simulation tools directly in PowerShell or Command Prompt:

### Step 1: Open a terminal and ensure Vivado tools are available
```powershell
# Set path to your Vivado bin folder if not in PATH:
$env:PATH += ";C:\AMDDesignTools\2026.1\Vivado\bin"
```

### Step 2: Compile RTL and Testbench
```powershell
xvlog rtl/my_module.v tb/tb_my_module.v
```

### Step 3: Elaborate the Testbench Top Module
```powershell
xelab -top tb_my_module -snapshot my_snapshot
```

### Step 4: Run Simulation
```powershell
# Run in batch mode until $finish:
xsim my_snapshot -R

# Or run interactively in the GUI to view waveforms:
xsim my_snapshot --gui
```

---

## 3. Waveform Analysis Checklist

When inspecting results in the Vivado Waveform Viewer:

1. **Check Initial Values (Time = 0 ns):**
   - Ensure all input stimulus registers in the testbench are explicitly initialized (e.g., `a = 0; b = 0;`).
2. **Verify Signal Transitions at Delay Boundaries:**
   - With `#10;` delays, verify that outputs update instantaneously (or after gate propagation delays) when inputs change.
3. **Inspect Active-Low vs Active-High Signals:**
   - Confirm whether enable or reset signals are active-high (e.g., `en == 1`) or active-low (e.g., `en_n == 0`).
4. **Radix Check:**
   - Multi-bit buses (such as 4-bit ALU outputs or comparator inputs) should be displayed in the radix that matches how you think about the values (e.g., Unsigned Decimal or Hexadecimal rather than 4 raw binary bits).

---

## 4. Common Troubleshooting Tips

### Issue 1: Blue / Red Lines in Waveform (`Z` or `X` Values)
- **Symptom:** Signals show `Z` (blue line, high impedance) or `X` (red dashed line, unknown/uninitialized).
- **Causes & Fixes:**
  - An input in the testbench was never initialized. Fix: Assign initial values at `time = 0` in an `initial` block.
  - A combinational output was not assigned in every possible branch of an `if-else` or `case` block. Fix: Ensure complete assignments or provide a `default` case.
  - Multiple drivers are writing to the same wire. Fix: Ensure only one driver drives each `wire`.

### Issue 2: Simulation Hangs / Never Finishes
- **Symptom:** Vivado simulation status remains "Running..." indefinitely, time advances infinitely, and the GUI freezes.
- **Cause:** The testbench is missing an explicit `$finish;` statement, or has an unconditional `always` block without delay.
- **Fix:** Always end testbench stimulus with `$finish;` after all vectors have been evaluated:
  ```verilog
  initial begin
      // stimulus...
      #10;
      $finish;
  end
  ```

### Issue 3: "Module '<name>' is not defined" during Elaboration
- **Symptom:** `xelab` fails with an error stating the instantiated DUT module cannot be found.
- **Cause:** The RTL source file defining the module was not compiled into the same simulation library or was omitted from the command/project sources.
- **Fix:** Ensure both the RTL `.v` and testbench `.v` files are included under **Simulation Sources** in Vivado.

### Issue 4: "Port width mismatch" Warnings
- **Symptom:** Warning during compilation that an instance port connection width does not match the module definition.
- **Cause:** Connecting a 1-bit net to a multi-bit port, or mismatching vector bounds (e.g., connecting `[3:0]` to `[4:0]`).
- **Fix:** Explicitly match bus widths or use concatenation/zero-extension (e.g., `{1'b0, a}`).

### Issue 5: Multiple Top Modules Error
- **Symptom:** Vivado picks an unintended module as simulation top or reports ambiguous top modules.
- **Fix:** Right-click the desired testbench under **Sources -> sim_1** and click **Set as Top**.
