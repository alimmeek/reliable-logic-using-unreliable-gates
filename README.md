# Reliable Logic Using Unreliable Gates

## Abstract
An investigation into hardware solutions to tolerate faults, which can be based on particular architectures or error correcting codes (ECCs). Here, the project will investigate the options and build a simulation to demonstrate the operation of an established method.


## Problem
As logic gates get smaller with increased transistor density, components are at the nanoscale where physical limits are approached with high levels of variability and manufacturing defects. At these limits, quantum mechanics comes into play: where electronic barriers were once thick enough to block current, they are now thin enough that electrons can simply ignore it - a phenomenon known as _quantum tunnelling_. It has been identified that by reducing the thickness of the _gate oxide_ - a transistor component which electrically separates the gate (responsible for turning the transistor on and off) from the current-carrying channel - to anything much less than a nanometre will result in too much current flowing across the channel when the transistor is “off”. This on its own, however, is only one of several leakage points, hence methods of fault tolerance are required. [1]


## Objectives
The objectives have been listed below, with a more detailed description of implementation given under [Methodology](#methodology).

### Essential
These are the minimum requirements in order for the goals of the project to have been achieved.
- Research the various proposed architectures and ECCs.
- Select a method of fault tolerance to simulate and fix a small error probability.
- Design an implementation of it in the chosen language.
- Perform benchmarking to analyse the trade off between accuracy and performance.

### Extension
Given enough time left after completing the essential objectives, these features would enhance the quality of the project, but are not necessary for its successful completion.

- Vary the error probability of the gates - this will determine whether there are limits to the fault tolerance of the chosen method and whether it is able to hold up to higher error probabilities
- Select another method to simulate and compare the relative effectiveness of each


## Methodology
In this project, we use the Von Neumann error model: a _Von Neumann erroneous gate_ is simply an ideal logic gate (one which never errors) cascaded with an error injecting XOR gate. The XOR gate takes a one as input with some probability _p_, called the _gate error probability_, as well as the output from the ideal gate. [2] This can be used to simulate the gate randomly inducing a bit flip. The chosen architecture or ECC will be implemented using these gates to determine how resilient it is to individual gate failures.

Since we are working with hardware, it makes sense to make use of a hardware description language (HDL) to simulate their behaviour. `SystemVerilog` is chosen here, over `Verilog`, owing to its ability to simulate electronic systems, as well as its support for datatypes such as enum, union, struct, string and class. It also allows for coverages design, which will ensure that test cases of interest (one gate errors, final gate errors, all gates error, etc.). Modules will be built to implement each of the gates, as well as the error probability. We can pass the error probability into the top-level module as a parameter, meaning it can be varied independent of the designed architecture.

A testbench will be designed to drive the module. Once this has been realised, simulation software will be used to gather data on the runtime of the simulated circuits. For control, we should run the module with no error correction, in order to get a baseline for runtime and error rate. To improve repeatability, simulations will be ran 10 times, and the results averaged to get the mean runtime. These results can then be plotted. Simulation software does not typically have graphing capabilities; hence, several alternative candidates for graphing are proposed.

- `Python` has an extensive graphing library, `matplotlib`, which could be used to generate the required graphs. [3] Additionally, a further library, `openpyxl`, exists which can be used to easily manipulate Excel spreadsheets. [4]
- The code underpinning the `matplotlib` library is `MATLAB`, hence making it itself a strong candidate for graph generation. Further, its import wizard would ease handling the spreadsheet as the data could be simply imported into a `MATLAB` matrix, and the data plotted with minimal effort.

For each architecture and ECC simulated, two metrics will be examined: how high the gate error probability can be set before performance begins to fail, and the trade-off between any additional latency and the error correction performance. If time has allowed multiple methods to have been simulated, their performances will also be compared with each other.


## References
[1] A. Seabaugh, “The Tunneling Transistor.” [https://quantum-neuroscience.com/wp-content/uploads/2018/07/The-Tunneling-Transistor.pdf](https://quantum-neuroscience.com/wp-content/uploads/2018/07/The-Tunneling-Transistor.pdf), 2013. Accessed October 5, 2023.

[2] S. Grandhi, E. Dupraz, C. Spagnol, V. Savin, and E. Popovici, “CPE: Codeword Prediction Encoder,” in 2016 21th IEEE European Test Symposium (ETS), pp. 1–2, 2016.

[3] A. Seabaugh, “Matplotlib 3.8.0 Documentation.” [https://matplotlib.org/stable/index.html](https://matplotlib.org/stable/index.html), 2023. Accessed October 5, 2023.

[4] E. Gazoni and C. Clark, “openpyxl - A Python library to read/write Excel 2010 xlsx/xlsm files.” [https://matplotlib.org/stable/index.html](https://matplotlib.org/stable/index.html), 2023. Accessed October 5, 2023.
