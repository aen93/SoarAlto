# ALTO: AOL-based Layered Tiering Orchestration

## Overview

ALTO is an AOL-based page migration regulation policy. It extends existing
tiering mechanisms to filter out unnecessary page promotions for improved
performance.

## System Components

ALTO integrates with four major tiering systems, each providing both baseline
functionality and ALTO-enhanced features:

### 1. Colloid (`colloid/`)
- **Patches**:
  - `colloid-skx.patch`: Base Colloid implementation (over TPP) for Skylake architecture
  - `colloid-skx-alto.patch`: ALTO extensions for userspace promotion control

### 2. Linux NUMA Balancing Tiering (`nbt/`)
- **Patches**:
  - `nbt.patch`: NBT implementation (NBT is included in default Linux)
- **Note**: NBT functionality is available in mainline Linux, requiring only ALTO extensions

### 3. Nomad (`nomad/`)
- **Patches**:
  - `nomad.patch`: Base Nomad tiering system
  - `nomad-alto.patch`: ALTO integration for promotion regulation

### 4. TPP (`tpp/`)
- **Patches**:
  - `tpp.patch`: Base TPP implementation
  - `tpp-alto.patch`: ALTO extensions for fine-grained control

## Directory Structure

```
src/alto/
├── README.md              # This documentation
├── colloid/              # Colloid tiering system
│   ├── colloid-skx.patch
│   ├── colloid-skx-alto.patch
│   └── compile.sh
├── nbt/                  # NUMA Balancing Tiering
│   ├── nbt.patch
│   └── compile.sh
├── nomad/                # Nomad async promotion
│   ├── nomad.patch
│   ├── nomad-alto.patch
│   └── compile.sh
└── tpp/                  # TPP
    ├── tpp.patch
    ├── tpp-alto.patch
    └── compile.sh
```

## Compilation and Installation

Each subdirectory contains a `compile.sh` script for building and installing the corresponding kernel with patches applied.

### Prerequisites
```bash
# Ensure you have kernel build dependencies
sudo apt-get install build-essential libncurses-dev bison flex libssl-dev libelf-dev

# Clone Linux kernel source (if not already available)
git clone https://github.com/torvalds/linux.git
```

### Build Process
1. **Navigate to desired system directory**:
   ```bash
   cd src/alto/colloid/  # or nbt/, nomad/, tpp/
   ```

2. **Review compilation script**:
   ```bash
   cat compile.sh  # Check kernel version and patch requirements
   ```

3. **Execute compilation**:
   ```bash
   chmod +x compile.sh
   ./compile.sh
   ```

### Compilation Steps (Automated)
Each `compile.sh` script performs the following operations:
1. Switches to appropriate kernel version (e.g., v6.3)
2. Applies base system patches
3. Applies ALTO extension patches
4. Configures kernel with `make oldconfig`
5. Builds kernel and modules
6. Installs modules and kernel
7. Updates bootloader configuration

## Usage Instructions

### 1. Kernel Installation
After successful compilation, reboot into the ALTO-enabled kernel:
```bash
sudo reboot
# Select the newly installed kernel from GRUB menu
```

### 2. Runtime Configuration
ALTO-enabled systems expose additional interfaces in `/proc` and `/sys`:
- Page promotion controls
- Tiering policy configuration
- Performance monitoring interfaces

### 3. Workload Integration
Refer to the [run directory](../../run) for:
- Workload execution scripts
- Performance monitoring tools
- Configuration examples
- Benchmark suites
