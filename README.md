# Microprocessor
This repo contains a program that simulates a Turing Complete microprocessor and so is programmable with an instruction set.  It is programmable with the LC3 instruction 
set and serves up to 15 unique opcodes (instructions). The vmh file is an instruction set that the processor can receive.  


# About
Rather than being useful, this project is more of a show-and-tell. A processor consists of 
a controller, a datapath, and a register file so that it may carry out instructions. 

# Controller
This is described in the PUnCControl.v and controls the state that the processor is in. 
For example, is it in a decode state, fetch state, or add state? It also controls the next state.
This information is sent to the datapath. 

# Datapath
This is describd in the PUnCDatapath.v and does all the data manipulation. For example, if 
the controller tells it to add, it takes the appropriate bits and adds them together and stores them
in a register. 

# Testing
This is described in the PUnC.t.v and tests all of the instructions that may program
this processor. These tests (in .vmh files) are not contained in this repo except for one:
the modulus test. These vmh files use the LC3 instruction set that this processor is able to 
read. Quite fascinating to see how the processor works and how they are programmable.
Don't worry, all test cases pass. 

# Other
RegisterFile.v serves as the register file where a lot of values and intermediate
values are stored, and Memory.v serves as the processor's memory. Defines.v is just
where I keep a lot of defines to keep things readable and simpler. All other files 
are just intermediate files created during and for compilation. 

