# Johnson Counter (Twisted Ring Counter) – 4-bit Verilog Implementation

## Overview

This project implements a **4-bit Johnson counter** (also known as a twisted ring counter) in Verilog.

A Johnson counter is a modified shift register where the **inverted output of the last stage** is fed back to the input, producing a sequence of **2N unique states** for an N-bit register.

---

## Module Description

### `jCounter`

A 4-bit Johnson counter with:

* Circular shifting with inverted feedback
* Synchronous override (reset)
* Deterministic sequence of 8 states

---

## Inputs and Outputs

### Inputs

| Signal  | Description                                 |
| ------- | ------------------------------------------- |
| `clk_i` | Clock input                                 |
| `ori_i` | Override input (active HIGH, acts as reset) |

### Output

| Signal        | Description          |
| ------------- | -------------------- |
| `dout_o[3:0]` | 4-bit counter output |

---

## Functional Behavior

### Override (Reset)

* When `ori_i = 1`, counter is reset to:

```id="r1x2a9"
0000
```

### Normal Operation

* On each rising edge of the clock:

```id="k29d8s"
dout_o <= {~dout_o[0], dout_o[3:1]}
```

* The inverted LSB is fed back into the MSB

---

## State Sequence

For a 4-bit Johnson counter, the sequence is:

```id="u8x3m1"
0000 → 1000 → 1100 → 1110 → 1111 → 0111 → 0011 → 0001 → 0000 → ...
```

* Total states = **2 × N = 8 states**

---

## Design Characteristics

* **Synchronous operation**: All updates occur on clock edge
* **Deterministic pattern**: Fixed repeating sequence
* **Efficient state usage**: Generates more states than a ring counter with same flip-flops
* **Shift-register based design**

---

## Code Snippet

```verilog id="d7k2s9"
always@(posedge clk_i) begin
   if(ori_i)
      dout_o <= 4'b0000;
   else
      dout_o <= {~dout_o[0], dout_o[3:1]};
end
```

---

## Simulation

The testbench verifies:

* Proper reset behavior
* Correct Johnson sequence generation
* Stability across multiple cycles

Waveforms are dumped in `.vcd` format for analysis.

---

## File Structure

```id="p92k1x"
.
├── jCounter.v        # Design module
├── tb_jCounter.v     # Testbench
├── jCounter.vcd      # Waveform output
```

---

## Notes

* Initialization is required to ensure the counter starts from a valid state.
* Johnson counters produce **2N states**, unlike ring counters which produce N states.
* Useful in sequence generation and timing applications.

---

## Conclusion

This implementation demonstrates a compact and efficient **Johnson counter**, leveraging inverted feedback to generate extended state sequences with minimal hardware.
