# Setting Up and Running Projects in AMD Xilinx Vivado

This guide provides a step-by-step walkthrough for opening, configuring, and simulating the Verilog projects in this repository using the **AMD Xilinx Vivado Design Suite**.

---

## 1. Prerequisites

- AMD Xilinx Vivado installed (tested and verified with Vivado ML Standard 2026.1 / 2024.x / 2022.x).
- Source files from this repository.

---

## 2. Creating a Vivado Project

1. Launch **Vivado** from the Start Menu, Desktop shortcut, or terminal.
2. In the **Quick Start** window, click **Create Project**.
3. Click **Next** on the New Project wizard:
   - **Project Name:** Specify a project name (e.g., `verilog_practice`).
   - **Project Location:** Choose a directory on your local drive (avoid path names with spaces or special characters).
   - Check the box **"Create project subdirectory"**.
4. Click **Next**.
5. On the **Project Type** screen:
   - Select **RTL Project**.
   - Check **"Do not specify sources at this time"** (sources can be added conveniently in the next step, or you can add them directly here).
6. Click **Next**.
7. On the **Default Part** screen:
   - Select any standard FPGA part (e.g., Artix-7 `xc7a35tcpg236-1` for Basys 3, or leave the default evaluation board selected).
   - Note: Since these are functional simulation projects, device selection does not impact behavioral simulation results.
8. Click **Finish**. Vivado creates and opens the project environment.

---

## 3. Adding Design (RTL) Sources

1. In the Vivado **Sources** pane (or in the Flow Navigator under **Project Manager**), click **Add Sources** (`+` icon or `Alt + A`).
2. Select **Add or create design sources** and click **Next**.
3. Click **Add Files** and navigate to the project directory you want to inspect (e.g., `logic-gates/rtl/` or `alu-4bit/rtl/`).
4. Select the `.v` source file(s) and ensure **"Copy sources into project"** is unchecked if you want to link directly to this repository, or checked if you prefer a local copy.
5. Click **Finish**. The Verilog module will now appear under **Design Sources** in the Sources tree.

---

## 4. Adding Simulation Sources (Testbenches)

1. Click **Add Sources** again (`Alt + A`).
2. Select **Add or create simulation sources** and click **Next**.
3. Click **Add Files** and navigate to the corresponding `tb/` folder (e.g., `logic-gates/tb/` or `alu-4bit/tb/`).
4. Select the testbench `.v` file (e.g., `tb_logic_gates.v`).
5. Click **Finish**. The testbench will appear under **Simulation Sources -> sim_1**.

---

## 5. Setting the Top Module

When multiple modules or testbenches are present, Vivado needs to know which module to execute:

1. Expand **Simulation Sources -> sim_1** in the Sources window.
2. Locate the desired testbench (e.g., `tb_ALU4bit`).
3. Right-click on the testbench module and select **Set as Top**.
4. Vivado will update the project hierarchy and place the selected module at the top of the simulation tree with a bold indicator.

---

## 6. Running Behavioral Simulation

1. In the **Flow Navigator** on the left side, locate the **Simulation** section.
2. Click **Run Simulation -> Run Behavioral Simulation**.
3. Vivado compiles the source code using `xvlog`, elaborates the design with `xelab`, and launches the simulator (`xsim`).
4. Once loaded, the Vivado GUI switches into the **Simulation Perspective**, displaying the waveform window, object hierarchy, and Tcl console.

---

## 7. Inspecting Waveforms

1. **Zoom to Fit:**
   - Click the **Zoom to Fit** button (magnifying glass with four outward arrows or shortcut `Ctrl + Shift + F`) to see the complete simulation timeline from `0 ns` to `$finish`.
2. **Adding/Removing Signals:**
   - The **Scopes** pane lists design instances (`uut`, `d1`, etc.).
   - Select a scope to view its internal signals in the **Objects** pane.
   - Drag and drop any signal from the Objects pane directly into the **Waveform viewer**.
   - If new signals are added, click **Restart** (counter-clockwise arrow or `Ctrl + Shift + F5`) and then **Run All** (`F3` or icon with run arrow).
3. **Changing Signal Radix:**
   - By default, bus signals may appear in binary or hexadecimal.
   - Right-click on a bus signal (e.g., `a[3:0]`, `out[3:0]`) in the waveform name column.
   - Select **Radix -> Binary**, **Unsigned Decimal**, or **Hexadecimal** depending on how the data is interpreted.
4. **Using Cursors and Markers:**
   - Click anywhere on the waveform canvas to position the yellow primary time cursor.
   - The value of each signal at that exact time instant appears next to the signal name in the value column.
   - Click the **Add Marker** button (`+` icon with vertical line) to place persistent time reference markers for delta-time measurements.
