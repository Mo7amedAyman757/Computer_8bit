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
List of registers for the Basic Computer:


<img width="573" height="243" alt="Screenshot 2025-12-25 223054" src="https://github.com/user-attachments/assets/fadd7372-5524-4e41-8232-a14b2aa46bd4" />


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
  - Register reference instruction are recognised by the operation code 111 with a 0 in the MSB (bit-15) of the instruction.
  - Input-Output instruction is recognised by the operation code 111 with a 1 in the MSB (bit-15) of the instruction.


    <img width="535" height="326" alt="Screenshot 2025-12-26 002653" src="https://github.com/user-attachments/assets/4d602765-7267-48e5-9018-7d1a75cf2586" />


The total number of instruction chosen for the basic computer is equal to 25:


<img width="545" height="639" alt="Screenshot 2025-12-26 002849" src="https://github.com/user-attachments/assets/126d1e76-fdc1-4719-bf1e-5c77a1ee4bfb" />


## 🧠 Timing and Control

The timing for all registers in the basic computer is controlled by a master clock generator. The clock pulse are aplied to all flip-flops and registers 
in the systems, including the flip-flops and registers in the control unit.
The control signals are generated in the control unit and provide control inputs for common bus, processor registers, and microoperations for the accumulator.
We have two majors types of control organization:
  - hardwired control
  - microprogrammed control

  ### hardwired control
  The control logic is implemented with gates, flip-flops, decoders and other digital logic. It has advantage as it produces a fast mode operation but it
  requires changes in the wiring among the various component if the design has to bo modified or changed.

  ### microprogrammed control
  The control logic is stored in a control memory. The control memory is programmed to initiate the required sequence of microoperations. It has advantage as 
  any required changes or modifications can be done by updating the microprogram in control memory

## 🧠 Control unit

The first building block consists of 2 decoders, a sequence counter, and a number of control logic gates.
The instruction register is divided into 3 parts: the I-bit, the operation code, and bits 0 through 11. The opartion code in bits 12 through 14 are decoded
with a 3x8 decoder. The 8-outputs of the decoder are designated by the symbol D0 through D7. Bit-15 of the instruction is transferred to a flip-flop designated
by the symbol I. Bits 0 through 11 are applied to the control logic gates.
The 4-bit sequence counter can count in binary from 0 through 15. The outputs of the counter are decoded into 16 timing signals T0 through T15.


<img width="683" height="701" alt="Screenshot 2025-12-26 012029" src="https://github.com/user-attachments/assets/4c9c8690-75ae-4a8c-bb5b-84e285f29324" />


The waveform of control timing signals:


<img width="624" height="543" alt="Screenshot 2025-12-26 012216" src="https://github.com/user-attachments/assets/91cfd704-d224-4c4c-b4e6-ec4c7ccc88b1" />


## 🧠 Design of Basic Computer
The basic computer consists of the following hardware components:
 1- Memory unit with 4095 words of 16-bit each
 2- Eight registers: AR, PC, DR, AC, IR, TR, OUTR, INPR
 3- Seven flip-flops: I, S, E, R, IEN, FGI and FGO
 4- Two decoders: 3x8 operation decoder and 4x16 timing decoder
 5- 16-bit common bus
 6- control logic gates
 7- Adder and logic circuit connected to the input of AC

