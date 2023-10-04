# Reliable Logic Using Unreliable Gates

## Abstract
As logic gates get smaller with increased transistor density, components are at the nanoscale where physical limits are approached with high levels of variability and manufacturing defects. This makes the gates less reliable and ways to tolerate faults are needed. These can be based on particular architectures or error correcting codes (ECCs). Here, the project will investigate the options and build a simulation to demonstrate the operation of an established method.

## Problem


## Objectives
The objectives have been listed below, with a more detailed description of implementation given under [Methodology](#methodology).
### Essential
These are the minimum requirements in order for the goals of the project to have been achieved.
  -	Research the various proposed architectures and ECCs.
  -	Select a method of fault tolerance to simulate and fix a small error probability.
  - Design an implementation of it in the chosen language.
  -	Perform benchmarking to analyse the trade off between accuracy and performance.
### Extension
Given enough time left after completing the essential objectives, these features would enhance the project, but are not necessary for its successful completion.
  - Vary the error probability of the gates – this will determine whether there are limits to the fault tolerance of the chosen method and whether it is able to hold up to higher error probabilities.
  - Select another method to simulate and compare the relative effectiveness of each.

## Methodology
Since we are dealing with hardware, it makes sense to make use of a hardware description language (HDL) to simulate their behaviour. `SystemVerilog` is chosen here, over `Verilog`, owing to its ability to simulate electronic systems, as well as its support for datatypes such as enum, union, struct, string and class. It also allows for coverages design, which will ensure that test cases of interest (one gate errors, final gate errors, all gates error, etc.). Modules will be built to implement each of the gates, as well as the error probability. We can pass the error probability into the top-level module as a parameter, meaning it can be varied independent of the designed architecture.

A testbench will be designed to drive the module. Once this has been realised, simulation software will be used to gather data on the runtime of the simulated circuits. For control, we should run the module with no error correction, in order to get a baseline for runtime and error rate. To improve repeatability, simulations will be ran 10 times, and the results averaged to get the mean runtime. These results can then be plotted. Simulation software does not typically have graphing capabilities; hence I now propose several alternative candidates for graphing.
  - `Python` has an extensive graphing library, `matplotlib`, which could be used to generate the required graphs. Additionally, a further library, `openpyxl`, exists which can be used to easily manipulate Excel spreadsheets.
  - The code underpinning the `matplotlib` library is `MATLAB`, hence making it itself a strong candidate for graph generation. Further, its import wizard would ease handling the spreadsheet as the data could be simply imported into a `MATLAB` matrix, and the data plotted with minimal effort. 

These graphs will be analysed to pinpoint any trends they convey. In particular, I will determine at what error probability these designs begin to fail in correcting errors.

## Timetable


## Resources & Risks
### Resources
The project requires use of a computer and a simulation software capable of supporting `SystemVerilog`. At the time of writing, I have emailed the SCRTP facilities team to enquire if they have such software and whether I could be granted use, but they have not yet responded. In the event that either I am not given access, or they do not possess the software, I will look into acquiring a license myself.

### Risks
The primary device that will be used during the project is my personal laptop, therefore, there is a risk of losing progress in the event of system failure. Using git and GitHub will not only allow the project to be downloaded onto another system, but it also provides version control in the event that work needs to be undone. To reduce the impact of data loss, the repository will be synced, at minimum, weekly with the local machine; though this may happen more frequently if waiting for a full week would increase the risk of significant loss (e.g., I was particularly productive on a day and complete a large portion of the code). Secondary machines capable of supporting the project are available in both the School of Engineering and Department of Computer Science Computer Labs.

## Legal, Social, Ethical and Professional Issues & Considerations
No such issues have been identified.
