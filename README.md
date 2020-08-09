# MicroDynamics
MicroDynamics is a pipeline for delineating community dynamics of human microbiome associated with disease progression.
# Setup
The setup process for the proposed pipeline requires the following steps:
## Download pipeline
```bash
git clone https://github.com/liluacrobat/MicroDynamics.git
```
# Usage
## Input
There are two input files for the MicroDynamics pipeline including an OTU table and a meta file of disease behavior. The following example is a human gut microbiom data set of Crohn's disease
### OTU table of 16S rRNA sequences
```bash
  Sample_1 Sample_2 Sample_3
OTU1  15  30  12
OTU2  152 116 130
OTU3  27  208 74
```
### Meta file of disease behavior
```bash
Sample_ID Disease_behavior
Sample_1  HC
Sample_2  B1
Sample_3  B2/B3
```

## Running
### 1. Prepare microbial data

### 2. Feature selection

### 3. Random sampling based consensus clustering

### 4. Embedded structuring learning

## Output

# Example
We provide two files of a human gut microbiome data set [1] in the example directory: a OTU table file CD_16S_OTU, a meta data file CD_meta_clinic. We can learn a microbial progression model by running MicroDynamics.m file.

# Reference
