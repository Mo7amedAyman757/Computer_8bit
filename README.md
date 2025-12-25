# 🖥️ Mano Basic Computer (RTL Design)
## 📌 Overview
The computer instruction is a binary code the specifies sequence of microperation for the computer. Instruction codes together with data are stored in memory. 
The computer reads each instruction from memory and places it in a control register. The control then interpret the binary code of the instruction and proceeds 
to execute it by using it own unique instruction set.
The instruction code is a group of bits that instruct the computer to perform specific operation. It is usually divided into parts, each having its own particular 
interpretation. The most basic part of an instruction is the op-code.
The opcode is a group of bits that define such operations as add, mul, shift, and etc....
The number of bits required for the operation code of an instruction code depend on the total number of operations available in the computer.
The oparation code consist of n-bits for a given (2^n) operations.
The simplest way to organize a computer is to have **one processor register and an instruction code format with two parts**. The first part specifies the **operation**
to be performed and the second specfies an **address**. The memory address tells the control where to find an operand in memory. This operand is from read from memory
and used as the data to be operated on together with the data stored in the processor register.
We have a **memory (4KB x 16) of 4096 locations (4KB)** so we need 12-bits to specify an address. each location is a word (16-bit). 
If we store each instruction code in one 16-bit memory word, we have available 4 bits for the operation code.
The control reads a 16-bit from the program portion of memory. It uses the 12-bit address part of the instruction to read a 16-bit
oparand from the data portion of memory


<img width="655" height="459" alt="Screenshot 2025-12-25 164645" src="https://github.com/user-attachments/assets/885927f5-7172-46ba-b865-6ae3dcf7968c" />

## 🧠 Indirect address
It is sometimes convenient to use the address bits of instruction code not as an address but as the actual operand. When the second part of an
instruction code specifies an oparand, the instruction is said to have an immediate operand. When the second part specifies the address of an 
operand, the instruction is said to have a direct address. This is in contrast to a third possibility called indirect address, where the bits in
the second part of the instruction designate an address of a memory word which the address of the address of the operand.
One bit is of the instruction code can be used to distinguish between a direct and indirect address.


<img width="693" height="715" alt="Screenshot 2025-12-25 170645" src="https://github.com/user-attachments/assets/14993b34-f0a8-4fcc-910d-c59fd96b3281" />

## 🧠 Computer Registers
The computer needs processor registers for manipulating data and a register for holding a memory address.
List of registers for the Basic Computer
| Register symbol | Number of bits | Register name        | Function
|      DR         |      16        | Data register        | Hold memory operand
|      AR         |      12        | Address register     | Hold Address of memory
|      AC         |      16        | Accumulator          | processor register
|      IR         |      16        | Instruction register | Hold Instruction code
|      PC         |      12        | Program counter      | Hold address of instruction
|      TR         |      16        | Temporary register   | Hold Temporary data
|      INPR       |      8         | Input register       | Hold input character
|      OUTR       |      8         | Output register      | Hold output character

## 🧠 Complete scheme for the connection of the registers and memory of the basic computer to a common bus system

Paths must be provided to transfer information from one register to another and between memory and registers. The number
of wire will be excessive if connections are made between the outputs of each register and the inputs of the other registers.
We will know how to construct a bus system using multiplexers or three-state buffer gates to make the connections are more 
efficient.

<img width="827" height="554" alt="Screenshot 2025-12-25 180106" src="https://github.com/user-attachments/assets/0ee62892-7c79-4e89-8be2-a1c636f87d3f" />


## 🧠 Computer Instruction
The basic computer has three instruction format. Each format has 16-bits. The operation code part of the instruction contains 3-bits and the meaning of 
the remaining 13-bits depends on the code encountered. 
We have 3 instruction format:
  - Memory reference instruction uses 12-bits to specify an address and the MSB to speicfy the addressing mode.
