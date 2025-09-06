# Five-Stage-Pipelined-RISC-V-Processor
# Pipelined RISC-V Processor Verification with Tracer

This repository contains the **design and verification** of a **5-stage pipelined RISC-V RV32I processor** with hazard handling and tracer integration.  
The project was part of **Digital Design Verification Lab #25**.

---

## 📖 Overview
- **ISA Implemented**: RISC-V RV32I (R, I, S, B, U, J instructions)  
- **Processor Type**: 5-stage pipelined CPU  
- **Verification Tool**: Cadence Xcelium  
- **Tracer IP**: Used to validate processor execution against expected results  

---

## ⚙️ Features
- **Pipeline Stages**:
  1. Instruction Fetch (IF)  
  2. Instruction Decode (ID)  
  3. Execute (EX)  
  4. Memory (MEM)  
  5. Writeback (WB)  

- **Hazard Handling**:
  - **Data Hazards** → Forwarding Unit  
  - **Control Hazards** → Hazard Detection Unit for stalls and pipeline flush  
  - **Branch Decision** → Moved from Decode to Execute stage (introduces 2-cycle branch penalty)  

- **Tracer Integration**:
  - Compares actual execution with reference outputs  
  - Reports **matches and mismatches**  

---

## 🧪 Verification
Three tests were run on the pipelined processor:

1. **Test 1**  
   - Output waveform of Register File  
   - Output waveform of Data Memory  

2. **Test 2**  
   - Output waveform of Register File  
   - Output waveform of Data Memory  

3. **Tracer Test**  
   - End-to-end verification of processor correctness using tracer IP  
