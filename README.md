This project implements an 8-bit binary to BCD (Binary-Coded Decimal) converter using the Double Dabble (Shift-and-Add-3) algorithm, written in VHDL. It is synthesizable and suitable for use in digital systems requiring binary-to-decimal display conversion, such as on 7-segment displays.

## Features
- Converts 8-bit unsigned binary input to 3-digit BCD (up to 255 → 255)
- Implements the Double Dabble algorithm
- Testbench provided for simulation
- Works with simulation tools like Vivado, ModelSim, etc.

## Algorithm: Double Dabble
The Double Dabble algorithm performs binary-to-BCD conversion by:
- Shifting the binary input left one bit at a time.
- Adding 3 to any BCD digit ≥ 5 before each shift (to handle carry-over).
- Repeating for all 8 input bits.
- Result is split into hundreds, tens, and units (stored in a 12-bit BCD).

## Port Description
- binary_input:	in	8 bits	8-bit binary input (0 to 255)
- bcd_output:	out	12 bits	BCD output: {hundreds, tens, units}

Example:
Input: binary_input = "00111111" (63)
Output: bcd_output = "000010011" → 0x063 (BCD)

## Outputs
- RTL Schematic: https://github.com/ananyav-26/8-bit-binary-to-bcd/blob/main/images/binary8bcd_rtl.png
- Output Waveform: https://github.com/ananyav-26/8-bit-binary-to-bcd/blob/main/images/binary8bcd_waveform.png
