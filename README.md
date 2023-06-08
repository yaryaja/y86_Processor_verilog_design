
# Verilog Implementation of Y86 Processor Architecture

This repository contains a Verilog implementation of the Y86 processor architecture. The Y86 architecture is a simplified version of the x86 architecture, designed for educational purposes. It consists of a simplified instruction set and a basic pipeline structure.

## Overview

The Verilog implementation provided in this repository is a cycle-accurate model of the Y86 processor architecture. It includes modules for the various components of the processor, such as the register file, memory, control unit, and ALU. The design follows a five-stage pipeline structure: Fetch, Decode, Execute, Memory, and Writeback.


## Getting Started

To use the Verilog implementation of the Y86 processor, follow these steps:

1. Clone the repository to your local machine:

```
git clone https://github.com/yaryaja/y86_Processor_verilog_design.git
```

2. Navigate to the `pipeline_implementaion/` directory:

```
y86_Processor_verilog_design/
```

3. Open the Verilog files in your preferred development environment or simulator.

4. Compile and simulate the Verilog design using the appropriate commands for your simulator. For example, using the `iverilog` simulator:

```
iverilog -o y86_sim top_module.v testbench.v
vvp y86_sim
```

5. Observe the simulation results and verify the functionality of the Y86 processor implementation.

## Testbench


```
iverilog -o final_result finla.v 
vvp final
```

The simulation will run, and the results will be displayed in the console. You can examine the waveforms and check the output signals and registers to verify the correctness of the processor implementation.

## Contributing

Contributions to this repository are welcome. If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

This Verilog implementation of the Y86 processor architecture is provided under the [MIT License](LICENSE). Feel free to use and modify the code for educational or personal projects.

## Acknowledgements

This Verilog implementation is inspired by the Y86 processor architecture described in the book "Computer Systems: A Programmer's Perspective" by Randal E. Bryant and David R. O'Hallaron.

## References

- "Computer Systems: A Programmer's Perspective" by Randal E. Bryant and David R. O'Hallaron.
- [Y86 Processor Specification](https://www.cs.cmu.edu/~fp/courses/15213-s04/misc/handouts/y86.pdf) (PDF)
