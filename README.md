# MicroDynamics
MicroDynamics is a pipeline for delineating community dynamics of human microbiome associated with disease progression.
## Setup
The setup process for the proposed pipeline requires the following steps:
### Download the pipeline
```bash
git clone https://github.com/liluacrobat/MicroDynamics.git
```
### Requirement
The following software is required
* MATLAB

## Usage
### Input
There are two input files for the MicroDynamics pipeline including an OTU table and a meta file of disease behavior. The following example is a human gut microbiom data set of Crohn's disease. 
#### OTU table of 16S rRNA sequences
```bash
OTU_ID Sample_1 Sample_2 Sample_3
OTU1  15  30  12
OTU2  152 116 130
OTU3  27  208 74
```
#### Meta file of disease behavior
```bash
Sample_ID Disease_behavior
Sample_1  HC
Sample_2  Penetrating (B3)
Sample_3  Inflammatory (B1)
```

### Running
#### 1. Preprocesssing
Load the OTU table and meta data. Exclude samples without enough sequencing depth (default:10,000). 
```
[Table_otu, Table_clinic] = script_data_processing(filen_otu, file_meta, params)
```
##### Optional argument  
```
params  : parameters
      -- min_count
           Number of observation (sequence) count to apply as the minimum
           total observation count of a sample for that sample to be retained.
           If you want to include samples with sequencing depth higher than
           or equal to 10,000, you specify 10,000. [default: 10,000]
      -- pseudo_count
           A small number added to the relative abundance before 10-base log
           transformation. [default: 10^-6]
      -- last_tax
           Flag of whether the last column of the OTU table is taxonomy
           or not. If the last column of the table is the taxonomy, you
           specify 1. [default: 0]
      -- col_label
           The Column of the clinical information used for feature
           selection
      -- mapping
           Mapping from class categories to numerical labels
```
#### 2. Feature selection
Feature selection within LOGO framework.
```
Feature_Table = script_feature_LOGO(Table_otu, Table_clinic, params)
```
#### 3. Random sampling based consensus clustering

#### 4. Embedded structuring learning

#### 5. Visualization

## Example
We provide two tab delimited files of a human gut microbiome data set [1] in the example directory: a OTU table file CD_16S_OTU.txt, and a meta data file CD_meta_clinic.txt. 

Due to the storage limitation of GitHub please download the CD_16S_OTU.tsv file from https://drive.google.com/file/d/1OhjjGS5Kw5G4ImOlzy8G8HluHM1aNjUN/view?usp=sharing and put the file under the 'example/data' directory. 

Then, we can learn a microbial progression model by running Demo_MicroDynamics.m. The precalculated results are stored in the directory 'example/precalculated/'

## Reference
[1] Halfvarson, Jonas, Colin J. Brislawn, Regina Lamendella, Yoshiki Vázquez-Baeza, William A. Walters, Lisa M. Bramer, Mauro D'amato et al. "Dynamics of the human gut microbiome in inflammatory bowel disease." *Nature Microbiology* 2, no. 5 (2017): 1-7.
