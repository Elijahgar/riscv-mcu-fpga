# RISC-V MCU on FPGA (Vivado)

Soft RISC-V MCU for Basys 3.

## Board / Tool
- Board/part: Basys 3 (xc7a35tcpg236-1)
- Vivado: 20xx.x (fill yours)

## Files
- `github-mcu-sources` — HDL (core, ALU, regfile, UART/GPIO, top)
- `baysys_master.xdc` — XDC (pin map, clocks)

## Build (Vivado GUI)
1. **Create Project** → Add files from `github-mcu-sources` and constraints from `baysys_master.xdc`.
2. **Project Settings → General → Top**: set your true top (exact name).
3. **Run Synthesis → Implementation → Generate Bitstream**.

## Notes
- Large Vivado artifacts are ignored via `.gitignore`.
- Memory init file: `otter_memory.mem`.
