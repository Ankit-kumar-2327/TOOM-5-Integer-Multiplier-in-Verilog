# TOOM-5-Integer-Multiplier-in-Verilog
Verilog-based TOOM-5 multiplier for 1024-bit integers. Efficient for large number multiplication. Includes testbench for simulation and analysis.
<br>
## Overview

This project implements the TOOM-5 multiplication algorithm in Verilog for high-speed multiplication of two 1024-bit unsigned integers. The algorithm splits each input into 5 parts, evaluates at 9 points, performs pointwise multiplication, and reconstructs the result using interpolation. This is ideal for cryptography and digital hardware acceleration.
<br>
##  How It Works

1. **Splitting**: Each 1024-bit input is split into 5 parts (205 bits each).
2. **Evaluation**: The inputs are evaluated as polynomials at 9 points: 0, 1, -1, 2, -2, 4, -4, 8, ∞.
3. **Multiplication**: Pointwise multiplication is done for each pair of evaluated inputs.
4. **Interpolation**: Uses optimized arithmetic (not full matrix inversion) to approximate the coefficients.
5. **Recomposition**: All parts are recombined using bit-shifting to form the final 2047-bit product.

<br>
##  Running the Simulation

### Using Icarus Verilog:
iverilog -o TOOM5_APPROX_OUTPUT TOOM_5_Approx.v TOOM_5TB_APPROX.v    
vvp TOOM5_APPROX_OUTPUT

##  Author
**Ankit Kumar**  
ECE Student at Indian Institute Of Information Technology Guwahati.
