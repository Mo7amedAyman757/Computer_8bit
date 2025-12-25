The computer instruction is a binary code the specifies sequence of microperation for the computer. Instruction codes together with data are stored in memory. 
The computer reads each instruction from memory and places it in a control register. The control then interpret the binary code of the instruction and proceeds 
to execute it by using it own unique instruction set.
The instruction code is a group of bits that instruct the computer to perform specific operation. It is usually divided into parts, each having its own particular 
interpretation. The most basic part of an instruction is the op-code.
The opcode is a group of bits that define such operations as add, mul, shift, and etc....
The number of bits required for the operation code of an instruction code depend on the total number of operations available in the computer.
The oparation code consist of n-bits for a given (2^n) operations.
The simplest way to organize a computer is to have one processor register and an instruction code format with two parts. The first part specifies the operation
to be performed and the second specfies an address. The memory address tells the control where to find an operand in memory. This operand is from read from memory
and used as the data to be operated on together with the data stored in the processor register.
We have a memory (4KB x 16) of 4096 locations (4KB) so we need 12-bits to specify an address. each location is a word (16-bit). 
If we store each instruction code in one 16-bit memory word, we have available 4 bits for the operation code.
The control reads a 16-bit from the program portion of memory. It uses the 12-bit address part of the instruction to read a 16-bit
oparand from the data portion of memory


<img width="655" height="459" alt="Screenshot 2025-12-25 164645" src="https://github.com/user-attachments/assets/885927f5-7172-46ba-b865-6ae3dcf7968c" />
