# Internet Technologies

**University:** Universidad Loyola, Seville - Spain <br>
**Course:** Computer Architecture <br>
**Semester:** 3rd semester <br>
**Mentor:** Prof. James Brian Romaine <br>
**Student:** Ron Ismaili <br>

# Mini ARM CPU

The initial goal of this project was to write the code for a functioning (although slightly reduced) single cycle ARM CPU using VHDL. We would have then implemented this CPU on one of the MiniZed (FPGA) boards. Unfortunately time was not on our side and the semester finished before we were able to implement the software into hardware, therefore this project exists only in software.

In this repository you will find only the final files of this project (LAB 8).

LABs 1-2 served as an introduction to VHDL. <br>
LABs 3-6 were for the Instruction Memory, ALU, Data Memory, Register File and connection of all components, respectively. <br>

LAB 8 was the final LAB and its purpose was to create the control logic of the CPU and to optimize some last remaining details.

This CPU is capable of 2 types of instructions: Data-processing instructions and memory (addressing) instructions. <br>
In total, my CPU supports 12 different instructions (tested and fully functioning):
- Addition using an immediate value.
- Subtraction using an immediate value.
- Addition using a non-shifted second register.
- Subtraction using a non-shifted second register.
- Bitwise AND using an immediate value.
- Bitwise OR using an immediate value.
- Bitwise AND using a non-shifted second register.
- Bitwise OR using a non-shifted second register.
- Store instruction using an immediate offset.
- Load instruction using an immediate offset.
- Store instruction using a non-shifted register offset.
- Load instruction using a non-shifted register offset.

For a deep dive and detailed explanation of the CPU feel free to check out the documentation I have written for this project.

This project took a lot of time and effort to complete but thanks to this project I have a much better understanding of how hardware description languages, integrated circuits, CPUs (duh) and embedded systems function.
